import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

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
          child: buildGridView(context, itemCount),
        ),
      ),
    );
  }

  GridView buildGridView(BuildContext context, int itemCount) {
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
            child: Image(
              image: AssetImage(
                'gamedata/app/assets/achievements/$imageName.png',
              ),
            ),
            onTap: () {
              _logger.info(curr);
            },
          );
        });
  }
}
