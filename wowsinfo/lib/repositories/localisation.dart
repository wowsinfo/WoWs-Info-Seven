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
  static const validGameLanguages = [
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
    'zh', // TODO: do we need this or simply use zh_sg instead?
    'zh_sg',
    'zh_tw',
  ];

  /// This is a list of supported game languages in the app.
  /// TODO: we can add more languages, but it will dramatically increase the size of the app.
  late final supportedGameLanguages = _lang.keys.toList(growable: false);

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
    _gameLang = _decideLang(Platform.localeName);
    timer.log(message: 'Decoded lang.json');

    _initialised = true;
    _logger.info('Localisation initialised');
  }

  /// Decide the data language based on the device language.
  String _decideLang(String lang) {
    _logger.info('System locale is $lang');
    final langCode = lang.toLowerCase();
    if (validGameLanguages.contains(langCode)) {
      return langCode;
    }

    if (langCode.contains('_')) {
      final localeCode = langCode.split('_')[0];
      if (validGameLanguages.contains(localeCode)) {
        _logger.info('Using locale `$localeCode`');
        return localeCode;
      }
    }

    _logger.warning('Unsupported locale $langCode, falling back to en');
    return 'en';
  }

  /// Update the data language. The app language won't change.
  void updateDataLanguage(String language) {
    if (!validGameLanguages.contains(language)) {
      _logger.severe('Invalid language $language');
      return;
    }
    if (_lang[language] == null) {
      _logger.warning('Language $language is not supported');
      return;
    }

    _logger.info('Updating data language to $language');
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

  /// Predefined strings

  static const _shipFilter = 'IDS_CAROUSEL_APPLIED_FILTER_HINT_';
  String get regionFilterName => _get('nation', prefix: _shipFilter);
  String get shipNameFilterName => _get('shipname', prefix: _shipFilter);
  String get shipTypeFilterName => _get('shiptype', prefix: _shipFilter);
  String get tierFilterName => _get('level', prefix: _shipFilter);

  static const _moduleType = 'IDS_MODULE_TYPE_';
  String get hull => _get('HULL', prefix: _moduleType);
  String get artillery => _get('ARTILLERY', prefix: _moduleType);
  String get secondaries => _get('SECONDARYWEAPONS', prefix: _moduleType);
  String get torpedoes => _get('TORPEDOES', prefix: _moduleType);
  String get sonar => _get('SONAR', prefix: _moduleType);
  String get fireControl => _get('SUO', prefix: _moduleType);
  String get engine => _get('ENGINE', prefix: _moduleType);
  String get fighter => _get('FIGHTER', prefix: _moduleType);
  String get skipBomber => _get('SKIPBOMBER', prefix: _moduleType);
  String get torpedoBomber => _get('TORPEDOBOMBER', prefix: _moduleType);
  String get diveBomber => _get('DIVEBOMBER', prefix: _moduleType);

  static const _shipParam = 'IDS_SHIP_PARAM_';
  String get maximumRange => _get('MAX_DIST', prefix: _shipParam);
  String get reloadTime => _get('SHOT_DELAY', prefix: _shipParam);
  String get rotationTime => _get('ROTATION_TIME', prefix: _shipParam);

  // Durability
  String get durability => _get('DURABILITY', prefix: _shipParam);
  String get health => _get('HEALTH', prefix: _shipParam);
  String get torpedoProtection => _get('PTZDAMAGEPROB', prefix: _shipParam);

  // Main battery
  String get shipArtillery => _get('ARTILLERY', prefix: _shipParam);
  String get gunReloadTime => reloadTime;
  String get gunRotationTime => rotationTime;
  String get gunDamage => _get('ARTILLERY_MAX_DAMAGE', prefix: _shipParam);
  String get gunRange => maximumRange;
  String get shellVelocity => _get('ARTILLERY_AMMO_SPEED', prefix: _shipParam);
  String get shellPenetration =>
      _get('ARTILLERY_ALPHA_PIERCING', prefix: _shipParam);
  String get shellFireChance => _get('ARTILLERY_BURN_PROB', prefix: _shipParam);

  // Torpedo
  String get torpedoRange => _get('TORPEDOES_MAX_DIST', prefix: _shipParam);
  String get torpedoSpeed => _get('TORPEDO_SPEED', prefix: _shipParam);
  String get torpedoReloadTime => reloadTime;
  String get torpedoRotationTime => rotationTime;
  String get torpedoDamage => _get('TORPEDO_DAMAGE', prefix: _shipParam);
  String get torpedoDetection =>
      _get('TORPEDO_VISIBILITY_DIST', prefix: _shipParam);

  // AA
  String get airDefense => _get('AIR_DEFENSE', prefix: _shipParam);
  String get continousDamage =>
      _get('AA_AVERAGE_CONST_DAMAGE', prefix: _shipParam);
  String get airBubbleDamage =>
      _get('AA_BUBBLE_DAMAGE_IN_A_SECOND', prefix: _shipParam);
  String get aaRange => _get('AA_RANGE', prefix: _shipParam);

  // Mobility
  String get mobility => _get('MOBILITY', prefix: _shipParam);
  String get maxSpeed => _get('MAXSPEED', prefix: _shipParam);
  String get turningRadius => _get('TURNINGRADIUS', prefix: _shipParam);
  String get rudderTime => _get('RUDDER_TIME', prefix: _shipParam);

  // Visibility
  String get visibility => _get('VISIBILITY', prefix: _shipParam);
  String get seaDetection =>
      _get('VISIBILITY_DIST_BY_SHIP', prefix: _shipParam);
  String get airDetection =>
      _get('VISIBILITY_DIST_BY_PLANE', prefix: _shipParam);

  String get airSupport => _get('AIRSUPPORT', prefix: _shipParam);
  String get depthCharge => _get('DEPTH_CHARGE', prefix: _shipParam);

  /// Helper functions

  String _get(String key, {String? prefix}) {
    final string = stringOf(key, prefix: prefix);
    if (string == null) {
      _logger.severe('Failed to get string for $key');
      throw Exception('Make sure $key is correct');
    }

    return string;
  }
}
