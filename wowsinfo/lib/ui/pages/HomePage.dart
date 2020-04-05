import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/AppLocalization.dart';
import 'package:wowsinfo/core/AppProvider.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
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
    );
  }
}
