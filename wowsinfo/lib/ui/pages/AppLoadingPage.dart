import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/providers/GlobalAppSettings.dart';
import 'package:wowsinfo/providers/CachedData.dart';
import 'package:wowsinfo/constants/AppConstant.dart';
import 'package:wowsinfo/providers/Preference.dart';
import 'package:wowsinfo/services/locale/AppLocalizationService.dart';
import 'package:wowsinfo/ui/pages/BottomNavigationPage.dart';
import 'package:wowsinfo/ui/widgets/common/ErrorIconWithText.dart';
import 'package:wowsinfo/ui/widgets/common/PlatformLoadingIndiactor.dart';

/// AppLoadingPage
/// This page will load data from local storage or request data from servers
/// - It handles corrupted data by redownloading it
/// - When everything is all good, it will push to `HomePage` autmatically
/// - If there are errors, it will check whether it is critical
///   - If it is critical, user needs to try redownload
class AppLoadingPage extends StatefulWidget {
  AppLoadingPage({Key key}) : super(key: key);

  @override
  _AppLoadingPageState createState() => _AppLoadingPageState();
}

class _AppLoadingPageState extends State<AppLoadingPage> {
  bool showLogo = false;

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preference>(context, listen: false);

    return Provider(
      create: (_) => CachedData(pref),
      child: Theme(
        // Only here, the overlay is blue and white text should be used
        data: ThemeData(
          accentColor: Colors.white,
          brightness: Brightness.dark,
          textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
        ),
        child: Builder(builder: (c) {
          return Consumer<CachedData>(
            builder: (context, cached, child) => FutureBuilder(
              future: cached.update(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    setState(() => showLogo = true);
                    cached.close();

                    Future.delayed(Duration(milliseconds: 2000)).then((_) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => BottomNavigationPage(),
                          fullscreenDialog: true));
                    });

                    // Update last update time
                    pref.appVersion = AppConstant.APP_VERSION;
                    pref.lastUpdate = DateTime.now();

                    return buildSuccess();
                  } else {
                    return Center(child: ErrorIconWithText());
                  }
                }

                return Center(child: PlatformLoadingIndiactor());
              },
            ),
          );
        }),
      ),
    );
  }

  Widget buildSuccess() {
    return Stack(
      children: <Widget>[
        // This app bar will update the status bar color
        AppBar(brightness: Brightness.dark),
        Consumer<GlobalAppSettings>(
          builder: (context, settings, child) => Container(
            color: settings.isDarkMode() ? Colors.grey[900] : Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    switchInCurve: Curves.linearToEaseOut,
                    switchOutCurve: Curves.linearToEaseOut,
                    transitionBuilder: (w, a) =>
                        SizeTransition(sizeFactor: a, child: w),
                    child: buildLogo(context),
                  ),
                  PlatformLoadingIndiactor(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLogo(BuildContext c) {
    if (showLogo) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/logo_white.png')),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(AppLocalizationService.of(c).localised('app_name'),
                  style: Theme.of(c).textTheme.subtitle1),
            )
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }
}
