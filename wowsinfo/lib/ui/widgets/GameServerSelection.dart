import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';

/// GameServerSelection class
class GameServerSelection extends StatefulWidget {
  GameServerSelection({Key key}) : super(key: key);

  @override
  _GameServerSelectionState createState() => _GameServerSelectionState();
}

class _GameServerSelectionState extends State<GameServerSelection> {
  final pref = Preference.shared;
  int selectedIndex;
  
  @override
  void initState() {
    super.initState();
    this.selectedIndex = pref.gameServer.index;
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);
    final servers = [
      lang.localised('game_server_ru'),
      lang.localised('game_server_eu'),
      lang.localised('game_server_na'),
      lang.localised('game_server_asia')
    ];

    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang.localised('game_server_selection_title'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            spacing: 2,
            alignment: WrapAlignment.center,
            children: servers.map((e) {
              final curr = servers.indexOf(e);
              return FlatFilterChip(
                label: Text(e),
                selected: selectedIndex == curr, 
                onSelected: (_) {
                  setState(() => selectedIndex = curr);
                  pref.setGameServer(Server.values[curr]);
                },
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
