import 'package:flutter/material.dart';

/// This provider handles color, brightness, locale changes and more
class AppProvider with ChangeNotifier {
  ThemeData _theme;
  ThemeData get theme => _theme;
  
  MaterialColor _color;
  Brightness _brightness;
  Locale _locale = Locale('en');
  Locale get locale => _locale;

  AppProvider(this._color, this._brightness, this._locale) {
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
