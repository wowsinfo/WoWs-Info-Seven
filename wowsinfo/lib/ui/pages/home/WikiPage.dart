import 'package:flutter/material.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';

/// WikiPage class
class WikiPage extends StatefulWidget {
  WikiPage({Key key}) : super(key: key);

  @override
  _WikiPageState createState() => _WikiPageState();
}


class _WikiPageState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('wiki_page_title'))
      ),
      body: Container(),
    );
  }
}
