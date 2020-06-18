import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/providers/GlobalAppSettings.dart';
import 'package:wowsinfo/core/services/locale/AppLocalizationService.dart';
import 'package:wowsinfo/ui/pages/AppLoadingPage.dart';

void main() async {
  // Setup HiveDB
  await Hive.initFlutter();
  // Create and setup AppSetting
  final settings = GlobalAppSettings()..init();
  // Start app
  runApp(WoWsInfoApp(settings));
}

class WoWsInfoApp extends StatelessWidget {
  final GlobalAppSettings settings;
  const WoWsInfoApp(this.settings, {Key key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAppSettings>(
      builder: (context, wowsinfo, child) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizationService.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: wowsinfo.locale,
        supportedLocales: AppLocalizationService.supportedLocales,
        localeResolutionCallback: (locale, supported) {
          if (locale == null) return supported.first;
          switch (locale.languageCode) {
            case 'en':
            case 'ja':
            case 'zh':
              return locale;
            default:
              // This should be english
              return supported.first;
          }
        },
        title: 'WoWs Info Re',
        theme: wowsinfo.theme,
        darkTheme: wowsinfo.darkTheme,
        themeMode: wowsinfo.themeMode,
        // This should depend on whether first_launch is true or not
        home: AppLoadingPage(),
      ),
    );
  }
}
