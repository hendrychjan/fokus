import 'package:drift/drift.dart';
import 'package:fokus/database/app_database.dart';

class SessionRecordRepository {
  final AppDatabase _db;

  SessionRecordRepository(this._db);

  /// Get all session records
  Future<List<SessionRecord>> getAll() async {
    return _db.select(_db.sessionRecords).get();
  }

  /// Get all session records in a stream, constantly updated, sorted from the
  /// most recently finished
  Stream<List<SessionRecord>> getAllByDateStream() {
    return _db.select(_db.sessionRecords).watch();
  }

  /// Get all session records recorded today, in a stream
  Stream<List<SessionRecord>> getAllTodayStream() {
    final now = DateTime.now();

    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = startOfToday.add(const Duration(days: 1));

    return (_db.select(_db.sessionRecords)..where(
          (r) => r.sessionEnd.isBetweenValues(startOfToday, startOfTomorrow),
        ))
        .watch();
  }

  /// Get all tags for a session record
  Future<List<Tag>> getTags(SessionRecord sessionRecord) async {
    final tagIds =
        await (_db.selectOnly(_db.sessionRecordTags)
              ..addColumns([_db.sessionRecordTags.tag])
              ..where(
                _db.sessionRecordTags.sessionRecord.equals(sessionRecord.id),
              ))
            .map((row) => row.read(_db.sessionRecordTags.tag)!)
            .get();
    return (_db.select(_db.tags)..where((x) => x.id.isIn(tagIds))).get();
  }

  /// Updates a `sessionRecord` or creates it if it has `id` set to a 0
  /// and returns the affected record's id.
  Future<int> save(SessionRecord sessionRecord, {List<Tag>? tags}) async {
    return _db.transaction(() async {
      // Create/update session record
      int sessionRecordId = sessionRecord.id;
      if (sessionRecordId == 0) {
        // Create a new object
        sessionRecordId = await _db
            .into(_db.sessionRecords)
            .insert(
              sessionRecord.toCompanion(false).copyWith(id: Value.absent()),
            );
      } else {
        // Update an existing object
        await _db.update(_db.sessionRecords).replace(sessionRecord);

        // Clear existing tag relationships
        if (tags != null) {
          await (_db.delete(
            _db.sessionRecordTags,
          )..where((x) => x.sessionRecord.equals(sessionRecord.id))).go();
        }
      }

      // Save tag relationships
      if (tags != null) {
        await _db.batch((batch) {
          batch.insertAll(
            _db.sessionRecordTags,
            tags.map(
              (t) => SessionRecordTagsCompanion.insert(
                sessionRecord: sessionRecordId,
                tag: t.id,
              ),
            ),
          );
        });
      }

      return sessionRecordId;
    });
  }

  /// Delete a session record
  Future<void> delete(SessionRecord sessionRecord) async {
    await _db.transaction(() async {
      // Delete session record
      await (_db.delete(
        _db.sessionRecords,
      )..whereSamePrimaryKey(sessionRecord)).go();

      // Delete associated tag relationships
      await (_db.delete(
        _db.sessionRecordTags,
      )..where((x) => x.sessionRecord.equals(sessionRecord.id))).go();
    });
  }
}
