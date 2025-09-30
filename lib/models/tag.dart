import 'package:fokus/models/tag_goal.dart';
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
  @Backlink(to: 'tag')
  final goals = IsarLinks<TagGoal>();

  @ignore
  List<TagGoal>? tempGoalsUpdate;

  /// Update the goals link based on the tempGoalsUpdate value
  ///
  /// NOTE: this is a fix for isar db's .save() method not being able to deal
  /// with objects that are not yet created in the database (even though the
  /// documentation says so: [issue](https://github.com/isar/isar/pull/1323/files?short_path=66a88df#diff-66a88df029346d56f169f077981e6fc61a2530f6d610decf717aa7980c752503))
  /// Once this issue is resolved, this whole function can be ommited.
  Future<void> _updateGoals() async {
    if (tempGoalsUpdate != null) {
      await db.writeTxn(() async {
        // Remove no longer attached goals
        for (var oldGoal in goals.toList()) {
          if (!tempGoalsUpdate!.map((g) => g.id).contains(oldGoal.id)) {
            goals.remove(oldGoal);
            db.tagGoals.delete(oldGoal.id);
          }
        }

        // Create newly attached goals
        for (var newOrUpdatedGoal in tempGoalsUpdate!) {
          if (!goals.toList().map((g) => g.id).contains(newOrUpdatedGoal.id)) {
            // Goal doesnt exist yet in the database - create it
            int newId = await db.tagGoals.put(newOrUpdatedGoal);
            newOrUpdatedGoal.id = newId;
            goals.add(newOrUpdatedGoal);
          } else {
            // Goal already exists, update it in the link
            goals.removeWhere((g) => g.id == newOrUpdatedGoal.id);
            db.tagGoals.put(newOrUpdatedGoal);
            goals.add(newOrUpdatedGoal);
          }
        }
      });
    }
  }

  /// Save (create or update) this tag
  Future<void> save() async {
    _updateGoals();

    // Save the goal itself
    await db.writeTxn(() async {
      await goals.save();
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

  /// Load all link fields
  Future<void> load() async {
    await goals.load();
  }

  /// Load all link fields synchronously
  void loadSync() {
    goals.loadSync();
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
}
