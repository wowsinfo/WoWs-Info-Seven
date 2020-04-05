import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wowsinfo/core/Utils.dart';
import 'package:wowsinfo/ui/pages/OriginalPage.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool showOriginal = true;

  @override
  void initState() {
    super.initState();
    Utils.delay(3000).then((_) {
      setState(() {
        showOriginal = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        child: renderWidget(),
      ),
    );
  }

  /// Render the children of AnimatedSwitcher
  Widget renderWidget() {
    if (showOriginal) {
      return OriginalPage();
    } else {
      return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('HomePage')
        ),
        body: Container(),
      );
    }
  }
}
