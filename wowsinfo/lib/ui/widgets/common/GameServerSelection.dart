import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/providers/Preference.dart';
import 'package:wowsinfo/core/services/locale/AppLocalizationService.dart';
import 'package:wowsinfo/ui/widgets/common/FlatFilterChip.dart';
import 'package:wowsinfo/ui/widgets/common/WrapBox.dart';

/// GameServerSelection class
class GameServerSelection extends StatefulWidget {
  GameServerSelection({Key key}) : super(key: key);

  @override
  _GameServerSelectionState createState() => _GameServerSelectionState();
}

class _GameServerSelectionState extends State<GameServerSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizationService.of(context);
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
          WrapBox(
            spacing: 2,
            children: servers.map((e) {
              final curr = servers.indexOf(e);
              return Consumer<Preference>(
                builder: (context, pref, child) => FlatFilterChip(
                  label: Text(e),
                  selected: pref.gameServer.index == curr,
                  onSelected: (_) {
                    setState(() {});
                    pref.gameServer = GameServer.fromIndex(curr);
                  },
                ),
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
