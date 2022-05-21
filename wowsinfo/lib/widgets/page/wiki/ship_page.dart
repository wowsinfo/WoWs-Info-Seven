import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/providers/wiki/ship_provider.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class ShipPage extends StatefulWidget {
  const ShipPage({Key? key}) : super(key: key);

  @override
  State<ShipPage> createState() => _ShipPageState();
}

class _ShipPageState extends State<ShipPage> {
  late final _provider = ShipProvider(context);

  @override
  Widget build(BuildContext context) {
    final itemCount = Utils.of(context).getItemCount(8, 2, 150);
    return ChangeNotifierProvider.value(
      value: _provider,
      builder: (context, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Upgrade Page'),
        ),
        body: SafeArea(
          child: Scrollbar(
            child: buildGridView(itemCount),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _provider.showFilter(),
          icon: const Icon(Icons.filter_alt),
          label: Consumer<ShipProvider>(
            builder: (context, provider, child) => Text(
              provider.filterString,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget buildGridView(int itemCount) {
    // Display everything
    return Consumer<ShipProvider>(
      builder: (context, provider, child) => GridView.builder(
        padding: const EdgeInsets.only(bottom: 64),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemCount,
          childAspectRatio: 1.0,
        ),
        itemCount: provider.shipCount,
        itemBuilder: (context, index) {
          final curr = provider.shipList[index];
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
                        return Image.asset(_provider.defaultImage);
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
      ),
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
            ),
          ),
        ),
      ),
    );
  }
}
