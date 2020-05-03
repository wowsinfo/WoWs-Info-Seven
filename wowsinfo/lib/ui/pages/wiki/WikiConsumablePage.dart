import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiConsumable.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiItemCell.dart';

/// WikiConsumablePage class, this is shared by flag, consumable, upgrade and collection
class WikiConsumablePage extends StatefulWidget {
  final String title;
  WikiConsumablePage({Key key, this.title}) : super(key: key);

  @override
  _WikiConsumablePageState createState() => _WikiConsumablePageState();
}

class _WikiConsumablePageState extends State<WikiConsumablePage> {
  final cached = CachedData.shared;

  @override
  Widget build(BuildContext context) {
    final consumable = cached.sortedWikiConsumables;
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text('WikiConsumablePage')
      ),
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
                onTap: () => showItemInfo(context, curr),
                item: curr,
              );
            }
          ),
        ),
      ),
    );
  }

  Future showItemInfo(BuildContext context, Consumable curr) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          contentPadding: const EdgeInsets.all(2),
          isThreeLine: true,
          title: Text(curr.name),
          subtitle: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: curr.priceString + ' ',
                  style: TextStyle(color: curr.isGold ? Colors.orange : Colors.grey)
                ),
                TextSpan(
                  text: curr.description + '\n\n',
                  style: TextStyle(fontSize: 14)
                ),
                TextSpan(
                  text: curr.profileString,
                  style: TextStyle(fontSize: 12)
                ),
              ]
            ),
          ),
          leading: buildHeroImage(curr),
        ),
      ),
    );
  }

  Widget buildHeroImage(Consumable curr) {
    return Image.network(curr.image);
  }
}
