import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/services/data/AppConfiguration.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';
import 'package:wowsinfo/core/services/storage/HiveStorage.dart';
import 'package:wowsinfo/core/utils/Utils.dart';

/// This includes app locale, theme colour and brightness (light, dark or system)
class AppSettingsManager with ChangeNotifier {
  // Handles how to save AppConfiguration
  BaseStorage _storage;

  AppConfiguration<String, AppBrightness> _brighness;
  AppConfiguration<String, AppThemeColour> _colour;
  AppConfiguration<String, AppLocale> _locale;

  ThemeData _theme;
  ThemeData _darkTheme;
  ThemeData get theme => _theme;
  ThemeData get darkTheme => _darkTheme;

  AppSettingsManager(this._storage) {
    _brighness = AppConfiguration(_storage, 'brightness');
    _colour = AppConfiguration(_storage, 'colour');
    _locale = AppConfiguration(_storage, 'locale');
  }

  /// This will update ThemeData
  _generateTheme() {
    final colour = _colour.value.colour;
    _theme = ThemeData(
      primarySwatch: colour,
    );

    _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: colour,
      accentColor: colour.shade500,
      indicatorColor: colour.shade500,
    );
  }
}

/// This saves the material app main theme colour
class AppThemeColour extends Cacheable {
  /// All material colour
  static const THEME_COLOUR_LIST = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    // Orange is removed
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  // This is the main theme colour
  MaterialColor _colour;
  MaterialColor get colour => _colour;
  set colour(MaterialColor c) {
    if (c == _colour) return;
    _colour = c;
  }

  AppThemeColour(Map<String, dynamic> json) : super(json) {
    this._colour = json['colour'];
  }

  @override
  bool isValid() => _colour != null;

  @override
  Map<String, dynamic> toJson() => {
    'colour': THEME_COLOUR_LIST.indexOf(_colour)
  };
}

/// This saves the material app's brightness
class AppBrightness extends Cacheable {
  /// light, dark or follow system
  static const THEME_BRIGHTNESS_MODE = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];

  // It is called ThemeMode but it is all about app brightness
  ThemeMode _brightness;
  bool get isDarkMode => _brightness == ThemeMode.dark;
  bool get isLightMode => _brightness == ThemeMode.light;
  ThemeMode get themeMode => _brightness;
  set brightness(ThemeMode b) {
    if (b == _brightness) return;
    _brightness = b;
  }

  AppBrightness(Map<String, dynamic> json) : super(json) {
    _brightness = THEME_BRIGHTNESS_MODE[json['brightness']];
  }

  @override
  bool isValid() => _brightness != null;

  @override
  Map<String, dynamic> toJson() => {
    'brightness': THEME_BRIGHTNESS_MODE.indexOf(_brightness),
  };
}

/// This saves the material app's main locel
class AppLocale extends Cacheable {
  // Locale can be null, it simply follows system!
  Locale _locale;
  Locale get locale => _locale;
  set locale(Locale l) {
    if (l == _locale) return;
    _locale = l;
  }

  AppLocale(Map<String, dynamic> json) : super(json) {
    final code = json['locale'];
    if (code != null) {
      if (code.contains('_')) {
        final codes = code.split('_');
        _locale = Locale.fromSubtags(countryCode: codes[0], scriptCode: codes[1]);
      } else {
        _locale = Locale(code);
      }
    }
  }

  
  /// Convert locale object to a string
  String _localeToCode() {
    final scriptCode = _locale.scriptCode;
    final langCode = _locale.languageCode;
    if (scriptCode != null) return langCode + '_' + scriptCode;
    return langCode;
  }

  @override
  bool isValid() => true;

  @override
  Map<String, dynamic> toJson() => {
    'locale': _localeToCode(),
  };
}
