import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/page/wiki/achievement_page.dart';
import 'package:wowsinfo/widgets/page/wiki/ship_page.dart';
import 'package:wowsinfo/widgets/page/wiki/upgrade_page.dart';
import 'package:wowsinfo/widgets/shared/filter_ship_dialog.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  bool loadde = false;
  @override
  void initState() {
    super.initState();
    GameRepository.instance.initialise().then((value) {
      setState(() {
        loadde = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Page'),
      ),
      body: renderTest(),
    );
  }

  Widget renderTest() {
    if (!loadde) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                App.platformPageRoute(builder: (_) => UpgradePage()),
              );
            },
            child: const Text('Upgrades'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                App.platformPageRoute(builder: (_) => const ShipPage()),
              );
            },
            child: const Text('Ships'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                App.platformPageRoute(builder: (_) => AchievementPage()),
              );
            },
            child: const Text('Achievements'),
          ),
          TextButton(
            onPressed: () => showFilterShipDialog(context, (_) {}),
            child: const Text('ship filter'),
          )
        ],
      ),
    );
  }
}
