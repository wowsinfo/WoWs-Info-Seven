import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';

/// WikiWarshipPage class
class WikiWarshipPage extends StatefulWidget {
  WikiWarshipPage({Key key}) : super(key: key);

  @override
  _WikiWarshipPageState createState() => _WikiWarshipPageState();
}


class _WikiWarshipPageState extends State<WikiWarshipPage> {
  final cached = CachedData.shared;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WikiWarshipPage')
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            VerticalDivider(width: 1),
            SizedBox(
              width: 48,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 27,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: cached.shipNation.entries.map((e) => FlatFilterChip(
                          onSelected: (_) {}, 
                          label: Text(e.value),
                        )).toList(growable: false),
                      ),
                    ),
                  ),
                  Divider(height: 0)
                ],
              ),
            ),
            VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Divider(height: 1),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: cached.shipType.entries.map((e) => FlatFilterChip(
                        onSelected: (_) {}, 
                        selected: e.key == 'Destroyer',
                        label: Text(e.value),
                      )).toList(growable: false),
                    ),
                  ),
                  Divider(height: 1),
                ],
              )
            ),
            VerticalDivider(width: 1),
          ],
        ),
      ),
    );
  }
}
