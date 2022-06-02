import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/widgets/page/app_loading.dart';
import 'package:wowsinfo/widgets/page/debug_page.dart';
import 'package:wowsinfo/widgets/page/setup.dart';

class WoWsInfoApp extends StatelessWidget {
  const WoWsInfoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupListeners(context);
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

  /// Setup top level listeners to monitor system changes
  /// like language, brightness and more.
  void setupListeners(BuildContext context) {
    final logger = Logger('WoWsInfoApp');
    final window = WidgetsBinding.instance.window;
    window.onLocaleChanged = () {
      logger.info('Locale changed to ${window.locale}');
    };
    window.onPlatformBrightnessChanged = () {
      logger.info(
        'Platform brightness changed to ${window.platformBrightness}',
      );
    };
  }
}
