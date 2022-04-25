import 'storage/database.dart';

/// This repository manages the user's settings, such as app & data language,
/// username & account id, app theme colour, game server, dark mode, etc.
class UserRepository {
  // The shared instance of the UserRepository.
  static final UserRepository instance = UserRepository._init();
  UserRepository._init();

  /// Database
  late final Database _database;
  void inject(Database database) {
    _database = database;
  }

  // TODO: Add more user settings here.
}
