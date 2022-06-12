import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/localisation/localisation.dart';
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
    return const Center(
      child: Text('Commander Skill Box'),
    );
  }
}
