import 'package:flutter/material.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiAchievementPage.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiCommanderSkillPage.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiConsumablePage.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiGameMapPage.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiWarshipPage.dart';

/// WikiPage class
class WikiPage extends StatefulWidget {
  WikiPage({Key key}) : super(key: key);

  @override
  _WikiPageState createState() => _WikiPageState();
}


class _WikiPageState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);
    final wiki = [1,2,3,4,5,6];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('wiki_page_title'))
      ),
      body: ListView(
        children: [
            ListTile(
            title: Text('WIKI'),
            subtitle: Text('...'),
            leading: Icon(Icons.wallpaper),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiWarshipPage()));
            },
          ),
          ListTile(
            title: Text('updat'),
            subtitle: Text('...'),
            leading: Icon(Icons.wallpaper),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiConsumablePage()));
            },
          ),
          ListTile(
            title: Text('Map'),
            subtitle: Text('...'),
            leading: Icon(Icons.map),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiGameMapPage()));
            },
          ),
          ListTile(
            title: Text('Achievement'),
            subtitle: Text('...'),
            leading: Icon(Icons.map),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiAchievementPage()));
            },
          ),
          ListTile(
            title: Text('Commander Skill'),
            subtitle: Text('...'),
            leading: Icon(Icons.map),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiCommanderSkillPage()));
            },
          ),
        ],
      ),
    );
  }
}
