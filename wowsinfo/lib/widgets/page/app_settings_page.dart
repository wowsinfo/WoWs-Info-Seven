import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisation.of(context).app_name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _DropdownListTile(),
          ],
        ),
      ),
    );
  }
}

class _DropdownListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = [
      'A',
      'B',
      'C',
      'D',
    ];

    // PopupMenuButton should be used instead
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: Localisation.of(context).setting_game_server,
        border: InputBorder.none,
      ),
      isExpanded: true,
      value: '   Server A',
      items: list
          .map(
            (e) => DropdownMenuItem<String>(
                value: '   Server ' + e, child: Text('Server ' + e)),
          )
          .toList(growable: false),
      onChanged: (value) {},
    );
  }
}
