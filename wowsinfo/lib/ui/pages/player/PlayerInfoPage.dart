import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/UI/PlayerChartData.dart';
import 'package:wowsinfo/core/models/UI/RecordValue.dart';
import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerAchievement.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerClanTag.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/PvP.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RecentPlayerInfo.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/core/parsers/API/BasicPlayerInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/PlayerAchievementParser.dart';
import 'package:wowsinfo/core/parsers/API/PlayerClanTagParser.dart';
import 'package:wowsinfo/core/parsers/API/PlayerShipInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/RankPlayerInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/RankPlayerShipInfoParser.dart';
import 'package:wowsinfo/core/parsers/API/RecentPlayerInfoParser.dart';
import 'package:wowsinfo/ui/pages/player/ClanInfoPage.dart';
import 'package:wowsinfo/ui/pages/player/PlayerChartPage.dart';
import 'package:wowsinfo/ui/pages/player/PlayerRankInfoPage.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipInfoPage.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiAchievementPage.dart';
import 'package:wowsinfo/ui/widgets/ErrorIconWithText.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/player/BasicPlayerTile.dart';
import 'package:wowsinfo/ui/widgets/player/RatingBar.dart';
import 'package:wowsinfo/ui/widgets/player/RatingTheme.dart';
import 'package:wowsinfo/ui/widgets/player/WeaponInfoTile.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// PlayerInfoPage class
class PlayerInfoPage extends StatefulWidget {
  final Player player;
  PlayerInfoPage({Key key, this.player}) : super(key: key);

  @override
  _PlayerInfoPageState createState() => _PlayerInfoPageState();
}

class _PlayerInfoPageState extends State<PlayerInfoPage> {
  final cached = CachedData.shared;
  bool error = false;
  /// - 0, all
  /// - 1, solo, one player
  /// - 2, div2
  /// - 3, div3
  int pvpMode = 0;
  /// This changes based on how user selection
  PvP pvp;

  BasicPlayerInfo basicInfo;
  PlayerAchievement achievement;
  PlayerShipInfo shipInfo;
  RankPlayerInfo rankInfo;
  RankPlayerShipInfo rankShipInfo;
  PlayerClanTag clanTag;
  RecentPlayerInfo recentInfo;

  @override
  void initState() {
    super.initState();
    this.loadAll();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
    else Utils.debugPrint('Cancel set state');
  }

