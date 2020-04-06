import 'package:flutter/material.dart';

/// WikiPage class
class WikiPage extends StatefulWidget {
  WikiPage({Key key}) : super(key: key);

  @override
  _WikiPageState createState() => _WikiPageState();
}


class _WikiPageState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WikiPage')
      ),
      body: Container(),
    );
  }
}
