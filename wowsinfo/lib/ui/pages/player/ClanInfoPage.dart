import 'package:flutter/material.dart';
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
                  Text('Member - ${info.membersCount}'),
                  Column(
                    children: info.sortedMembers.map((e) => ListTile(
                      title: Text(e.accountName),
                      subtitle: Text(e.accountIdString),
                    )).toList(growable: false),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
