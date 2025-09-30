import 'package:fokus/models/tag.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:isar/isar.dart';

part 'tag_goal.g.dart';

final db = AppController.to.isarService.db!;

@collection
class TagGoal {
  late Id id = Isar.autoIncrement;

  /// Minutes to satisfy the goal
  late int targetMinutes;

  /// Weekday numbers the goal applies to
  /// (weekday numbers in accordance with ISO 8601, meaning 1...7 Mon...Sun)
  List<int> weekdays = [];

  /// Title of the goal
  late String title;

  /// Last time the goal got marked as ignored on the home page
  DateTime lastIgnored = DateTime.fromMillisecondsSinceEpoch(0);

  final tag = IsarLink<Tag>();

  /// Get a map of tags and their goals that are favourited by the user and
  /// active for the current day
  static Future<List<TagGoal>> getActiveFavouritedGoals() async {
    List<TagGoal> res = [];

    return res;
  }
}
