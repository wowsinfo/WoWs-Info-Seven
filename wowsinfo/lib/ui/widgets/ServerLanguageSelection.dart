import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';

/// ServerLanguageSelection class
class ServerLanguageSelection extends StatefulWidget {

  ServerLanguageSelection({Key key}) : super(key: key);

  @override
  _ServerLanguageSelectionState createState() => _ServerLanguageSelectionState();
}

class _ServerLanguageSelectionState extends State<ServerLanguageSelection> {
  final cached = CachedData.shared;
  final pref = Preference.shared;
  String langCode;

  @override
  void initState() {
    super.initState();
    this.langCode = pref.serverLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);
    
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang.localised('server_language_selection_title'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            spacing: 2,
            alignment: WrapAlignment.center,
            children: cached.serverLanguage.entries.map((e) {
              return FlatFilterChip(
                label: Text(e.value),
                selected: e.key == langCode, 
                onSelected: (_) {
                  setState(() => this.langCode = e.key);
                  pref.setServerLanguage(e.key);
                }
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
