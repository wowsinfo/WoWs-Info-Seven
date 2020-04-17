import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';

/// WikiCommonPage class, this is shared by flag, consumable, upgrade and collection
class WikiCommonPage extends StatefulWidget {
  final String title;
  WikiCommonPage({Key key, this.title}) : super(key: key);

  @override
  _WikiCommonPageState createState() => _WikiCommonPageState();
}


class _WikiCommonPageState extends State<WikiCommonPage> {
  final cached = CachedData.shared;

  @override
  Widget build(BuildContext context) {
    final consumable = cached.wikiConsumables;

    return Scaffold(
      appBar: AppBar(
        title: Text('WikiCommonPage')
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ), 
        itemBuilder: (c, i) => Image.network(consumable.elementAt(i).image),
      ),
    );
  }
}
