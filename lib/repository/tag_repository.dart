import 'package:drift/drift.dart';
import 'package:fokus/database/app_database.dart';

class TagRepository {
  final AppDatabase _db;

  TagRepository(this._db);

  /// Save (create or update) this tag
  Future<int> save(Tag tag) async {
    int tagId = tag.id;
    if (tagId == 0) {
      // Create a new object
      tagId = await _db
          .into(_db.tags)
          .insert(tag.toCompanion(false).copyWith(id: Value.absent()));
    } else {
      // Update an existing object
      await _db.update(_db.tags).replace(tag);
    }

    return tagId;
  }

  /// Delete this tag
  Future<void> delete(Tag tag) async {
    await (_db.delete(_db.tags)..whereSamePrimaryKey(tag)).go();
  }

  /// Get all tags
  Future<List<Tag>> getAll() async {
    return _db.select(_db.tags).get();
  }

  /// Get all tags in a stream, constantly updated
  Stream<List<Tag>> getAllStream() {
    return _db.select(_db.tags).watch();
  }

  // TODO: figure out where this was used
  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) || other is Tag && id == other.id;
  // }

  // @override
  // int get hashCode => id.hashCode;
}
