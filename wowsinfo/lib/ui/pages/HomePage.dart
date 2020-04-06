import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/others/AppProvider.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).localised('app_name'))
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Dark'),
              onPressed: () {
                provider.setBrightness(Brightness.dark);
              },
            ),
            RaisedButton(
              child: Text('Light'),
              onPressed: () {
                provider.setBrightness(Brightness.light);
              },
            ),
            RaisedButton(
              child: Text('Random language'),
              onPressed: () {
                final randomIndex = Random().nextInt(5);
                provider.setLocale(AppLocalization.supportedLocales[randomIndex]);
              },
            ),
            RaisedButton(
              child: Text('Not supported language'),
              onPressed: () {
                provider.setLocale(Locale('id'));
              },
            ),
            RaisedButton(
              child: Text('Red'),
              onPressed: () {
                provider.setColor(Colors.red);
              },
            ),
            RaisedButton(
              child: Text('Green'),
              onPressed: () {
                provider.setColor(Colors.green);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: selectedIndex,
        onTap: (index) {
          // Update iondex
          setState(() => selectedIndex = index);
        },
      ),
    );
  }
}
