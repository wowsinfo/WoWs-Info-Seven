import 'package:flutter/material.dart';

/// RealtimePage class
class RealtimePage extends StatefulWidget {
  RealtimePage({Key key}) : super(key: key);

  @override
  _RealtimePageState createState() => _RealtimePageState();
}


class _RealtimePageState extends State<RealtimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RealtimePage')
      ),
      body: Container(),
    );
  }
}
