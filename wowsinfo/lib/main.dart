import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/AppProvider.dart';
import 'package:wowsinfo/core/localization/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(Colors.blue, Brightness.light),
      child: Builder(builder: (c) {
        final app = Provider.of<AppProvider>(c);
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
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
          theme: app.getTheme(),
          home: InitialPage(),
        );
      }),
    );
  }
}
