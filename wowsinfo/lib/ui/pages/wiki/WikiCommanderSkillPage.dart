import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';

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
  /// Maximum 19 points currently
  int points = 19;
  List<String> skillNames = [];

  @override
  void initState() {
    super.initState();
    // Lock to horizontal
    if (widget.simulation) {
      // This delay is to show the transition animation
      // TODO: fix the grid because it doesn't work in hotizontal mode
      // Future.delayed(Duration(milliseconds: 500), () {
      //   setLandscape();
      // });
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
        title: buildTitle(context),
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
            itemBuilder: (context, index) {
              final curr = skills[index];
              final selected = skillNames.contains(curr.name);
              return FittedBox(
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () => this.onTap(curr),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(curr.icon),
                      ),
                    ),
                    selected ? Positioned(
                      bottom: 4, right: 4,
                      child: Icon(Icons.check)
                    ) : SizedBox.shrink(),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Text buildTitle(BuildContext context) {
    if (widget.simulation) return Text(points.toString());
    else return Text('Commander Skill');
  }

  /// Decide who to do when the skill icon is pressed
  void onTap(Skill curr) {
    if (widget.simulation) {
      // Update points
      final hasSelected = skillNames.contains(curr.name);
      if (hasSelected) {
        setState(() {
          points += curr.tier;
          skillNames.remove(curr.name);
        });
      } else {
        final newPoints = points - curr.tier;
        if (newPoints < 0) return;

        setState(() {
          points = newPoints;
          skillNames.add(curr.name);
        });
      }
    } else {
      // Show skill details
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            contentPadding: const EdgeInsets.all(2),
            leading: Image.network(curr.icon),
            title: Text(curr.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(curr.description),
          ),
        ),
      );
    }
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
