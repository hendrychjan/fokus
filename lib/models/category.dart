import 'package:fokus/services/app_controller.dart';
import 'package:isar/isar.dart';

part 'category.g.dart';

final db = AppController.to.isarService.db!;

@Collection(accessor: "categories")
class Category {
  late Id id = Isar.autoIncrement;

  /// Title of the category
  late String title;

  /// Save (create or update) this category
  Future<void> save() async {
    await db.writeTxn(() async {
      await db.categories.put(this);
    });
  }

  /// Delete this category
  Future<void> delete() async {
    await db.writeTxn(() async {
      await db.categories.delete(id);
    });
  }

  /// Get all tags
  static Future<List<Category>> getAll() async {
    return await db.categories.where().findAll();
  }

  /// Get all categories in a stream, constantly updated
  static Stream<List<Category>> getAllStream() async* {
    yield* db.categories.where().watch(fireImmediately: true);
  }
}
