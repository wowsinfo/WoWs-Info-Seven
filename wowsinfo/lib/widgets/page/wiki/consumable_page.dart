import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/models/gamedata/ability.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/shared/placeholder.dart';

class ConsumablePage extends StatelessWidget {
  ConsumablePage({Key? key}) : super(key: key);

  final _consumaibles = GameRepository.instance.consumableList;
  final _logger = Logger('ConsumablePage');

  @override
  Widget build(BuildContext context) {
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumable Page'),
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
      itemCount: _consumaibles.length,
      itemBuilder: (context, index) {
        final curr = _consumaibles[index];
        final imageName = curr.icon;
        return InkWell(
          child: FittedBox(
            child: Image.asset(
              'gamedata/app/assets/consumables/$imageName.png',
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
      },
    );
  }

  void showInfo(BuildContext context, Ability achievement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: ListTile(
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
                GameRepository.instance.stringOf(achievement.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                GameRepository.instance.stringOf(
                  achievement.description,
                ),
              )),
        ),
      ),
    );
  }
}
