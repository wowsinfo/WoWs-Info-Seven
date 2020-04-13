import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';
import 'package:wowsinfo/core/parsers/API/WikiEncyclopediaParser.dart';
import 'package:wowsinfo/ui/widgets/GameServerSelection.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/ServerLanguageSelection.dart';

/// InitialSetupWidget class
class InitialSetupWidget extends StatefulWidget {
  InitialSetupWidget({Key key}) : super(key: key);

  @override
  _InitialSetupWidgetState createState() => _InitialSetupWidgetState();
}

class _InitialSetupWidgetState extends State<InitialSetupWidget> with SingleTickerProviderStateMixin {
  final cached = CachedData.shared;
  bool loading = true;
  
  @override
  void initState() {
    super.initState();
    // Load some data here
    final parser = WikiEncyclopediaParser(GameServer.fromIndex(3));
    parser.download().then((value) {
      final e = parser.parse(value);
      cached.saveEncyclopedia(e);
      setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InitialSetupWidget')
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GameServerSelection(),
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                vsync: this,
                child: buildLanguage(),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildLanguage() {
    if (loading) return PlatformLoadingIndiactor();
    return ServerLanguageSelection();
  }
}
