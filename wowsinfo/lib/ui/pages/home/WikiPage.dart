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
    final wiki = [1,2,3,4,5,6];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('wiki_page_title'))
      ),
      body: ListView(
        children: wiki.map((e) => ListTile(
          title: Text('WIKI'),
          leading: Icon(Icons.wallpaper),
        )).toList(growable: false),
      ),
    );
  }
}
