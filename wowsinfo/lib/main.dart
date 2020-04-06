import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/others/AppProvider.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';

void main() async {
  runApp(MyApp());
  /// Setup Hive database
  await Hive.initFlutter();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(
        Colors.blue, 
        Brightness.light, 
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
      ),
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
          home: InitialPage(),
        );
      }),
    );
  }
}
