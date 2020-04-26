import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/others/Utils.dart';

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
      body: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: itemCount,
            childAspectRatio: 1.0,
          ),
          itemCount: consumable.length,
          itemBuilder: (c, i) {
            final curr = consumable.elementAt(i);
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: ListTile(
                      contentPadding: const EdgeInsets.all(2),
                      isThreeLine: true,
                      title: Text(curr.name),
                      subtitle: Text(curr.description + '\n\n' + curr.profileString),
                      leading: Image.network(curr.image),
                    ),
                  ),
                );
              },
              child: Tooltip(
                message: curr.name,
                child: FittedBox(
                  child: Image.network(consumable.elementAt(i).image)
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
