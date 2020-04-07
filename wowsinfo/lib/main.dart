import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/AppProvider.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';
import 'package:wowsinfo/ui/pages/setup/IntroPage.dart';

final pref = Preference();

void main() async {
  /// Setup local data
  await Hive.initFlutter();
  // Init preference box 
  await pref.init();
  // Cached data can be loaded later
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Builder(builder: (c) {
        final wowsinfo = Provider.of<AppProvider>(c);
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
