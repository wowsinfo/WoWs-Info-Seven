import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/providers/CachedData.dart';
import 'package:wowsinfo/utils/Utils.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiItemCell.dart';

/// WikiConsumablePage class, this is shared by flag, consumable, upgrade and collection
class WikiConsumablePage extends StatefulWidget {
  final String title;
  WikiConsumablePage({Key key, this.title}) : super(key: key);

  @override
  _WikiConsumablePageState createState() => _WikiConsumablePageState();
}

class _WikiConsumablePageState extends State<WikiConsumablePage> {
  @override
  Widget build(BuildContext context) {
    final cached = Provider.of<CachedData>(context, listen: false);
    final consumable = cached.sortedWikiConsumables;
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);

    return Scaffold(
      appBar: AppBar(title: Text('WikiConsumablePage')),
      body: SafeArea(
        child: Scrollbar(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemCount,
                childAspectRatio: 1.0,
              ),
              itemCount: consumable.length,
              itemBuilder: (c, i) {
                final curr = consumable.elementAt(i);
                return WikiItemCell(
                  onTap: () => curr.displayDialog(context),
                  item: curr,
                );
              }),
        ),
      ),
    );
  }
}
