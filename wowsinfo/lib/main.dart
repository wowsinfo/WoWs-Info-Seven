import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/storage/database.dart';
import 'package:wowsinfo/widgets/wowsinfo.dart';

void main() async {
  // setup logger and make sure it only prints in debug mode
  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      final message = '${record.loggerName}: ${record.message}';
      print(record.level.name + '|' + message);
    }
  });

  Database.instance.initialize();

  runApp(const WoWsInfoApp());
}
