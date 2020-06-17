import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/widgets/common/PlatformAlertDialog.dart';

/// This mimics the original home page back in early 2017, this is the start of everything
class OriginalPage extends StatelessWidget {
  OriginalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WoWs Info'),
        backgroundColor: Color(0XFF5A9CFF),
      ),
      body: Center(
          child: GestureDetector(
        child: Image.asset(
          'assets/images/search_button.png',
          height: 128,
          width: 128,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (c) => PlatformAlertDialog(
              title: Text('1'),
              content: Text('1'),
              androidActions: [
                FlatButton(child: Text('aaa'), onPressed: () {}),
              ],
              iosActions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
