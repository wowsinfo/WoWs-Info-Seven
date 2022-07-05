import 'package:flutter/material.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';

class ClanPage extends StatefulWidget {
  const ClanPage({
    Key? key,
    required this.clan,
  }) : super(key: key);

  final ClanResult clan;

  @override
  State<ClanPage> createState() => _ClanPageState();
}

class _ClanPageState extends State<ClanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clan.clanId.toString()),
      ),
      body: Center(
        child: Text('Clan Page'),
      ),
    );
  }
}
