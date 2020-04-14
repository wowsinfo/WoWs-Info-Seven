import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';

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
            SizedBox(
              width: 48,
              child: RotatedBox(
                quarterTurns: 27,
                child: ListView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: cached.shipNation.entries.map((e) => FlatButton(
                    onPressed: () {}, 
                    child: Text(e.value),
                  )).toList(growable: false),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
