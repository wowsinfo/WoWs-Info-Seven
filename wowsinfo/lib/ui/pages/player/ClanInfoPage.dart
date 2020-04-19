import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';
import 'package:wowsinfo/core/models/WoWs/ClanInfo.dart';
import 'package:wowsinfo/core/parsers/API/ClanInfoParser.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';

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
    final parser = ClanInfoParser(pref.gameServer, widget.clan.clanId);
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
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(info.tag),
                  Text(info.name),
                  TextWithCaption(
                    title: 'created',
                    value: info.createdAt.toString(),
                  ),
                  TextWithCaption(
                    title: 'creator',
                    value: info.creatorName.toString(),
                  ),
                  TextWithCaption(
                    title: 'leader',
                    value: info.leaderName.toString(),
                  ),
                  Text(info.description),
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
                      padding: const EdgeInsets.only(left: 16, top: 8.0),
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
        ),
      ),
    );
  }

  Column buildMemberList() {
    return Column(
      children: info.sortedMembers.map((e) {
        if (e.hasRole) {
          final role = cached.getClanRoleName(e.role);
          TextStyle style;
          if (e.isCommander) style = TextStyle(color: Colors.orange);
          else if (e.isExecutive) style = TextStyle(color: Colors.lightBlue);

          return ListTile(
            title: Text(e.accountName, style: style),
            subtitle: Text(role, style: style),
          );
        } else {
          // They don't have a role but don't display NONE
          return ListTile(
            title: Text(e.accountName),
            subtitle: Text(e.accountIdString),
          );
        }
      }).toList(growable: false),
    );
  }
}
