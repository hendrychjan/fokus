import 'package:drift/drift.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 30)();

  /// Optional goal in minutes
  IntColumn get goal => integer().nullable()();

  /// Tag color (hex string consisting of two-digit components
  /// ALPHA-RED-GREEN-BLUE).
  ///
  /// Dart UI color is then created like so: `Color(tag.colorARGB)`
  IntColumn get colorARGB => integer()();
}
