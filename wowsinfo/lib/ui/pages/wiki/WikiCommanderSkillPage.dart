import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final skills = cached.sortedCommanderSkill.toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Commander Skill')
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final curr = skills[index];
          return InkWell(
            onTap: () {},
            child: FittedBox(
              child: Image.network(curr.icon),
            ),
          );
        }
      ),
    );
  }
}
