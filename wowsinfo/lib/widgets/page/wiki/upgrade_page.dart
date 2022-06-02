import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';
import 'package:wowsinfo/widgets/shared/max_width_box.dart';
import 'package:wowsinfo/widgets/shared/placeholder.dart';

class UpgradePage extends StatelessWidget {
  UpgradePage({Key? key}) : super(key: key);

  final _modernization = GameRepository.instance.modernizationList;
  final _logger = Logger('UpgradePage');

  @override
  Widget build(BuildContext context) {
    final itemCount = Utils.of(context).getItemCount(8, 2, 100);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Page'),
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
      itemCount: _modernization.length,
      itemBuilder: (context, index) {
        final curr = _modernization[index];
        final imageName = curr.icon;
        return InkWell(
          child: FittedBox(
            child: AssetImageLoader(
              name: 'gamedata/app/assets/upgrades/$imageName.png',
            ),
          ),
          onTap: () {
            showInfo(context, curr);
          },
        );
      },
    );
  }

  void showInfo(BuildContext context, Modernization upgrade) {
    final icon = upgrade.icon;
    final additionalString = upgrade.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: MaxWidthBox(
          child: ListTile(
              contentPadding: const EdgeInsets.all(2),
              title: Text(
                Localisation.instance.stringOf(upgrade.name) ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${Localisation.instance.stringOf(upgrade.description) ?? ''}\n$additionalString',
              )),
        ),
      ),
    );
  }
}
