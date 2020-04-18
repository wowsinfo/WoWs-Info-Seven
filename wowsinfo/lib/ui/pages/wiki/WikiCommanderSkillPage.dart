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
  void initState() {
    super.initState();
    // Lock to horizontal
    if (widget.simulation) {
      // This delay is to show the transition animation
      Future.delayed(Duration(milliseconds: 500), () {
        setLandscape();
      });
    }
  }

  @override
  void dispose() {
    setAllRotation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = cached.sortedCommanderSkill.toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Commander Skill'),
        actions: [
          widget.simulation ? SizedBox.shrink() : buildRotationLock(),
        ],
      ),
      bottomNavigationBar: widget.simulation ? null : buildBottomAppBar(context),
      body: SafeArea(
        child: Center(
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
      ),
    );
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: RaisedButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text('Simulation'),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => WikiCommanderSkillPage(simulation: true))),
      ),
    );
  }

  IconButton buildRotationLock() {
    return IconButton(
      icon: Icon(Icons.screen_rotation), 
      onPressed: () {
        if (!horizontalLock) {
          setLandscape();
          this.horizontalLock = true;
        } else {          
          setAllRotation();
          this.horizontalLock = false;
        }
      },
    );
  }

  /// Set to land scape only
  void setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// First, reset to portrait. Then, allow all rotations
  void setAllRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
