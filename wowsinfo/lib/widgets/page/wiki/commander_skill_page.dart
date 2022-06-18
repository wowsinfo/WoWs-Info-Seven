import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/extensions/list.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/commander_skills.dart';
import 'package:wowsinfo/providers/wiki/commander_skill_provider.dart';

class CommanderSkillPage extends StatefulWidget {
  const CommanderSkillPage({Key? key}) : super(key: key);

  @override
  State<CommanderSkillPage> createState() => _CommanderSkillPageState();
}

class _CommanderSkillPageState extends State<CommanderSkillPage> {
  late final _provider = CommanderSkillProvider(context, type: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisation.of(context).wiki_skills),
      ),
      body: ChangeNotifierProvider.value(
        value: _provider,
        builder: (context, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Consumer<CommanderSkillProvider>(
                builder: (context, value, child) {
                  return CupertinoSlidingSegmentedControl(
                    children: {
                      _provider.submarine: buildTitle(_provider.submarine),
                      _provider.destroyer: buildTitle(_provider.destroyer),
                      _provider.cruiser: buildTitle(_provider.cruiser),
                      _provider.battleship: buildTitle(_provider.battleship),
                      _provider.airCarrier: buildTitle(_provider.airCarrier),
                    },
                    groupValue: value.selectedTab,
                    onValueChanged: (value) => _provider.select(
                      value as String,
                    ),
                  );
                },
              ),
            ),
            const CommanderSkillBox(),
          ],
        ),
      ),
    );
  }

  Text buildTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
    );
  }
}

class CommanderSkillBox extends StatefulWidget {
  const CommanderSkillBox({Key? key}) : super(key: key);

  @override
  State<CommanderSkillBox> createState() => _CommanderSkillBoxState();
}

class _CommanderSkillBoxState extends State<CommanderSkillBox> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommanderSkillProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            provider.pointInfo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...provider.skills.enumerate().map((e) {
                  final index = e.key;
                  final skills = provider.skills[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ...skills.map(
                            (skill) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: buildItem(
                                skill,
                                provider.selectSkill,
                                provider.onLongPress,
                                provider.isSkillSelected,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: index < 3 ? 300 : 0,
                        child: const Divider(),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem(
    ShipSkill skill,
    void Function(ShipSkill) onTap,
    void Function(ShipSkill) onLongPress,
    bool Function(ShipSkill) isSelected,
  ) {
    final icon = skill.name;
    final selected = isSelected(skill);
    return InkWell(
      onTap: () => onTap(skill),
      onLongPress: () => onLongPress(skill),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            style: selected ? BorderStyle.solid : BorderStyle.none,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: SizedBox(
          width: 80,
          child: Image.asset(
            'gamedata/app/assets/skills/$icon.png',
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