  void loadAll() async {
    final server = widget.player.server;
    final accountId = widget.player.playerId;
    try {
      final basic = BasicPlayerInfoParser(server, accountId);
      final basicInfo = basic.parse(await basic.download());
      if (basicInfo != null) {
        setState(() {
          // Update basic info first
          this.basicInfo = basicInfo;
        });

        // Check if this is a public profile
        if (basicInfo.publicProfile && (basicInfo?.statistic?.battle ?? 0) > 0) {
          setState(() => this.pvp = basicInfo.statistic.pvp);

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

          // Request for recent player info
          final recent = RecentPlayerInfoParser(server, accountId);
          final recentInfo = recent.parse(await recent.download());
          if (recentInfo != null) {
            setState(() {
              this.recentInfo = recentInfo;
            });
          }

          // Request for rank
          final r = RankPlayerInfoParser(server, accountId);
          final rankInfo = r.parse(await r.download());
          if (rankInfo != null && rankInfo.season != null) {
            setState(() {
              this.rankInfo = rankInfo;
            });
          }

          // Request for rank ship
          final rs = RankPlayerShipInfoParser(server, accountId);
          final rankShipInfo = rs.parse(await rs.download());
          if (rankShipInfo != null && rankShipInfo.ships.length > 0) {
            setState(() {
              this.rankShipInfo = rankShipInfo;
            });
          }
        }
      } else {
        setState(() {
          error = true;
        });
      }
    } catch (e, s) {
      Utils.debugPrint(e);
      Utils.debugPrint(s);
      setState(() {
        error = true;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return RatingTheme(
      color: shipInfo?.overallRating?.colour,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.player.playerIdString),
        ),
        body: SafeArea(
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (w, a) => ScaleTransition(scale: a, child: w),
              switchInCurve: Curves.linearToEaseOut,
              child: buildBasicInfo(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBasicInfo(BuildContext context) {
    if (error) return ErrorIconWithText();
    if (basicInfo == null || clanTag == null) return PlatformLoadingIndiactor();

    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          buildNickname(context, textTheme),
          buildPlayerInfo(),
          buildButtons(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
            child: buildRating()
          ),
          buildPvPModeSelection(),
          buildStatistics(),
        ],
      ),
    );
  }

  Widget buildPvPModeSelection() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: CupertinoSlidingSegmentedControl(
          padding: const EdgeInsets.all(4),
          groupValue: this.pvpMode,
          backgroundColor: Colors.transparent,
          children: {
            0: Text('PvP'),
            1: Text('Solo'),
            2: Text('Div2'),
            3: Text('Div3'),
            4: Text('PvE'),
            5: Text('Rank'),
          }, 
          onValueChanged: (index) => setState(() {
            // UPdate selected index and also update 'PvP'
            pvpMode = index;
            switch (index) {
              case 0:
                pvp = basicInfo.statistic.pvp;
                break;
              case 1:
                pvp = basicInfo.statistic.solo;
                break;
              case 2:
                pvp = basicInfo.statistic.div2;
                break;
              case 3:
                pvp = basicInfo.statistic.div3;
                break;
              case 4:
                pvp = basicInfo.statistic.pve;
                break;
              case 5:
                pvp = basicInfo.statistic.rank;
                break;
            }
          }),
        ),
      ),
    );
  }

  Widget buildRating() {
    if (shipInfo == null) return SizedBox.shrink();
    return RatingBar(rating: shipInfo.overallRating);
  }

  WrapBox buildPlayerInfo() {
    return WrapBox(
      width: 120,
      children: [
        TextWithCaption(
          title: 'Level',
          value: basicInfo.level,
        ),
        TextWithCaption(
          title: 'Created',
          value: basicInfo.createdDate,
        ),
        TextWithCaption(
          title: 'Last battle',
          value: basicInfo.lastBattleDate,
        ),
        TextWithCaption(
          title: 'Total battle',
          value: basicInfo.totalBattleString,
        ),
        TextWithCaption(
          title: 'Distance travlled',
          value: basicInfo.distanceString,
        ),
      ],
    );
  }

  Widget buildStatistics() {
    final stats = basicInfo.statistic;
    if (stats == null) return SizedBox.shrink();

    // Make the divider invisible
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: Column(
        children: [
          RatingTheme(
            color: shipInfo?.overallRating?.colour,
            child: BasicPlayerTile(stats: pvp),
          ),
          buildMorePlayerInfo(pvp),
          buildRecord(pvp),
          WeaponInfoTile(pvp: pvp),
        ],
      ),
    );
  }

  /// Buttons to go to another page
  Widget buildButtons() {
    final width = Utils.of(context).getItemWidth(200, margin: 10);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (w, a) => ScaleTransition(scale: a, child: w),
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            )
          ),
          child: WrapBox(
            width: width,
            spacing: 4,
            children: [
              // at least one achievment I guess
              if (achievement != null && achievement.achievement.length > 0) buildAchievement(context),
              if (shipInfo != null && recentInfo != null) buildChart(context),
              // at least one ship
              if (shipInfo != null && shipInfo.ships.length > 0) buildShip(context),
              if (rankInfo != null && rankShipInfo != null) buildRank(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAchievement(BuildContext context) {
    final lang = AppLocalization.of(context);
    return RaisedButton.icon(
      icon: Icon(Icons.brightness_7),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => WikiAchievementPage(player: achievement))),
      label: Text(lang.localised('player_achievement')),
    );
  }

  Widget buildChart(BuildContext context) {
    final lang = AppLocalization.of(context);
    return RaisedButton.icon(
      icon: Icon(Icons.pie_chart),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerChartPage(info: PlayerChartData(shipInfo), recent: recentInfo))), 
      label: Text(lang.localised('player_charts')),
    );
  }

  Widget buildShip(BuildContext context) {
    final lang = AppLocalization.of(context);
    return RaisedButton.icon(
      icon: Icon(Icons.directions_boat),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerShipInfoPage(info: shipInfo))), 
      label: Text(lang.localised('player_ships'))
    );
  }

  Widget buildRank(BuildContext context) {
    final lang = AppLocalization.of(context);
    return RaisedButton.icon(
      icon: Icon(Icons.star),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerRankInfoPage(rank: rankInfo, rankShip: rankShipInfo))), 
      label: Text(lang.localised('player_rank')),
    );
  }

  /// Merge clan tag and player together
  InkWell buildNickname(BuildContext context, TextTheme textTheme) {
    return InkWell(
      onTap: clanTag.hasTag 
      ? () => Navigator.push(context, MaterialPageRoute(builder: (c) => ClanInfoPage(clan: clanTag.clan)))
      : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          clanTag.hasTag 
          ? clanTag.tagString + '\n${basicInfo.nickname}' 
          : basicInfo.nickname, 
          textAlign: TextAlign.center,
          style: textTheme.headline6.copyWith(fontSize: 24)
        ),
      )
    );
  }

  Widget buildMorePlayerInfo(PvP pvp) {
    if (pvp == null) return SizedBox.shrink();
    return WrapBox(
      width: 100,
      children: [
        TextWithCaption(
          title: 'argo',
          value: pvp.artAgro.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.draw.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.controlCapturedPoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.controlDroppedPoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.droppedCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.artAgro.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.draw.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.droppedCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.loss.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.planesKilled.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.shipsSpotted.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.survivedBattle.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.survivedWin.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.teamCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.teamDroppedCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.torpedoAgro.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.win.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.xp.toString(),
        ),
      ],
    );
  }

  Widget buildRecord(PvP pvp) {
    if (pvp == null) return SizedBox.shrink();
    final width = Utils.of(context).getItemWidth(150);
    return WrapBox(
      width: width,
      height: 150,
      itemPadding: const EdgeInsets.only(top: 8),
      children: [
        RecordValue(pvp.maxDamageDealtShipId, 'damage', pvp.maxDamage),
        RecordValue(pvp.maxXpShipId, 'max exp', pvp.maxExp),
        RecordValue(pvp.maxFragsShipId, 'max frag', pvp.maxFrag),
        RecordValue(pvp.maxTotalAgroShipId, 'max potential', pvp.maxPotential),
        RecordValue(pvp.maxShipsSpottedShipId, 'max spotted', pvp.maxSpotted),
        RecordValue(pvp.maxScoutingDamageShipId, 'max spotting', pvp.maxSpottingDamage),
        RecordValue(pvp.maxPlanesKilledShipId, 'max plane destoryed', pvp.maxPlane),
        RecordValue(pvp.maxDamageDealtToBuildingsShipId, 'damage to buildings', pvp.maxDamageToBuilding),
        RecordValue(pvp.maxSuppressionsShipId, 'max supression', pvp.maxSupression),
      ].where((e) => cached.getShip(e.shipId) != null).map((e) => WikiWarshipCell(
        showDetail: true,
        ship: cached.getShip(e.shipId),
        bottom: TextWithCaption(
          title: e.title,
          value: e.value,
        ),
      )).toList(growable: false),
    );
  }
}
