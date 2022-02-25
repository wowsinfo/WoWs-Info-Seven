import 'package:flutter/material.dart';
import 'package:wowsinfo/services/locale/AppLocalizationService.dart';

/// RealtimePage class
class RealtimePage extends StatefulWidget {
  RealtimePage({Key key}) : super(key: key);

  @override
  _RealtimePageState createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizationService.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(lang.localised('realtime_page_title'))),
      body: Container(),
    );
  }
}
