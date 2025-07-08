import 'package:fokus/models/category.dart';
import 'package:fokus/models/session_record.dart';
import 'package:fokus/models/tag.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// **!!!Add active schemas here!!!**
final List<CollectionSchema> schemas = [
  TagSchema,
  CategorySchema,
  SessionRecordSchema,
];

class IsarService {
  /// If Isar init task has been run
  bool _initialized = false;

  /// Isar database engine
  Isar? db;

  /// Initialize the Isar database engine (necessary prior to running any query)
  Future<void> initialize() async {
    if (_initialized) return;

    // Get the directory where Isar data files are stored
    final dir = await getApplicationDocumentsDirectory();

    // Open the Isar database
    db = await Isar.open(schemas, directory: dir.path);

    // Note that initialize is finished
    _initialized = true;
  }

  /// Check if the db engine has already been initialized
  bool isInitialized() {
    return _initialized;
  }
}
