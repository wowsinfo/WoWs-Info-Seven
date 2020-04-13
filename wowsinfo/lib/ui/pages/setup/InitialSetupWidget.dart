import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/parsers/API/WikiEncyclopediaParser.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';
import 'package:wowsinfo/ui/widgets/GameServerSelection.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/ServerLanguageSelection.dart';

/// InitialSetupWidget class
class InitialSetupWidget extends StatefulWidget {
  InitialSetupWidget({Key key}) : super(key: key);

  @override
  _InitialSetupWidgetState createState() => _InitialSetupWidgetState();
}

class _InitialSetupWidgetState extends State<InitialSetupWidget> {
  final cached = CachedData.shared;
  bool loading = true;
  bool error = false;
  
  @override
  void initState() {
    super.initState();
    // Load some data here
    final parser = WikiEncyclopediaParser(GameServer.fromIndex(3));
    parser.download().then((value) {
      final e = parser.parse(value);
      if (e == null) {
        // TODO: handle error here
      } else {
        cached.saveEncyclopedia(e);
        setState(() => loading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InitialSetupWidget')
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GameServerSelection(),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 1000),
                  switchInCurve: Curves.easeIn,
                  child: buildLanguage(),
                ),
                // This box is to prevent overlapping
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) => InitialPage()));
          },
          child: Icon(Icons.done),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildLanguage() {
    if (loading) return Center(child: PlatformLoadingIndiactor());
    return ServerLanguageSelection();
  }
}
