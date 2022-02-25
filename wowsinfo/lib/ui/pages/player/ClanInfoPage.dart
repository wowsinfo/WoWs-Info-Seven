import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowsinfo/providers/CachedData.dart';
import 'package:wowsinfo/providers/Preference.dart';
import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/models/User/Clan.dart';
import 'package:wowsinfo/models/WoWs/ClanInfo.dart';
import 'package:wowsinfo/utils/Utils.dart';
import 'package:wowsinfo/parsers/API/ClanInfoParser.dart';
import 'package:wowsinfo/ui/widgets/common/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/common/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/common/WrapBox.dart';

import 'PlayerInfoPage.dart';

/// ClanInfoPage class
class ClanInfoPage extends StatefulWidget {
  final Clan clan;
  final GameServer server;
  ClanInfoPage({Key key, @required this.clan, this.server}) : super(key: key);

  @override
  _ClanInfoPageState createState() => _ClanInfoPageState();
}

class _ClanInfoPageState extends State<ClanInfoPage> {
  Preference pref;
  ClanInfo info;

  @override
  void initState() {
    super.initState();
    this.pref = Provider.of<Preference>(context, listen: false);
    // Saved server should be used here, if server is passed in, use it
    final parser =
        ClanInfoGetter(widget.server ?? widget.clan.server, widget.clan.clanId);
    parser.download().then((json) {
      final info = parser.parse(json);
      if (info != null) {
        setState(() {
          this.info = info;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.clan.clanIdString)),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (w, a) => ScaleTransition(scale: a, child: w),
          switchInCurve: Curves.linearToEaseOut,
          child: buildContent(context),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    if (info == null) {
      return Center(
        child: PlatformLoadingIndiactor(),
      );
    } else {
      final theme = Theme.of(context).textTheme;
      final width = Utils.of(context).getItemWidth(200);
      return Scrollbar(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(info.tag, style: theme.headline2),
                Text(info.name,
                    style: theme.headline6, textAlign: TextAlign.center),
                WrapBox(
                  padding: const EdgeInsets.only(top: 8),
                  width: width,
                  children: [
                    TextWithCaption(
                      title: 'created',
                      value: info.createdDate,
                    ),
                    TextWithCaption(
                      title: 'creator',
                      value: info.creatorName,
                    ),
                    TextWithCaption(
                      title: 'leader',
                      value: info.leaderName,
                    ),
                    TextWithCaption(
                      title: 'Disbanded',
                      valueWidget: buildIcon(info.isClanDisbanded),
                    ),
                    TextWithCaption(
                      title: 'OLD TAG',
                      valueWidget: info.oldTag != null
                          ? Text(info.oldTag)
                          : buildCrossIcon(),
                    ),
                    TextWithCaption(
                      title: 'OLD NAME',
                      valueWidget: info.oldName != null
                          ? Text(info.oldName)
                          : buildCrossIcon(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(info.description, style: theme.bodyText1),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: RaisedButton(
                      child: Text('More information on WoWs Number'),
                      onPressed: () =>
                          launch(pref.gameServer.getClanNumberWebsite(info))),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      'Member - ${info.membersCount}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                buildMemberList()
              ],
            ),
          ),
        ),
      );
    }
  }

  Icon buildIcon(bool yes) {
    return yes ? buildCheckIcon() : buildCrossIcon();
  }

  Icon buildCheckIcon() => Icon(Icons.check, color: Colors.green);
  Icon buildCrossIcon() => Icon(Icons.close, color: Colors.red);

  Column buildMemberList() {
    final cached = Provider.of<CachedData>(context, listen: false);

    return Column(
      children: info.sortedMembers.map((e) {
        final joined = Text(e.joinedDate);
        final Function gotoPlayer = () {
          final pref = Provider.of<Preference>(context, listen: false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => PlayerInfoPage(player: e.toPlayer(pref))));
        };

        if (e.hasRole) {
          final role = cached.getClanRoleName(e.role);
          TextStyle style;
          if (e.isCommander)
            style = TextStyle(color: Colors.orange);
          else if (e.isExecutive) style = TextStyle(color: Colors.lightBlue);

          return ListTile(
            title: Text(e.accountName, style: style),
            subtitle: Text(role, style: style),
            trailing: joined,
            onTap: gotoPlayer,
          );
        } else {
          // They don't have a role but don't display NONE
          return ListTile(
            title: Text(e.accountName),
            subtitle: Text(e.accountIdString),
            trailing: joined,
            onTap: gotoPlayer,
          );
        }
      }).toList(growable: false),
    );
  }
}
