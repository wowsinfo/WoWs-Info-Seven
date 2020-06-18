import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/providers/CachedData.dart';
import 'package:wowsinfo/core/utils/Utils.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiCollectionInfoPage.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiItemCell.dart';

/// WikiAchievementPage class
class WikiCollectionPage extends StatelessWidget {
  WikiCollectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cached = Provider.of<CachedData>(context, listen: false);
    final collection = cached.sortedWikiCollections;
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);

    return Scaffold(
      appBar: AppBar(title: Text('WikiCollectionPage')),
      body: SafeArea(
        child: Scrollbar(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemCount,
                childAspectRatio: 1.0,
              ),
              itemCount: collection.length,
              itemBuilder: (c, i) {
                final curr = collection.elementAt(i);
                return WikiItemCell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => WikiCollectionInfoPage(item: null))),
                  item: curr,
                );
              }),
        ),
      ),
    );
  }
}
