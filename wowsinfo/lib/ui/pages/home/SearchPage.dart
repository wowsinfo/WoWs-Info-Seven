import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';
import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/parsers/API/SearchClanResultParser.dart';
import 'package:wowsinfo/core/parsers/API/SearchPlayerResultParser.dart';
import 'package:wowsinfo/ui/pages/player/ClanInfoPage.dart';
import 'package:wowsinfo/ui/pages/player/PlayerInfoPage.dart';

final pref = Preference.shared; 

/// SearchPage class
class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  String input;
  String previousInput;
  List<Clan> clans = [];
  List<Player> players = [];

  @override
  void initState() {
    super.initState();
    showContact();
  }

  void resetInput() {
    this.controller.clear();
    setState(() {
      input = '';
      previousInput = '';
    });

    showContact();
  }

  /// Show contact
  void showContact() {
    setState(() {
      clans = pref.contactList.clans;
      players = pref.contactList.players;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.search, size: 32),
            ),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration.collapsed(
                  hintText: 'Search players or clans',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                ),
                controller: this.controller,
                cursorColor: Colors.white70,
                autocorrect: false,
                autofocus: false,
                onChanged: (t) => setState(() => this.input = t),
                onEditingComplete: () => this.search()
              ),
            ),
            IconButton(
              icon: Icon(Icons.close), 
              onPressed: () => this.resetInput(),
            ),
          ],
        )
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(title: Text('Clan - ${clans.length}')),
              AnimatedSwitcher(
                transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
                duration: Duration(milliseconds: 300),
                child: ClanList(clans: clans, key: Key(clans.length.toString())),
              ),
              Divider(),
              ListTile(title: Text('Player - ${players.length}')),
              AnimatedSwitcher(
                transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
                duration: Duration(milliseconds: 300),
                child: PlayerList(players: players, key: Key(players.length.toString())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Search player or clans
  search() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // Don't search some result
    if (input == previousInput) return;
    setState(() {
      players = [];
      clans = [];
    });
    
    searchPlayer();
    searchClan();
    previousInput = input;
  }

  searchClan() async {
    // At least 2 characters for clans and at most 5 characters
    if (input.length < 2 || input.length > 5) return;
    final parser = SearchClanResultParser(pref.gameServer, input.trim());
    final clan = parser.parse(await parser.download());
    if (clan != null) {
      setState(() => this.clans = clan.data ?? []);
    }
  }

  searchPlayer() async {
    // At least 3 characters for players, max 24 according to the API
    if (input.length < 3 || input.length > 24) return;
    final parser = SearchPlayerResultParser(pref.gameServer, input.trim());
    final player = parser.parse(await parser.download());
    if (player != null) {
      setState(() => this.players = player.players ?? []);
    }
  }
}

class PlayerList extends StatefulWidget {
  const PlayerList({
    Key key,
    @required this.players,
  }) : super(key: key);

  final List<Player> players;

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    final list = pref.contactList;
    return Column(
      children: widget.players.map((e) => ListTile(
        title: Text(e.nickname),
        subtitle: Text(e.playerId.toString()),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerInfoPage(player: e))),
        trailing: list.containsPlayer(e) 
        ? IconButton(
          icon: Icon(Icons.remove), 
          onPressed: () {
            list.updatePlayer(e, add: false);
            setState(() {});
          },
        ) : IconButton(
          icon: Icon(Icons.add), 
          onPressed: () {
            list.updatePlayer(e);
            setState(() {});
          },
        ),
      )).toList(growable: false),
    );
  }
}

class ClanList extends StatefulWidget {
  const ClanList({
    Key key,
    @required this.clans,
  }) : super(key: key);

  final List<Clan> clans;

  @override
  _ClanListState createState() => _ClanListState();
}

class _ClanListState extends State<ClanList> {
  @override
  Widget build(BuildContext context) {
    final list = pref.contactList;
    return Column(
      children: widget.clans.map((e) => ListTile(
        title: Text(e.tag),
        subtitle: Text(e.clanIdString),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ClanInfoPage(clan: e))),
        trailing: list.containsClan(e) 
        ? IconButton(
          icon: Icon(Icons.remove), 
          onPressed: () {
            list.updateClan(e, add: false);
            setState(() {});
          },
        ) : IconButton(
          icon: Icon(Icons.add), 
          onPressed: () {
            list.updateClan(e);
            setState(() {});
          },
        ),
      )).toList(growable: false),
    );
  }
}
