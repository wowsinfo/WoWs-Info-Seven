import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/ship_similar_page.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_icon.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_name.dart';

class SimilarShipList extends StatelessWidget {
  const SimilarShipList({
    Key? key,
    required this.source,
    required this.ships,
  }) : super(key: key);

  final Ship source;
  final List<Ship> ships;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 134,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    App.platformPageRoute(
                      builder: (_) => ShipSimilarPage(ship: source),
                    ),
                  );
                },
                child: Text(Localisation.of(context).warship_compare_similar),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ships.map((ship) {
                  final name = Localisation.instance.stringOf(ship.name);
                  return Column(
                    children: [
                      ShipIcon(name: ship.index),
                      ShipName(
                        name ?? '-',
                        isPremium: ship.isPremium,
                        isSpecial: ship.isSpecial,
                      ),
                    ],
                  );
                }).toList(growable: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
