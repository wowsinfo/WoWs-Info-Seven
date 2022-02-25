import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/providers/CachedData.dart';
import 'package:wowsinfo/models/Wiki/WikiCollectionItem.dart';
import 'package:wowsinfo/utils/Utils.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiItemCell.dart';

/// WikiAchievementPage class
class WikiCollectionInfoPage extends StatelessWidget {
  /// Optional item field
  final CollectionItem item;
  WikiCollectionInfoPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cached = Provider.of<CachedData>(context, listen: false);
    final consumable = cached.sortedWikiConsumables;
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
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
