import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/UI/WebsiteItem.dart';
import 'package:wowsinfo/core/models/UI/WebsiteSection.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';

/// WebsitePage class
class WebsitePage extends StatelessWidget {
  WebsitePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);

    final websites = [
      WebsiteSection(
        'title', 
        'subtitle', 
        [
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
        ],
      ),
      WebsiteSection(
        'title', 
        'subtitle', 
        [
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
        ],
      ),
      WebsiteSection(
        'title', 
        'subtitle', 
        [
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
        ],
      ),
      WebsiteSection(
        'title', 
        'subtitle', 
        [
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
          WebsiteItem('This is a string', 'This is a string'),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.localised('website_page_title'))
      ),
      body: ListView(
        children: websites.map((e) => ExpansionTile(
          title: Text(e.title),
          subtitle: Text(e.subtitle),
          children: e.items.map((e) => ListTile(
            title: Text(e.title),
            subtitle: Text(e.link),
          )).toList(growable: false),
        )).toList(growable: false),
      ),
    );
  }
}
