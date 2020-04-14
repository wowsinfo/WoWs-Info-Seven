import 'package:flutter/material.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';

/// RealtimePage class
class RealtimePage extends StatefulWidget {
  RealtimePage({Key key}) : super(key: key);

  @override
  _RealtimePageState createState() => _RealtimePageState();
}


class _RealtimePageState extends State<RealtimePage> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('Real-time Statistics'))
      ),
      body: Container(),
    );
  }
}
