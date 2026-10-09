import 'package:drift/drift.dart';
import 'package:fokus/database/tables/session_records.dart';
import 'package:fokus/database/tables/tags.dart';

class SessionRecordTags extends Table {
  IntColumn get sessionRecord => integer().references(SessionRecords, #id)();
  IntColumn get tag => integer().references(Tags, #id)();
}
