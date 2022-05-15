import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/time_tracker.dart';

/// This repository manages game data from WoWs-Game-Data
class GameRepository {
  /// The shared instance of the AppRepository.
  static final GameRepository instance = GameRepository._init();
  GameRepository._init();

  bool _initialised = false;
  final _logger = Logger('GameRepository');

  /// Load wowsinfo.json from /gamedata/app/data/
  Future<void> initialise() async {
    if (_initialised) {
      throw Exception('GameRepository is already initialised');
    }

    final _timer = TimeTracker();
    final jsonString = await rootBundle.loadString(
      'gamedata/app/data/wowsinfo.json',
      cache: false,
    );
    final dataObject = jsonDecode(jsonString);
    _timer.log(message: 'Loaded wowsinfo.json');

    // decode data into models and store them in the repository

    _initialised = true;
  }
}
