import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/providers/Preference.dart';
import 'package:wowsinfo/core/models/UI/WebsiteItem.dart';
import 'package:wowsinfo/core/models/UI/WebsiteSection.dart';
import 'package:wowsinfo/core/services/locale/AppLocalizationService.dart';
import 'package:url_launcher/url_launcher.dart';

/// WebsitePage class
class WebsitePage extends StatelessWidget {
  WebsitePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizationService.of(context);
    final server = Provider.of<Preference>(context, listen: false).gameServer;
    final domain = server.domain;
    final prefix = server.prefix;

    final websites = [
      WebsiteSection(
        'official', 
        'world of warships official website', 
        [
          WebsiteItem(lang.localised('website_official_site'), 'https://worldofwarships.$domain/'),
          WebsiteItem(lang.localised('website_premium'), 'https://$prefix.wargaming.net/shop/wows/'),
          WebsiteItem(lang.localised('website_global_wiki'), 'http://wiki.wargaming.net/'),
          WebsiteItem(lang.localised('website_dev_blog'), 'https://www.facebook.com/wowsdevblog/posts/', favourite: true),
        ],
      ),
      WebsiteSection(
        lang.localised('website_utility_title'), 
        'websites about stats', 
        [
          WebsiteItem(lang.localised('app_name'), 'https://wowsinfo.firebaseapp.com/'),
          WebsiteItem(lang.localised('website_numbers'), server.numberWebsite, favourite: true),
          WebsiteItem(lang.localised('website_models'), 'https://sketchfab.com/tags/world-of-warships'),
          WebsiteItem(lang.localised('website_game_models'), 'https://gamemodels3d.com/games/worldofwarships/'),
          WebsiteItem(lang.localised('website_wowsft'), 'https://wowsft.com/', favourite: true),
        ],
      ),
      WebsiteSection(
        lang.localised('website_youtuber_title'), 
        'subtitle',
        [
          WebsiteItem(lang.localised('website_youtuber_official'), 'https://www.youtube.com/user/worldofwarshipsCOM'),
          WebsiteItem(lang.localised('website_youtuber_flambass'), 'https://www.youtube.com/user/Flambass'),
          WebsiteItem(lang.localised('website_youtuber_flamu'), 'https://www.youtube.com/user/cheesec4t'),
          WebsiteItem(lang.localised('website_youtuber_iChaseGaming'), 'https://www.youtube.com/user/ichasegaming'),
          WebsiteItem(lang.localised('website_youtuber_jingles'), 'https://www.youtube.com/user/BohemianEagle'),
          WebsiteItem(lang.localised('website_youtuber_notser'), 'https://www.youtube.com/user/MrNotser'),
          WebsiteItem(lang.localised('website_youtuber_NoZoupForYou'), 'https://www.youtube.com/user/ZoupGaming'),
          WebsiteItem(lang.localised('website_youtuber_panzerknacker'), 'https://www.youtube.com/user/pzkpasch'),
          WebsiteItem(lang.localised('website_youtuber_Toptier'), 'https://www.youtube.com/channel/UCXOZ2gv_ZGomWNcQU8BBfdQ'),
          WebsiteItem(lang.localised('website_youtuber_yuro'), 'https://www.youtube.com/user/spzjess'),
        ],
      ),
      WebsiteSection(
        lang.localised('website_ingame_title'),
        lang.localised('website_wargming_login_subtitle'),
        [
          WebsiteItem(lang.localised('website_wargming_login'), 'https://$prefix.wargaming.net/id/signin/', favourite: true),
          WebsiteItem(lang.localised('website_userbonus'), 'https://worldofwarships.$domain/userbonus/'),
          WebsiteItem(lang.localised('website_news_ingame'), 'https://worldofwarships.$domain/news_ingame/'),
          WebsiteItem(lang.localised('website_ingame_armory'), 'https://armory.worldofwarships.$domain/'),
          WebsiteItem(lang.localised('website_ingame_clan'), 'https://clans.worldofwarships.$domain/clans/gateway/wows/profile/'),
          WebsiteItem(lang.localised('website_ingame_warehouse'), 'https://warehouse.worldofwarships.$domain/'),
          WebsiteItem(lang.localised('website_my_logbook'), 'https://logbook.worldofwarships.$domain/'),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('website_page_title'))
      ),
      body: Scrollbar(
        child: ListView(
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
      ),
    );
  }
}
