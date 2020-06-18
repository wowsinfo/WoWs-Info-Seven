import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// It manages app localization, mainly from https://www.youtube.com/watch?v=lDfbbTvq4qM
class AppLocalizationService {
  /// A list of supported locales
  static const List<Locale> supportedLocales = [
    // English
    const Locale('en'),
    // Japanese
    const Locale('ja'),
    // This is simplified
    const Locale.fromSubtags(languageCode: 'zh'),
    // Both traditional and simplified
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// A list of supported locale string (only locales but script code)
  static const List<String> supportedLocaleStrings = ['en', 'ja', 'zh'];
  static const delegate = _AppLocalizationDelegate();

  AppLocalizationService(this.locale);

  final Locale locale;
  Map<String, String> _strings;
  /// This will be called when the app needs a localised string
  String localised(String key) => _strings[key];

  /// Load the correct JSON file from disk
  Future<void> load() async {
    final jsonPath = 'assets/locales/localization_${getLocalFileName()}.json';
    final jsonString = await rootBundle.loadString(jsonPath);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    // Convert dynamic to String
    _strings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Access this class anywhere
  static AppLocalizationService of(BuildContext context) {
    return Localizations.of<AppLocalizationService>(context, AppLocalizationService);
  }

  /// If it has a script code like Chinese, it will merge the code and lang
  String getLocalFileName() {
    // It is not Chinese
    final code = locale.scriptCode;
    final lang = locale.languageCode;
    if (code == null) {
      // The default for Chinese is simplified
      if (lang == 'zh') return 'zh_Hans';
      return lang;
    }
    return '${lang}_$code';
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizationService> {
  /// It never changes
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizationService.supportedLocaleStrings.contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizationService> load(Locale locale) async {
    final localization = AppLocalizationService(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
