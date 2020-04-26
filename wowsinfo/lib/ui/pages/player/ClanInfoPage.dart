import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';
import 'package:wowsinfo/core/models/WoWs/ClanInfo.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/core/parsers/API/ClanInfoParser.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

import 'PlayerInfoPage.dart';

/// ClanInfoPage class
class ClanInfoPage extends StatefulWidget {
  final Clan clan;
  ClanInfoPage({Key key, @required this.clan}) : super(key: key);

  @override
  _ClanInfoPageState createState() => _ClanInfoPageState();
}

class _ClanInfoPageState extends State<ClanInfoPage> {
  final pref = Preference.shared;
  final cached = CachedData.shared;
  ClanInfo info;
  
  @override
  void initState() {
    super.initState();
    // Saved server should be used here
    final parser = ClanInfoParser(widget.clan.server, widget.clan.clanId);
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
      appBar: AppBar(
        title: Text(widget.clan.clanIdString)
      ),
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
                Text(info.name, style: theme.headline6, textAlign: TextAlign.center),
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
                      valueWidget: info.isClanDisbanded
                      ? Icon(Icons.check, color: Colors.green)
                      : Icon(Icons.close, color: Colors.red),
                    ),
                    TextWithCaption(
                      title: 'OLD TAG',
                      value: info.oldTag ?? '...',
                    ),
                    TextWithCaption(
                      title: 'OLD NAME',
                      value: info.oldName ?? '...',
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
                    onPressed: () => launch(pref.gameServer.getClanNumberWebsite(info))
                  ),
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

  Column buildMemberList() {
    return Column(
      children: info.sortedMembers.map((e) {
        final joined = Text(e.joinedDate);
        final Function gotoPlayer = () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerInfoPage(player: e.player)));
        if (e.hasRole) {
          final role = cached.getClanRoleName(e.role);
          TextStyle style;
          if (e.isCommander) style = TextStyle(color: Colors.orange);
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
