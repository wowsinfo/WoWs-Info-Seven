import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';

class CommanderSkillPage extends StatefulWidget {
  const CommanderSkillPage({Key? key}) : super(key: key);

  @override
  State<CommanderSkillPage> createState() => _CommanderSkillPageState();
}

class _CommanderSkillPageState extends State<CommanderSkillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisation.of(context).wiki_skills),
      ),
      body: const Center(
        child: Text('Commander Skill Page'),
      ),
    );
  }
}
