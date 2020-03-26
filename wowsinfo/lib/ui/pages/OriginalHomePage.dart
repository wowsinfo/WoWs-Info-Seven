import 'package:flutter/material.dart';

/// This mimics the original home page back in early 2017
class OriginalHomePage extends StatelessWidget {
  OriginalHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WoWs Info'),
        backgroundColor: Color(0XFF5A9CFF),
      ),
      body: Center(
        child: Image.asset(
          'lib/assets/search_button',
          height: 128,
          width: 128,
        ),
      ),
    );
  }
}
