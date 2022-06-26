import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/repositories/app_repository.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/repositories/stores/shared_store.dart';
import 'package:wowsinfo/repositories/user_repository.dart';
import 'package:wowsinfo/widgets/wowsinfo.dart';

Future<void> setup() async {
  // setup logger and make sure it only prints in debug mode
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      final message = '${record.loggerName}: ${record.message}';
      print('${record.level.name}|$message');
    }
  });

  // setup the store
  final store = SharedStore();
  await store.load();

  // inject to repositories
  AppRepository.instance.inject(store);
  UserRepository.instance.inject(store);
}

/// Load all local app data from gamedata folder
Future<void> loadAppData() async {
  // load the repositories
  await Localisation.instance.initialise();
  await GameRepository.instance.initialise();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  // debug
  // debugRepaintRainbowEnabled = true;

  runApp(const WoWsInfoApp());
}
