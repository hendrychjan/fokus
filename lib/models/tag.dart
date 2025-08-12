import 'package:fokus/services/app_controller.dart';
import 'package:isar/isar.dart';

part 'tag.g.dart';

final db = AppController.to.isarService.db!;

@collection
class Tag {
  late Id id = Isar.autoIncrement;

  /// Title of the tag
  late String title;

  /// Tag color (hex string consisting of two-digit components
  /// ALPHA-RED-GREEN-BLUE).
  ///
  /// Dart UI color is then created like so: `Color(tag.colorARGB)`
  late int colorARGB;

  /// Goals for the tag
  List<TagGoal> goals = [];

  /// Save (create or update) this tag
  Future<void> save() async {
    await db.writeTxn(() async {
      await db.tags.put(this);
    });
  }

  /// Delete this tag
  Future<void> delete() async {
    await db.writeTxn(() async {
      await db.tags.delete(id);
    });
  }

  /// Get all tags
  static Future<List<Tag>> getAll() async {
    return await db.tags.where().findAll();
  }

  /// Get all tags synchronously
  /// (viable only when the number of tags in db is low)
  static List<Tag> getAllSync() {
    return db.tags.where().findAllSync();
  }

  /// Get all tags in a stream, constantly updated
  static Stream<List<Tag>> getAllStream() async* {
    yield* db.tags.where().watch(fireImmediately: true);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Tag && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

@embedded
class TagGoal {
  /// Minutes to satisfy the goal
  late int targetMinutes;

  /// Weekday numbers the goal applies to
  /// (weekday numbers in accordance with ISO 8601, meaning 1...7 Mon...Sun)
  List<int> weekdays = [];

  /// Title of the goal
  late String title;
}
