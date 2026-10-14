import 'dart:async';

import 'package:fokus/const.dart';
import 'package:fokus/database/app_database.dart';
import 'package:fokus/repository/app_settings_repository.dart';
import 'package:fokus/repository/session_record_repository.dart';
import 'package:fokus/repository/tag_repository.dart';
import 'package:fokus/services/session_service.dart';
import 'package:fokus/services/storage_service.dart';
import 'package:fokus/services/settings_service.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  /// Global shortcut to app controller singleton
  static AppController get to => Get.find<AppController>();

  /// Drift database service
  AppDatabase db = AppDatabase();

  // Repositories
  late final TagRepository tagRepository;
  late final SessionRecordRepository sessionRecordRepository;
  late final AppSettingsRepository appSettingsRepository;

  /// GetStorage (key-value database) database service
  StorageService storageService = StorageService();

  /// Session storage for centralized session control
  SessionService sessionService = SessionService();

  /// Theme service for centralized theme control
  SettingsService settingsService = SettingsService();

  // Session control
  final Rx<int> selectedTagIndex = Rx<int>(0);
  final Rx<bool> sessionIsRunning = Rx<bool>(Const.defaults.sessionIsRunning);
  final Rx<DateTime?> sessionStart = Rx<DateTime?>(Const.defaults.sessionStart);

  // Cached items
  final Rx<List<Tag>> cachedTags = Rx<List<Tag>>([]);
  final Rx<List<SessionRecord>> cachedSessionRecordsToday =
      Rx<List<SessionRecord>>([]);
  final Rx<Map<int, Duration>> cachedRecordedDurationsByTag =
      Rx<Map<int, Duration>>({});

  // Cache subscriptions
  late final StreamSubscription _tagsSubscription;
  late final StreamSubscription _sessionRecordsSubscription;

  AppController() {
    // Inject DB into repositories
    tagRepository = TagRepository(db);
    sessionRecordRepository = SessionRecordRepository(db);
    appSettingsRepository = AppSettingsRepository(db);
  }

  @override
  void onInit() {
    super.onInit();

    // Converts the following reactive streams of database objects into
    // a accessible synchronous getters
    _tagsSubscription = tagRepository.getAllStream().listen((tags) {
      cachedTags.value = tags;

      // Keep selected tag index inside bounds after any tag list change.
      if (tags.isEmpty) {
        selectedTagIndex.value = 0;
      } else if (selectedTagIndex.value >= tags.length) {
        selectedTagIndex.value = tags.length - 1;
      }
    });

    _sessionRecordsSubscription = sessionRecordRepository
        .getAllTodayStream()
        .listen((sessionRecordsToday) async {
          cachedSessionRecordsToday.value = sessionRecordsToday;

          // Build a fresh map and publish it once so observers never see a
          // half-recomputed state.
          final Map<int, Duration> recomputedDurations = {
            for (final tag in cachedTags.value) tag.id: Duration.zero,
          };

          for (final sessionToday in sessionRecordsToday) {
            final sessionDuration = sessionToday.sessionEnd.difference(
              sessionToday.sessionStart,
            );

            final sessionTags = await sessionRecordRepository.getTags(
              sessionToday,
            );
            for (final tag in sessionTags) {
              final current = recomputedDurations[tag.id] ?? Duration.zero;
              recomputedDurations[tag.id] = current + sessionDuration;
            }
          }

          cachedRecordedDurationsByTag.value = recomputedDurations;
        });
  }

  @override
  void onClose() {
    _tagsSubscription.cancel();
    _sessionRecordsSubscription.cancel();
    super.onClose();
  }

  /// Format a duration represented a `sec` seconds as a stopwatch resembling string
  static String formatDurationAsStopwatchFromSec(int sec) {
    Duration d = Duration(seconds: sec);
    return formatDurationAsStopwatch(d);
  }

  /// Format a duration as a stopwatch resembling string
  static String formatDurationAsStopwatch(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
