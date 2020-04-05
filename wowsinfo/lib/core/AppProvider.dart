import 'package:flutter/material.dart';

/// This provider handles color, brightness, locale changes and more
class AppProvider with ChangeNotifier {
  ThemeData _theme;
  ThemeData getTheme() => _theme;
  
  MaterialColor _color;
  Brightness _brightness;

  AppProvider(this._color, this._brightness) {
    _makeTheme();
  }

  setColor(MaterialColor data) {
    _color = data;
    _makeTheme();
    notifyListeners();
  } 

  setBrightness(Brightness data) {
    _brightness = data;
    _makeTheme();
    notifyListeners();
  }

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
