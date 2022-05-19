import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/shared/placeholder.dart';

class ShipPage extends StatefulWidget {
  const ShipPage({Key? key}) : super(key: key);

  @override
  State<ShipPage> createState() => _ShipPageState();
}

class _ShipPageState extends State<ShipPage> {
  final _ships = GameRepository.instance.shipList;
  final _logger = Logger('ShipPage');

  @override
  Widget build(BuildContext context) {
    final itemCount = Utils.of(context).getItemCount(8, 2, 150);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Page'),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: buildGridView(itemCount),
        ),
      ),
    );
  }

  GridView buildGridView(int itemCount) {
    // Display everything
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemCount,
        childAspectRatio: 1.0,
      ),
      itemCount: _ships.length,
      itemBuilder: (context, index) {
        final curr = _ships[index];
        final imageName = curr.index;
        return InkWell(
          onTap: () {
            showInfo(context, curr);
          },
          child: FittedBox(
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    'gamedata/app/assets/ships/$imageName.png',
                    errorBuilder: (context, error, stackTrace) {
                      // _logger.severe(
                      //   'Failed to load image: $imageName',
                      //   error,
                      //   stackTrace,
                      // );
                      return Image.asset(
                          'gamedata/app/assets/ships/_default.png');
                    },
                  ),
                  height: 80,
                ),
                Text(curr.tierString +
                    ' ' +
                    (GameRepository.instance.stringOf(curr.name) ?? '')),
              ],
            ),
          ),
        );
      },
    );
  }

  void showInfo(BuildContext context, Ship ship) {
    final additionalString = ship.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              title: Text(
                GameRepository.instance.stringOf(ship.name) ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                GameRepository.instance.stringOf(
                      ship.description,
                    ) ??
                    '' '\n\n' + additionalString,
              )),
        ),
      ),
    );
  }
}
