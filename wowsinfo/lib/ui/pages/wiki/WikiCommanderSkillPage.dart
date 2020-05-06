import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiItemCell.dart';

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
  List<String> selectedSkills = [];
  // This tracks which tiers can be slected
  int maxTier = 0;
  List<Skill> skills = [];

  @override
  void initState() {
    super.initState();
    this.skills = cached.sortedCommanderSkill.toList(growable: false);
    if (widget.simulation) {
      Future.delayed(Duration(milliseconds: 500)).then((value) {
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
    final size = MediaQuery.of(context).size;
    final maxWidth = min(size.width / 8, size.height / 4 - 30);
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
          child: Table(
            defaultColumnWidth: FixedColumnWidth(maxWidth),
            // There are only 4 levels now
            children: [1,2,3,4].map((level) {
              final tier = skills.where((e) => e.tier == level);
              return TableRow(
                children: tier.map((e) {
                  final curr = e;
                  final selected = selectedSkills.contains(e.name);
                  return FittedBox(
                    child: Stack(
                      children: <Widget>[
                        WikiItemCell(
                          item: curr,
                          onTap: () => this.onTap(curr, e.name),
                        ),
                        Positioned.fill(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            transitionBuilder: (w, a) => ScaleTransition(scale: a, child: w),
                            child: selected 
                            ? Icon(Icons.close, size: 72, color: Colors.black)
                            : SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(growable: false),
              );
            }).toList(growable: false),
          ),
        )
      ),
    );
  }

  Text buildTitle(BuildContext context) {
    if (widget.simulation) return Text(points.toString());
    else return Text('Commander Skill');
  }

  /// Decide who to do when the skill icon is pressed
  void onTap(Skill curr, String name) {
    if (widget.simulation) {
      // Limit what can be chosen
      if (curr.tier > maxTier + 1) return;
      // Reset only (really troublesome if you can deselect)
      if (selectedSkills.contains(name)) return;

      final newPoints = points - curr.tier;
      // Shouldn't go negative
      if (newPoints < 0) return;

      // Update points
      setState(() {
        points = newPoints;
        selectedSkills.add(name);
        // Update max tier
        maxTier = max(maxTier, curr.tier);
      });
    } else {
      // Show skill details
      curr.displayDialog(context);
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
          maxTier = 0;
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
