import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/providers/Preference.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/home/HomePage.dart';
import 'package:wowsinfo/ui/pages/home/RealtimePage.dart';
import 'package:wowsinfo/ui/pages/home/SearchPage.dart';
import 'package:wowsinfo/ui/pages/home/WebsitePage.dart';
import 'package:wowsinfo/ui/pages/home/WikiPage.dart';

/// BottomNavigationPage class
class BottomNavigationPage extends StatelessWidget {
  BottomNavigationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Not first launch anymore
    final localization = AppLocalization.of(context);

    return Scaffold(
      body: Consumer<Preference>(
        builder: (context, pref, child) => IndexedStack(
          index: pref.bottomTabIndex,
          children: [
            HomePage(),
            WebsitePage(),
            WikiPage(),
            RealtimePage(),
            SearchPage(),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<Preference>(
        builder: (context, pref, child) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(localization.localised('bottom_tab_home')),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              title: Text(localization.localised('bottom_tab_website')),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text(localization.localised('bottom_tab_wiki')),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text(localization.localised('bottom_tab_realtime')),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(localization.localised('bottom_tab_search')),
            ),
          ],
          currentIndex: pref.bottomTabIndex,
          onTap: (index) => pref.bottomTabIndex = index,
        ),
      ),
    );
  }

}
