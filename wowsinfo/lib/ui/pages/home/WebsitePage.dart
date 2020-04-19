import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/UI/WebsiteItem.dart';
import 'package:wowsinfo/core/models/UI/WebsiteSection.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:url_launcher/url_launcher.dart';

/// WebsitePage class
class WebsitePage extends StatelessWidget {
  final pref = Preference.shared;
  WebsitePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);
    final server = pref.gameServer;
    final domain = server.domain;
    final prefix = server.prefix;

    final websites = [
      WebsiteSection(
        'official', 
        'world of warships official website', 
        [
          WebsiteItem('This is a string', 'https://worldofwarships.$domain/'),
          WebsiteItem('This is a string', 'https://$prefix.wargaming.net/shop/wows/'),
          WebsiteItem('This is a string', 'http://wiki.wargaming.net/'),
          WebsiteItem('This is a string', 'https://www.facebook.com/wowsdevblog/posts/', favourite: true),
        ],
      ),
      WebsiteSection(
        'stats & utilies', 
        'websites about stats', 
        [
          WebsiteItem('This is a string', 'https://wowsinfo.firebaseapp.com/'),
          WebsiteItem('This is a string', server.numberWebsite, favourite: true),
          WebsiteItem('This is a string', 'https://sketchfab.com/tags/world-of-warships'),
          WebsiteItem('This is a string', 'https://gamemodels3d.com/games/worldofwarships/'),
          WebsiteItem('This is a string', 'https://wowsft.com/', favourite: true),
        ],
      ),
      WebsiteSection(
        'YouTuber', 
        'subtitle', 
        [
          WebsiteItem('This is a string', 'https://www.youtube.com/user/worldofwarshipsCOM'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/Flambass'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/cheesec4t'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/ichasegaming'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/BohemianEagle'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/MrNotser'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/ZoupGaming'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/pzkpasch'),
          WebsiteItem('This is a string', 'https://www.youtube.com/channel/UCXOZ2gv_ZGomWNcQU8BBfdQ'),
          WebsiteItem('This is a string', 'https://www.youtube.com/user/spzjess'),
        ],
      ),
      WebsiteSection(
        'In game', 
        'subtitle',
        [
          WebsiteItem('This is a string', 'https://$prefix.wargaming.net/id/signin/', favourite: true),
          WebsiteItem('This is a string', 'https://worldofwarships.$domain/userbonus/'),
          WebsiteItem('This is a string', 'https://worldofwarships.$domain/news_ingame/'),
          WebsiteItem('This is a string', 'https://armory.worldofwarships.$domain/'),
          WebsiteItem('This is a string', 'https://clans.worldofwarships.$domain/clans/gateway/wows/profile/'),
          WebsiteItem('This is a string', 'https://warehouse.worldofwarships.$domain/'),
          WebsiteItem('This is a string', 'https://logbook.worldofwarships.$domain/'),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('website_page_title'))
      ),
      body: ListView(
        children: websites.map((e) => ExpansionTile(
          initiallyExpanded: e.expanded,
          title: Text(e.title),
          subtitle: Text(e.subtitle),
          children: e.items.map((e) => ListTile(
            title: Text(e.title),
            subtitle: Text(e.link),
            onTap: () => launch(e.link),
            trailing: e.favourite ? Icon(Icons.star, color: Colors.orange) : SizedBox.shrink(),
          )).toList(growable: false),
        )).toList(growable: false),
      ),
    );
  }
}
