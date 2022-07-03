import 'package:flutter/material.dart';
import 'package:wowsinfo/repositories/user_repository.dart';

/// The top level provider of the entire app.
/// It is mostly used to update app theme, dark mode and app language.
class AppProvider with ChangeNotifier {
  late bool _darkMode;
  bool get darkMode => _darkMode;

  late AppThemeColour _themeColour;
  MaterialColor get themeColour => _themeColour.colour;

  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  late Locale _locale;
  Locale get locale => _locale;

  final UserRepository _userRepository = UserRepository.instance;

  AppProvider() {
    _darkMode = _userRepository.darkMode;
    _themeColour = AppThemeColour(index: _userRepository.themeColour);
    _themeData = _generateThemeData();
    _locale = Locale(_userRepository.appLanguage);
  }

  ThemeData _generateThemeData() {
    final color = _themeColour.colour;
    return ThemeData(
      primarySwatch: color,
      primaryColor: color,
      brightness: _darkMode ? Brightness.dark : Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(color),
      ),
    );
  }

  void updateDarkMode(bool darkMode) {
    _userRepository.darkMode = darkMode;
    _darkMode = darkMode;

    _themeData = _generateThemeData();
    notifyListeners();
  }

  void updateLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void updateThemeColour(MaterialColor colour) {
    _themeColour = AppThemeColour.fromColour(colour);
    _userRepository.themeColour = _themeColour.index;

    _themeData = _generateThemeData();
    notifyListeners();
  }
}
