import 'package:get_storage/get_storage.dart';

class StorageService {
  /// If GetStorage init task has been run
  bool _initialized = false;

  /// Primary GetStorage box
  late GetStorage sessionBox;

  /// Initialize the GetStorage database engine for this service instance
  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize all containers
    await Future.wait([GetStorage.init("SessionBox")]);

    // Bind all boxes
    sessionBox = GetStorage("SessionBox");

    _initialized = true;
  }
}
