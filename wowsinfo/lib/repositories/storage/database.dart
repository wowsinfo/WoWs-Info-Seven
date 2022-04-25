import 'package:logging/logging.dart';
import 'backend.dart';
import 'backend_interface.dart';

class Database {
  final BackendInterface _backend = Backend();
  final _log = Logger('Database');

  Database() {
    _log.info('Database initialized');
  }

  /// Initialize the database and its backend.
  Future<bool> initialize() async {
    final loaded = await _backend.load();
    _log.info('Database loaded is $loaded');
    return loaded;
  }
}
