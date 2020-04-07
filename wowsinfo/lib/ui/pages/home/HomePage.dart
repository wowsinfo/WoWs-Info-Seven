import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/widgets/DebugProviderWidget.dart';
import 'package:wowsinfo/ui/widgets/ShiftingText.dart';

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
        // title: Text(AppLocalization.of(context).localised('app_name')),
        title: ShiftingText(),
        leading: IconButton(
          icon: ImageIcon(AssetImage('assets/images/logo_white.png')), 
          onPressed: () {
            
          }
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings), 
            onPressed: () {}
          )
        ],
      ),
      body: DebugProviderWidget()
    );
  }
}
