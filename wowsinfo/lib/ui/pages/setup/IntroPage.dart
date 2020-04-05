import 'package:flutter/material.dart';
import 'WelcomeWidget.dart';
import 'AgreementWidget.dart';
import 'InitialSetupWidget.dart';

/// IntroPage class
class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selectedIndex,
      children: [
        WelcomeWidget(),
        AgreementWidget(),
        InitialSetupWidget(),
      ],
    );
  }
}
