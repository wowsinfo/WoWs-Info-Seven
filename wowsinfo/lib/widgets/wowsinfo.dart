import 'package:flutter/material.dart';
import 'package:wowsinfo/repositories/localisation.dart';
import 'package:wowsinfo/widgets/page/app_loading.dart';
import 'package:wowsinfo/widgets/page/debug_page.dart';
import 'package:wowsinfo/widgets/page/setup.dart';

class WoWsInfoApp extends StatelessWidget {
  const WoWsInfoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoWs Info',
      localizationsDelegates: Localisation.localizationsDelegates,
      supportedLocales: Localisation.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DebugPage(),
    );
  }
}
