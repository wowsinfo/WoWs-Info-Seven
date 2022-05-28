import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/foundation/helpers/time_tracker.dart';

/// This repository manages localised strings from the Game Data
class Localisation {
  static const localizationsDelegates = AppLocalizations.localizationsDelegates;
  static const supportedLocales = AppLocalizations.supportedLocales;

  /// The wrapper of [AppLocalizations].
  static AppLocalizations of(BuildContext context) {
    final i10n = AppLocalizations.of(context);
    if (i10n == null) {
      throw Exception('AppLocalizations is not working as expected.');
    }

    return i10n;
  }

  /// The shared instance of [Localisation].
  static final Localisation instance = Localisation._init();
  Localisation._init();

  bool _initialised = false;
  final _logger = Logger('Localisation');

  /// This is a list of game languages World of Warships supports.
  static const _validGameLanguages = [
    'cs',
    'de',
    'en',
    'es',
    'es_mx',
    'fr',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'pt_br',
    'ru',
    'th',
    'tr',
    'uk',
    'zh', // This is used in the mainland server
    'zh_sg',
    'zh_tw',
  ];

  late final Map<String, Map<String, String>> _lang;
  late String _gameLang;

  /// Load wowsinfo.json from /gamedata/app/data/
  Future<void> initialise() async {
    if (_initialised) {
      _logger.severe('Localisation already initialised');
      throw Exception('Localisation is already initialised');
    }

    final timer = TimeTracker();

    // load the language file
    final langString = await rootBundle.loadString(
      'gamedata/app/lang/lang.json',
      cache: false,
    );
    timer.log(message: 'Loaded lang.json');

    final langObject = jsonDecode(langString);
    timer.log(message: 'Parsed lang.json');

    _lang = (langObject as Map).map((key, value) {
      return MapEntry(key, (value as Map).cast<String, String>());
    });
    // _gameLang = _decideLang(Platform.localeName);
    _gameLang = 'zh_sg';
    timer.log(message: 'Decoded lang.json');

    _initialised = true;
    _logger.info('Localisation initialised');
  }

  String _decideLang(String lang) {
    _logger.info('System locale is $lang');
    final langCode = lang.toLowerCase();
    if (_validGameLanguages.contains(langCode)) {
      return langCode;
    }

    if (langCode.contains('_')) {
      final localeCode = langCode.split('_')[0];
      if (_validGameLanguages.contains(localeCode)) {
        _logger.info('Using locale `$localeCode`');
        return localeCode;
      }
    }

    _logger.warning('Unsupported locale $langCode, falling back to en');
    return 'en';
  }

  /// Update the data language. The app language won't change.
  void updateDataLanguage(String language) {
    if (!_validGameLanguages.contains(language)) {
      _logger.severe('Invalid language $language');
      return;
    }
    if (_lang[language] == null) {
      _logger.warning('Language $language is not supported');
      return;
    }

    _gameLang = language;
  }

  /// Get the localized string by the key.
  /// Format the string with the given [constants].
  /// Pass in [prefix] if needed (It will be added to the key).
  String? stringOf(
    String? key, {
    Map<String, dynamic>? constants,
    String? prefix,
  }) {
    if (key == null) {
      _logger.severe('Key is null');
      return null;
    }

    if (_lang[_gameLang] == null) {
      _logger.severe('Language $_gameLang not found');
      return null;
    }

    var langKey = key.toUpperCase();
    if (prefix != null) {
      langKey = prefix + langKey;
    }
    final rawString = _lang[_gameLang]![langKey];
    if (rawString == null) {
      _logger.severe('Language key $langKey not found');
      return null;
    }

    if (constants == null || constants.isEmpty) {
      return rawString;
    }

    // put constants into the string if needed
    // check if value has %(key) in it
    var formattedString = rawString;
    final regex = RegExp(r'%\((.*?)\)s');
    final matches = regex.allMatches(rawString);
    for (final match in matches) {
      final key = match.group(1);
      if (key == null) {
        _logger.severe('Invalid match, key is null');
        continue;
      }

      // the key doesn't include _percent at the end
      final constantKey = key.replaceAll('_percent', '');
      var constantValue = constants[constantKey];
      _logger.fine('Constant $key = $constantValue');
      if (key.endsWith('_percent')) {
        final number = constantValue as num;
        // format to percentage
        constantValue = '${(number * 100).toDecimalString()}%';
      }

      formattedString = formattedString.replaceAll(
        '%($key)s',
        constantValue.toString(),
      );
    }

    return formattedString;
  }
}
