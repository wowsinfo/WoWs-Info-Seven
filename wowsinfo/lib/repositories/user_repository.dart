import 'storage/store_interface.dart';

/// This repository manages the user's settings, such as app & data language,
/// username & account id, app theme colour, game server, dark mode, etc.
class UserRepository {
  // Key values
  static const String _appLanguageKey = 'wowsinfo@app_language';
  static const String _dataLanguageKey = 'wowsinfo@data_language';
  static const String _usernameKey = 'wowsinfo@username';
  static const String _accountIDKey = 'wowsinfo@account_id';
  static const String _gameServerKey = 'wowsinfo@game_server';
  // by default, the app should follow the system.
  static const String _darkModeKey = 'wowsinfo@dark_mode';
  static const String _themeColourKey = 'wowsinfo@theme_colour';

  /// The shared instance of the UserRepository.
  static final UserRepository instance = UserRepository._init();
  UserRepository._init();

  // Store
  late final StoreInterface _store;
  void inject(StoreInterface store) {
    _store = store;
  }

  /// The app language, TODO: use system locale as the default here not English
  String get appLanguage => _store.get(_appLanguageKey) as String? ?? 'en';
  set appLanguage(String value) => _store.set(_appLanguageKey, value);

  /// The data language, TODO: same as above but need to make sure it is supported by the API
  String get dataLanguage => _store.get(_dataLanguageKey) as String? ?? 'en';
  set dataLanguage(String value) => _store.set(_dataLanguageKey, value);

  /// Check if a user is set as favourite
  bool get isFavourite => _store.has(_accountIDKey);

  /// The username of the user
  String get username => _store.get(_usernameKey) as String? ?? '';
  set username(String value) => _store.set(_usernameKey, value);

  /// The account id of the user
  String get accountID => _store.get(_accountIDKey) as String? ?? '';
  set accountID(String value) => _store.set(_accountIDKey, value);

  /// The current game server the app is using
  String get gameServer => _store.get(_gameServerKey) as String? ?? 'asia';
  set gameServer(String value) => _store.set(_gameServerKey, value);

  /// The current theme colour of the app
  String get themeColour => _store.get(_themeColourKey) as String? ?? 'blue';
  set themeColour(String value) => _store.set(_themeColourKey, value);

  /// Check if the app should be in dark mode
  bool get darkMode => _store.get(_darkModeKey) as bool? ?? false;
  set darkMode(bool value) => _store.set(_darkModeKey, value);
}
