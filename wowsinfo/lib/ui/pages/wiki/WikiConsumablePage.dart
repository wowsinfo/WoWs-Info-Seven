import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('WikiConsumablePage')
      ),
      body: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
          ),
          itemCount: consumable.length,
          itemBuilder: (c, i) => InkWell(
            onTap: () {
              final curr = consumable.elementAt(i);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(curr.name),
                  content: ListTile(
                    title: Text(curr.description + '\n'),
                    subtitle: Text(curr.profileString),
                  ),
                ),
              );
            },
            child: FittedBox(
              child: Image.network(consumable.elementAt(i).image)
            ),
          ),
        ),
      ),
    );
  }
}
