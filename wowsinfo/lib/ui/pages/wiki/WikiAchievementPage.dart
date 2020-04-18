import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiAchievement.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerAchievement.dart';

/// WikiAchievementPage class
class WikiAchievementPage extends StatelessWidget {
  /// Optional player field
  final PlayerAchievement player;
  final cached = CachedData.shared;
  WikiAchievementPage({Key key, this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WikiAchievementPage')
      ),
      body: SafeArea(
        child: Scrollbar(
          child: buildGridView(),
        ),
      ),
    );
  }

  void onTap(BuildContext context, Achievement a) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Image.network(
              a.image,
              width: 24, height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(a.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            )
          ],
        ),
        content: Text(a.description),
      ),
    );
  }

  GridView buildGridView() {
    if (player == null) {
      final achievment = cached.sortedAchievement.toList(growable: false);
      // Display everything
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        itemCount: achievment.length,
        itemBuilder: (context, index) {
          final curr = achievment[index];
          return InkWell(
            onTap: () => this.onTap(context, curr),
            child: buildImage(curr),
          );
        }
      );
    } else {
      // Sort player achievment by count
      final sorted = player.achievement.entries
        .toList(growable: false)..sort((a, b) => a.value - b.value);

      // Display whatever player has
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.9,
        ),
        itemCount: sorted.length,
        itemBuilder: (context, index) {
          final key = sorted[index].key;
          final count = sorted[index].value;
          final curr = cached.getAchievement(key);
          return InkWell(
            onTap: () => this.onTap(context, curr),
            child: Column(
              children: <Widget>[
                buildImage(curr),
                Text(count.toString()),
              ],
            ),
          );
        },
      );
    }
  }

  Padding buildImage(Achievement curr) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(
        child: Image.network(curr.hidden > 0 ? curr.imageInactive : curr.image),
      ),
    );
  }
}
