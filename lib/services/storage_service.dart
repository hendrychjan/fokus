import 'package:fokus/const.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  /// If GetStorage init task has been run
  bool _initialized = false;

  /// Session storage GetStorage box
  late GetStorage sessionBox;

  /// Initialize the GetStorage database engine for this service instance
  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize all containers
    await Future.wait([GetStorage.init(Const.storageKeys.boxSession)]);

    // Bind all boxes
    sessionBox = GetStorage(
      Const.storageKeys.boxSession,
      (await Const.defaults.applicationDirectory).path,
    );

    _initialized = true;
  }
}
