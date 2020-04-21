import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';

/// PlayerChartPage class
class PlayerChartPage extends StatelessWidget {
  final PlayerShipInfo info;
  PlayerChartPage({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerChartPage')
      ),
      body: Container(),
    );
  }
}
