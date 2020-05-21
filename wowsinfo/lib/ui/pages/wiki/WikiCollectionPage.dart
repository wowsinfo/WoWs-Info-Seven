import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiCollectionInfoPage.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiItemCell.dart';

/// WikiAchievementPage class
class WikiCollectionPage extends StatelessWidget {
  final cached = CachedData.shared;
  WikiCollectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final collection = cached.sortedWikiCollections;
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text('WikiCollectionPage')
      ),
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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiCollectionInfoPage(item: null))),
                item: curr,
              );
            }
          ),
        ),
      ),
    );
  }
}
