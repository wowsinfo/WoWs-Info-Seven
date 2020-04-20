import 'dart:math';

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
    final width = MediaQuery.of(context).size.width;
    // 100 can place 4 on iPhone 11
    final itemCount = min(8, max(width / 100, 2)).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('WikiAchievementPage')
      ),
      body: SafeArea(
        child: Scrollbar(
          child: buildGridView(itemCount),
        ),
      ),
    );
  }

  void onTap(BuildContext context, Achievement a) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          contentPadding: const EdgeInsets.all(2),
          leading: Image.network(
            a.image,
          ),
          title: Text(a.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(a.description)
        ),
      ),
    );
    // showModalBottomSheet(
    //   context: context, 
    //   builder: (context) => BottomSheet(
    //     onClosing: () => Navigator.pop(context), 
    //     builder: (context) => ListTile(
    //       title: Text(a.name),
    //       subtitle: Text(a.description),
    //     ),
    //   ),
    // );
  }

  GridView buildGridView(int itemCount) {
    if (player == null) {
      final achievment = cached.sortedAchievement.toList(growable: false);
      // Display everything
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemCount,
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
      final sorted = player.sorted.toList(growable: false);

      // Display whatever player has
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemCount,
          childAspectRatio: 0.96,
        ),
        itemCount: sorted.length,
        itemBuilder: (context, index) {
          final key = sorted[index].key;
          final count = sorted[index].value;
          final curr = cached.getAchievement(key);
          return InkWell(
            onTap: () => this.onTap(context, curr),
            child: FittedBox(child: buildPlayer(curr, count)),
          );
        },
      );
    }
  }

  Widget buildPlayer(Achievement curr, int count) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4),
          child: Image.network(curr.image),
        ),
        Text(count.toString()),
      ],
    );
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
