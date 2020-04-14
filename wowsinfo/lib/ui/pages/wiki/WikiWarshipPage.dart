import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';

/// WikiWarshipPage class
class WikiWarshipPage extends StatefulWidget {
  WikiWarshipPage({Key key}) : super(key: key);

  @override
  _WikiWarshipPageState createState() => _WikiWarshipPageState();
}


class _WikiWarshipPageState extends State<WikiWarshipPage> {
  final cached = CachedData.shared;
  /// Only one nation can be shown at a time
  String nation;
  /// Only one type can be shown if selected, when nation changed type is cleared, select again to cancel
  String type;
  // One is saved for quick ship type filter
  Iterable<Warship> nationShips = [];
  Iterable<Warship> displayedShips = [];
  List<Warship> sortedList = [];

  @override
  void initState() {
    super.initState();
    // Grab a sorted list
    this.sortedList = cached.sortedWarshipList;
    // Select a random nation here
    this.updateNation((cached.shipNation.keys.toList()..shuffle()).first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WikiWarshipPage')
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            VerticalDivider(width: 1),
            SizedBox(
              width: 48,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 27,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: cached.shipNation.entries.map((e) => FlatFilterChip(
                          selected: e.key == this.nation,
                          onSelected: (_) => this.updateNation(e.key), 
                          label: Text(e.value),
                        )).toList(growable: false),
                      ),
                    ),
                  ),
                  Divider(height: 0)
                ],
              ),
            ),
            VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: WarshipList(displayedShips: displayedShips, key: Key('$nation$type')),
                  )),
                  Divider(height: 1),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: cached.shipType.entries.map((e) => FlatFilterChip(
                        onSelected: (_) => this.updateType(e.key), 
                        selected: e.key == this.type,
                        label: Text(e.value),
                      )).toList(growable: false),
                    ),
                  ),
                  Divider(height: 1),
                ],
              )
            ),
            VerticalDivider(width: 1),
          ],
        ),
      ),
    );
  }

  /// Get a list of ships with a certain nation
  void updateNation(String nation) {
    // Same nation, nothing needs to be done
    if (nation == this.nation) return;
    this.nationShips = this.sortedList.where((e) => e.nation == nation);
    setState(() {
      this.nation = nation;
      this.type = '';
      this.displayedShips = this.nationShips;
    });
  }

  /// Update ship type
  void updateType(String type) {
    if (type == this.type) {
      setState(() {
        this.type = '';
        this.displayedShips = this.nationShips;
      });
    } else {
      setState(() {
        this.type = type;
        this.displayedShips = this.nationShips.where((e) => e.type == type);
      });
    }
  }
}

class WarshipList extends StatelessWidget {
  const WarshipList({
    Key key,
    @required this.displayedShips,
  }) : super(key: key);

  final Iterable<Warship> displayedShips;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: this.displayedShips.map((e) => Text(e.name)).toList(growable: false),
    );
  }
}
