import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/User/Player.dart';

/// PlayerInfoPage class
class PlayerInfoPage extends StatefulWidget {
  final Player player;
  PlayerInfoPage({Key key, this.player}) : super(key: key);

  @override
  _PlayerInfoPageState createState() => _PlayerInfoPageState();
}


class _PlayerInfoPageState extends State<PlayerInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerInfoPage')
      ),
      body: Container(),
    );
  }
}
