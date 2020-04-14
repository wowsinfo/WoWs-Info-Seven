import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';
import 'package:wowsinfo/ui/pages/setup/IntroPage.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';

final pref = Preference.shared;
final settings = AppSettings.shared;

void main() async {
  // Run a loading screen here
  runApp(Theme(
    data: ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white)
      ),
    ),
    child: Center(
      child: PlatformLoadingIndiactor(),
    ),
  ));

  /// Setup local data
  await Hive.initFlutter();
  // Init preference box 
  await pref.init();
  // Init app settins box
  await settings.init();
  // Init cached data
  await CachedData.shared.init();
  // Cached data can be loaded later
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => settings,
      child: Builder(builder: (c) {
        final wowsinfo = Provider.of<AppSettings>(c);
        return MaterialApp(
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: wowsinfo.locale,
          supportedLocales: AppLocalization.supportedLocales,
          localeResolutionCallback: (locale, supported) {
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
          home: buildHome()
        );
      }),
    );
  }

  /// Setup should be the home
  Widget buildHome() {
    if (pref.firstLaunch) return IntroPage();
    return InitialPage();
  }
}
