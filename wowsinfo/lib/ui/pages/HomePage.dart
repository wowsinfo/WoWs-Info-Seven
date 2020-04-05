import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/AppProvider.dart';

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
      appBar: AppBar(
        title: Text('HomePage')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Dark'),
              onPressed: () {
                Provider.of<AppProvider>(context).setBrightness(Brightness.dark);
              },
            ),
            RaisedButton(
              child: Text('Light'),
              onPressed: () {
                Provider.of<AppProvider>(context).setBrightness(Brightness.light);
              },
            ),
            RaisedButton(
              child: Text('Red'),
              onPressed: () {
                Provider.of<AppProvider>(context).setColor(Colors.red);
              },
            ),
            RaisedButton(
              child: Text('Green'),
              onPressed: () {
                Provider.of<AppProvider>(context).setColor(Colors.green);
              },
            )
          ],
        ),
      ),
    );
  }
}
