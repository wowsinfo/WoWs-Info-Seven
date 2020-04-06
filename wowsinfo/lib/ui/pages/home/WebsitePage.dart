import 'package:flutter/material.dart';

/// WebsitePage class
class WebsitePage extends StatefulWidget {
  WebsitePage({Key key}) : super(key: key);

  @override
  _WebsitePageState createState() => _WebsitePageState();
}


class _WebsitePageState extends State<WebsitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebsitePage')
      ),
      body: Container(),
    );
  }
}
