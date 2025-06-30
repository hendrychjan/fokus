import 'package:fokus/models/tag.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:isar/isar.dart';

part 'record.g.dart';

final db = AppController.to.isarService.db!;

@collection
class Record {
  late Id id = Isar.autoIncrement;

  /// Start of the time recording
  late DateTime start;

  /// End of the time recording
  late DateTime end;

  /// Optional comment on the record
  String? note;

  /// Optional record tag
  final tag = IsarLink<Tag>();

  /// Save (create or update) this record
  Future<void> save() async {
    await db.writeTxn(() async {
      await db.records.put(this);
    });
  }

  /// Delete this record
  Future<void> delete() async {
    await db.writeTxn(() async {
      await db.records.delete(id);
    });
  }

  /// Get all records
  static Future<List<Record>> getAll() async {
    return await db.records.where().findAll();
  }

  /// Get all records that ended today
  static Future<Duration> getAllToday() async {
    Duration durationToday = Duration.zero;

    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
      999,
    );

    List<Record> recordsToday = await db.records
        .filter()
        .endBetween(startOfToday, endOfToday)
        .findAll();

    for (var record in recordsToday) {
      durationToday += record.end.difference(record.start);
    }

    return durationToday;
  }

  /// Get all tags in a stream, constantly updated
  static Stream<List<Record>> getAllStream() async* {
    yield* db.records.where().watch(fireImmediately: true);
  }
}
