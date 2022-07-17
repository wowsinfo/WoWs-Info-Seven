import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/providers/wiki/ship_provider.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_cell.dart';

import 'ship_info_page.dart';

class ShipPage extends StatefulWidget {
  const ShipPage({Key? key, this.special = false}) : super(key: key);

  final bool special;

  @override
  State<ShipPage> createState() => _ShipPageState();
}

class _ShipPageState extends State<ShipPage> {
  @override
  Widget build(BuildContext context) {
    // 199 will fit 3 ships on most screens
    final itemCount = Utils.of(context).getItemCount(8, 2, 119);
    return ChangeNotifierProvider(
      create: (_) => ShipProvider(context, widget.special),
      builder: (context, widget) => Scaffold(
        appBar: AppBar(
          title: Text(Localisation.of(context).wiki_warships),
        ),
        body: SafeArea(
          child: Scrollbar(
            child: buildGridView(itemCount),
          ),
        ),
        floatingActionButton: buildFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget buildFAB() {
    return Consumer<ShipProvider>(
      builder: (context, provider, child) => FloatingActionButton.extended(
        onPressed: () => provider.showFilter(),
        icon: const Icon(Icons.filter_alt),
        label: Text(
          provider.filterString,
        ),
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
          final shipName = Localisation.instance.stringOf(curr.name) ?? '';
          return FittedBox(
            child: ShipCell(
              icon: imageName,
              name: '${curr.tierString} $shipName',
              isPremium: curr.isPremium,
              isSpecial: curr.isSpecial,
              isNew: curr.added == 1,
              onTap: () {
                Navigator.of(context).push(
                  App.platformPageRoute(
                    builder: (_) => ShipInfoPage(ship: curr),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
