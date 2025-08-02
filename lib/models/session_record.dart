import 'package:fokus/models/tag.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:isar/isar.dart';

part 'session_record.g.dart';

final db = AppController.to.isarService.db!;

@collection
class SessionRecord {
  late Id id = Isar.autoIncrement;

  /// The start of the recorded session
  late DateTime sessionStart;

  /// The end of the recorded session
  late DateTime sessionEnd;

  /// An optional note to the recorded session
  late String? note;

  /// Tags for the session
  final tags = IsarLinks<Tag>();

  /// Save (create or update) this session record
  Future<void> save() async {
    await db.writeTxn(() async {
      tags.save();
      await db.sessionRecords.put(this);
    });
  }

  /// Load all link fields synchronously
  void loadSync() {
    tags.loadSync();
  }

  /// Delete this session record
  Future<void> delete() async {
    await db.writeTxn(() async {
      await db.sessionRecords.delete(id);
    });
  }

  /// Get all session records
  static Future<List<SessionRecord>> getAll() async {
    return await db.sessionRecords.where().findAll();
  }

  /// Get all session records in a stream, constantly updated
  static Stream<List<SessionRecord>> getAllStream() async* {
    yield* db.sessionRecords.where().watch(fireImmediately: true);
  }
}
