import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';

/// PlayerShipInfoPage class
class PlayerShipInfoPage extends StatelessWidget {
  final PlayerShipInfo info;
  PlayerShipInfoPage({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerShipInfoPage')
      ),
      body: Container(),
    );
  }
}
