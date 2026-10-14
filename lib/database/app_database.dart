import 'package:fokus/const.dart';
import 'package:fokus/database/tables/tags.dart';
import 'package:fokus/database/tables/app_settings.dart';
import 'package:fokus/database/tables/session_records.dart';
import 'package:fokus/database/tables/session_record_tags.dart';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' as material;

part 'app_database.g.dart';

@DriftDatabase(tables: [Tags, SessionRecords, SessionRecordTags, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => Const.config.schemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.addColumn(tags, tags.goal);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: Const.config.databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
