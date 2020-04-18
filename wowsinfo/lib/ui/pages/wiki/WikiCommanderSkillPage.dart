import 'dart:math';

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
  List<int> selectedSkills = [];
  // This tracks which tiers can be slected
  int maxTier = 1;
  List<Skill> skills = [];

  @override
  void initState() {
    super.initState();
    this.skills = cached.sortedCommanderSkill.toList(growable: false);
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
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(context),
        actions: [
          widget.simulation ? buildReset() : buildRotationLock(),
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
              final selected = selectedSkills.contains(index);
              return FittedBox(
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () => this.onTap(curr, index),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(curr.icon),
                      ),
                    ),
                    Positioned(
                      bottom: 4, right: 4,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        transitionBuilder: (w, a) => ScaleTransition(scale: a, child: w),
                        child: selected 
                        ? Icon(Icons.check)
                        : SizedBox.shrink(),
                      ),
                    ),
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
  void onTap(Skill curr, int index) {
    if (widget.simulation) {
      // Limit what can be chosen
      if (curr.tier > maxTier + 1) return;
      // Reset only (really troublesome if you can deselect)
      if (selectedSkills.contains(index)) return;

      final newPoints = points - curr.tier;
      // Shouldn't go negative
      if (newPoints < 0) return;

      // Update points
      setState(() {
        points = newPoints;
        selectedSkills.add(index);
        // Update max tier
        maxTier = max(maxTier, curr.tier);
      });
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

  IconButton buildReset() {
    return IconButton(
      icon: Icon(Icons.refresh), 
      onPressed: () {
        setState(() {
          points = 19;
          selectedSkills = [];
          maxTier = 1;
        });
      },
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
