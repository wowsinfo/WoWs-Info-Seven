import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/pages/OriginalHomePage.dart';
import 'package:wowsinfo/ui/widgets/LoadingOverlay.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool showOriginal = true;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      this.setState(() {
        this.showOriginal = false;
      });
    });

    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        child: renderWidget(),
      ),
    );
  }

  Widget renderWidget() {
    return Stack(
      children: <Widget>[
        // Am I a genius, lol lol
        AppBar(),
        LoadingOverlay(),
      ],
    );

    if (showOriginal) {
      return OriginalHomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('HomePage')
        ),
        body: Container(),
      );
    }
  }
}
