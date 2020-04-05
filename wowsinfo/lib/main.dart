import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoWs Info Re',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
        indicatorColor: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: InitialPage(),
    );
  }
}
