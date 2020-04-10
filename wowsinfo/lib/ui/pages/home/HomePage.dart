import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/pages/OriginalPage.dart';
import 'package:wowsinfo/ui/widgets/DebugProviderWidget.dart';
import 'package:wowsinfo/ui/widgets/ShiftingText.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pressCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(AppLocalization.of(context).localised('app_name')),
        title: ShiftingText(),
        leading: IconButton(
          icon: ImageIcon(AssetImage('assets/images/logo_white.png')), 
          onPressed: () {
            // Only show snackbar when there are three more to go, 3, 2, 1
            if (pressCount > 2 && pressCount <= 5) {
              final egg = SnackBar(
                content: Text('${6 - pressCount}...'), 
                duration: Duration(milliseconds: 500),
              );
              Scaffold.of(context).showSnackBar(egg);
            }

            if (pressCount > 5) {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) => OriginalPage()));
            } else {
              setState(() {
                pressCount += 1;
              });
            }
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
