import 'package:drift/drift.dart';

class SessionRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get sessionStart => dateTime()();
  DateTimeColumn get sessionEnd => dateTime()();
  TextColumn get note => text().nullable()();
}
