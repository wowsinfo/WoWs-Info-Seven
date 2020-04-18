import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowsinfo/core/data/CachedData.dart';

/// WikiCommanderSkillPage class
class WikiCommanderSkillPage extends StatefulWidget {
  /// Simulation mode will mark you selected skill
  final bool simulation;

  WikiCommanderSkillPage({Key key, this.simulation = false}) : super(key: key);

  @override
  _WikiCommanderSkillPageState createState() => _WikiCommanderSkillPageState();
}

class _WikiCommanderSkillPageState extends State<WikiCommanderSkillPage> {
  final cached = CachedData.shared;
  bool horizontalLock = false;

  @override
  void dispose() {
    // Reset Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Allow everything
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = cached.sortedCommanderSkill.toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Commander Skill'),
        actions: [
          IconButton(
            icon: Icon(Icons.screen_rotation), 
            onPressed: () {
              if (!horizontalLock) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
                this.horizontalLock = true;
              } else {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
                
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
                this.horizontalLock = false;
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
          ),
          itemCount: skills.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final curr = skills[index];
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(
                  child: Image.network(curr.icon),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
