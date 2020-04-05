import 'package:flutter/material.dart';

/// WelcomeWidget class
class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WelcomeWidget')
      ),
      body: Container(),
    );
  }
}
