import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiWarshipOverviewPage.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// WikiWarshipPage class
class WikiWarshipPage extends StatefulWidget {
  WikiWarshipPage({Key key}) : super(key: key);

  @override
  _WikiWarshipPageState createState() => _WikiWarshipPageState();
}

class _WikiWarshipPageState extends State<WikiWarshipPage> with SingleTickerProviderStateMixin {
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
    this.updateNation((cached.shipNation.keys.toList(growable: false)..shuffle()).first);
  }

  @override
  Widget build(BuildContext context) {
    final nation = cached.shipNation;
    final type = cached.shipType;

    return Scaffold(
      appBar: AppBar(
        title: Text('WikiWarshipPage'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline), 
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => WikiWarshipOverviewPage()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  SingleChildScrollView(
                    padding: EdgeInsets.all(8),
                    child: AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      vsync: this,
                      child: SizedBox(
                        width: Utils.of(context).isTablet() ? 200 : 100,
                        child: buildNationList(nation, context),
                      ),
                    )
                  ),
                  VerticalDivider(width: 1),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: WarshipList(ships: displayedShips.toList(growable: false), key: Key('$nation$type')),
                        )),
                      ],
                    )
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildTypeList(type),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTypeList(Map<String, String> type) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: cached.sortedTypeKeys.map((e) => FlatFilterChip(
        onSelected: (_) => this.updateType(e), 
        selected: e == this.type,
        label: Text(type[e]),
      )).toList(growable: false),
    );
  }

  Column buildNationList(Map<String, String> nation, BuildContext context) {
    return Column(
      children: cached.sortedNationKeys.map((e) => FlatFilterChip(
        selected: e == this.nation,
        onSelected: (_) => this.updateNation(e), 
        label: Text(nation[e], style: Theme.of(context).textTheme.overline),
      )).toList(growable: false),
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
  final List<Warship> ships;
  const WarshipList({Key key, @required this.ships}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        final width = MediaQuery.of(context).size.width;
        // 120 can place 3 on iPhone 11
        final itemCount = min(6, max(width / 150, 1)).toInt();
        return Scrollbar(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            itemCount: ships.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCount,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              final ship = ships[index];
              return WikiWarshipCell(ship: ship, showDetail: true, hero: true);
            }
          ),
        );
      },
    );
  }
}
