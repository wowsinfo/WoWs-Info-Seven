import 'package:flutter/material.dart';

/// This provider handles color, brightness, locale changes and more
class AppProvider with ChangeNotifier {
  ThemeData _theme;
  ThemeData get theme => _theme;
  
  // By default, theme colour is blue, light mode and locale is just null (follow system)
  MaterialColor _color = Colors.blue;
  Brightness _brightness = Brightness.light;
  Locale _locale;
  Locale get locale => _locale;

  AppProvider() {
    // Load data from local storage
    // TODO
    _makeTheme();
  }

  setColor(MaterialColor data) {
    _color = data;
    _makeTheme();
    notifyListeners();
  } 

  setLocale(Locale data) {
    _locale = data;
    notifyListeners();
  } 

  setBrightness(Brightness data) {
    _brightness = data;
    _makeTheme();
    notifyListeners();
  }

  /// Update theme with current colour and brightness
  _makeTheme() {
    if (_brightness == Brightness.light) {
      _theme = ThemeData(
        primarySwatch: _color,
      );
    } else {
      _theme = ThemeData(
        brightness: _brightness,
        primarySwatch: _color,
        accentColor: _color.shade500,
        indicatorColor: _color.shade500,
      );
    }
  }
}
