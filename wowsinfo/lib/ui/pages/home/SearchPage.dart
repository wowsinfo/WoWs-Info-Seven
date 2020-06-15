import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';
import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/parsers/API/SearchClanResultParser.dart';
import 'package:wowsinfo/core/parsers/API/SearchPlayerResultParser.dart';
import 'package:wowsinfo/ui/pages/player/ClanInfoPage.dart';
import 'package:wowsinfo/ui/pages/player/PlayerInfoPage.dart';

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
  Preference pref;

  @override
  void initState() {
    super.initState();
    /// TODO: this page needs to be updated because now I am using provider
    this.pref = Provider.of<Preference>(context, listen: false);
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
                child: ClanList(clans: clans, key: Key(clans.length.toString()), pref: pref),
              ),
              Divider(),
              ListTile(title: Text('Player - ${players.length}')),
              AnimatedSwitcher(
                transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
                duration: Duration(milliseconds: 300),
                child: PlayerList(players: players, key: Key(players.length.toString()), pref: pref),
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
    final player = parser.parse(await parser.download(appendLang: false));
    if (player != null) {
      setState(() => this.players = player.players ?? []);
    }
  }
}

class PlayerList extends StatefulWidget {
  const PlayerList({
    Key key,
    @required this.players,
    @required this.pref,
  }) : super(key: key);

  final List<Player> players;
  final Preference pref;

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.players.map((e) => ListTile(
        title: Text(e.nickname),
        subtitle: Text(e.playerId.toString()),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerInfoPage(player: e))),
        trailing: buildIconButton(e),
      )).toList(growable: false),
    );
  }

  buildIconButton(Player e) {
    final list = widget.pref.contactList;
    final remove = list.containsPlayer(e);
    return IconButton(
      icon: remove ? Icon(Icons.remove) : Icon(Icons.add),
      onPressed: () {
        list.updatePlayer(e, add: !remove);
        setState(() {});
      },
    );
  }
}

class ClanList extends StatefulWidget {
  const ClanList({
    Key key,
    @required this.clans,
    @required this.pref
  }) : super(key: key);

  final List<Clan> clans;
  final Preference pref;

  @override
  _ClanListState createState() => _ClanListState();
}

class _ClanListState extends State<ClanList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.clans.map((e) => ListTile(
        title: Text(e.tag),
        subtitle: Text(e.clanIdString),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ClanInfoPage(clan: e))),
        trailing: buildIconButton(e),
      )).toList(growable: false),
    );
  }

  buildIconButton(Clan e) {
    final list = widget.pref.contactList;
    final remove = list.containsClan(e);
    return IconButton(
      icon: remove ? Icon(Icons.remove) : Icon(Icons.add),
      onPressed: () {
        list.updateClan(e, add: !remove);
        setState(() {});
      },
    );
  }
}
