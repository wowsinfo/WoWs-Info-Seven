import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerAchievement.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerClanTag.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/core/parsers/API/BasicPlayerInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/PlayerAchievementParser.dart';
import 'package:wowsinfo/core/parsers/API/PlayerClanTagParser.dart';
import 'package:wowsinfo/core/parsers/API/PlayerShipInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/RankPlayerInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/RankPlayerShipInfoParser.dart';

/// PlayerInfoPage class
class PlayerInfoPage extends StatefulWidget {
  final Player player;
  PlayerInfoPage({Key key, this.player}) : super(key: key);

  @override
  _PlayerInfoPageState createState() => _PlayerInfoPageState();
}

class _PlayerInfoPageState extends State<PlayerInfoPage> {
  BasicPlayerInfo basicInfo;
  PlayerAchievement achievement;
  PlayerShipInfo shipInfo;
  RankPlayerInfo rankInfo;
  RankPlayerShipInfo rankShipInfo;
  PlayerClanTag clanTag;

  @override
  void initState() {
    super.initState();
    this.loadAll();
  }

  void loadAll() async {
    final server = widget.player.server;
    final accountId = widget.player.playerId;
    final basic = BasicPlayerInfoParser(server, accountId);
    final basicInfo = basic.parse(await basic.download());
    if (basicInfo != null) {
      setState(() {
        // Update basic info first
        this.basicInfo = basicInfo;
      });

      // Check if this is a public profile
      if (basicInfo.publicProfile) {
        // Request for clan tag
        final tag = PlayerClanTagParser(server, accountId);
        final clanTag = tag.parse(await tag.download());
        if (clanTag != null) {
          setState(() {
            this.clanTag = clanTag;
          });
        }

        // Request for achievement
        final a = PlayerAchievementParser(server, accountId);
        final achievement = a.parse(await a.download());
        if (achievement != null) {
          setState(() {
            this.achievement = achievement;
          });
        }

        // Request for ship
        final ship = PlayerShipInfoParser(server, accountId);
        final shipInfo = ship.parse(await ship.download());
        if (shipInfo != null) {
          setState(() {
            this.shipInfo = shipInfo;
          });
        }

        // Request for rank
        final r = RankPlayerInfoParser(server, accountId);
        final rankInfo = r.parse(await r.download());
        if (rankInfo != null) {
          setState(() {
            this.rankInfo = rankInfo;
          });
        }

        // Request for rank ship
        final rs = RankPlayerShipInfoParser(server, accountId);
        final rankShipInfo = rs.parse(await rs.download());
        if (rankShipInfo != null) {
          setState(() {
            this.rankShipInfo = rankShipInfo;
          });
        }
      }
    }
  }

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
