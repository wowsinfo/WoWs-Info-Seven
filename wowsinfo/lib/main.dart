import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/pages/HomePage.dart';
import 'package:wowsinfo/ui/pages/OriginalHomePage.dart';

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
      home: OriginalHomePage(),
    );
  }
}

