import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/repositories/app_repository.dart';
import 'package:wowsinfo/repositories/storage/database.dart';
import 'package:wowsinfo/repositories/user_repository.dart';
import 'package:wowsinfo/widgets/wowsinfo.dart';

Future<void> setup() async {
  // setup logger and make sure it only prints in debug mode
  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      final message = '${record.loggerName}: ${record.message}';
      print(record.level.name + '|' + message);
    }
  });

  // setup database
  final database = Database();
  await database.initialize();

  // inject to repositories
  AppRepository.instance.inject(database);
  UserRepository.instance.inject(database);
}

void main() async {
  await setup();
  runApp(const WoWsInfoApp());
}
