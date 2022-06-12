import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/commander_skills.dart';
import 'package:wowsinfo/providers/wiki/commander_skill_provider.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';

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
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<CommanderSkillProvider>(
                builder: (context, value, child) {
                  return CupertinoSlidingSegmentedControl(
                    children: {
                      _provider.submarine: Text(_provider.submarine),
                      _provider.destroyer: Text(_provider.destroyer),
                      _provider.cruiser: Text(_provider.cruiser),
                      _provider.battleship: Text(_provider.battleship),
                      _provider.airCarrier: Text(_provider.airCarrier),
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
        Text(provider.pointInfo),
        ListView.builder(
          shrinkWrap: true,
          itemCount: provider.skills.length,
          itemBuilder: (context, index) {
            final skills = provider.skills[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...skills.map(
                  (skill) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: buildItem(
                      skill,
                      provider.selectSkill,
                      provider.isSkillSelected,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget buildItem(
    ShipSkill skill,
    void Function(ShipSkill) onTap,
    bool Function(ShipSkill) isSelected,
  ) {
    final icon = skill.name;
    final selected = isSelected(skill);
    return InkWell(
      onTap: () => onTap(skill),
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
