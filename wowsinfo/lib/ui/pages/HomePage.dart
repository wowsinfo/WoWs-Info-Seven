import 'package:flutter/material.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        child: renderWidget(),
      ),
    );
  }

  /// Render the children of AnimatedSwitcher
  Widget renderWidget() {
   return Scaffold(
      appBar: AppBar(

        title: Text('HomePage')
      ),
      body: Center(
        child: RaisedButton(onPressed: () {})
      ),
    );
  }
}
