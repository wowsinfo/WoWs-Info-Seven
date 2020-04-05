import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/AppProvider.dart';
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
        title: 'WoWs Info Re',
        theme: app.getTheme(),
        home: InitialPage(),
      );
      }),
    );
  }
}
