import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// This mimics the original home page back in early 2017
class OriginalPage extends StatelessWidget {
  OriginalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('WoWs Info'),
        backgroundColor: Color(0XFF5A9CFF),
      ),
      body: Center(
        child: Image.asset(
          'lib/assets/search_button.png',
          height: 128,
          width: 128,
        ),
      ),
    );
  }
}
