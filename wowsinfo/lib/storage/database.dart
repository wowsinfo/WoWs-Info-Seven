import 'package:logging/logging.dart';
import 'package:wowsinfo/storage/backend.dart';

class Database {
  /// The shared instance of the database.
  static final Database instance = Database._init();
  Database._init();

  final _backend = Backend();
  final _log = Logger('Database');

  /// Initialize the database and its backend.
  Future<bool> initialize() async {
    final loaded = await _backend.load();
    _log.info('Database loaded: $loaded');
    return loaded;
  }
}
