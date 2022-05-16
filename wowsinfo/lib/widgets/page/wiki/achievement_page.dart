import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/models/gamedata/achievement.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/shared/placeholder.dart';

class AchievementPage extends StatelessWidget {
  AchievementPage({Key? key}) : super(key: key);

  final _achievements = GameRepository.instance.achievements.values.toList();
  final _logger = Logger('AchievementPage');

  @override
  Widget build(BuildContext context) {
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievement Page'),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: buildGridView(itemCount),
        ),
      ),
    );
  }

  GridView buildGridView(int itemCount) {
    // Display everything
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemCount,
          childAspectRatio: 1.0,
        ),
        itemCount: _achievements.length,
        itemBuilder: (context, index) {
          final curr = _achievements[index];
          final imageName = curr.icon;
          return InkWell(
            child: FittedBox(
              child: Image.asset(
                'gamedata/app/assets/achievements/$imageName.png',
                errorBuilder: (context, error, stackTrace) {
                  // _logger.severe(
                  //   'Failed to load image: $imageName',
                  //   error,
                  //   stackTrace,
                  // );
                  return const IconPlaceholder();
                },
              ),
            ),
            onTap: () {
              showInfo(context, curr);
            },
          );
        });
  }

  void showInfo(BuildContext context, Achievement achievement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
            contentPadding: const EdgeInsets.all(2),
            leading: Image.asset(
              'gamedata/app/assets/achievements/${achievement.icon}.png',
              errorBuilder: (context, error, stackTrace) {
                // _logger.severe(
                //   'Failed to load image: $imageName',
                //   error,
                //   stackTrace,
                // );
                return const IconPlaceholder();
              },
            ),
            title: Text(
              achievement.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(achievement.description)),
      ),
    );
  }
}
