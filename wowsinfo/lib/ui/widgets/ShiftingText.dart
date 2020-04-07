import 'dart:async';

import 'package:flutter/material.dart';

/// ShiftingText class
class ShiftingText extends StatefulWidget {
  ShiftingText({Key key}) : super(key: key);

  @override
  _ShiftingTextState createState() => _ShiftingTextState();
}


class _ShiftingTextState extends State<ShiftingText> {
  double oneOpacity = 1.0;
  double onePadding = 24.0;
  double twoOpacity = 0;
  double twoPadding = 0;
  String oneText;
  String twoText;
  final animationDuration = const Duration(milliseconds: 300);
  final list  = ['RE', 'Origin', 'Pro', 'Ultimate', 'Gold'];

  @override
  void initState() {
    super.initState();

    // We do this everything 2 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('WoWs Info '),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: onePadding),
              child: Opacity(
                opacity: oneOpacity,
                child: Text('RE')
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: twoPadding),
              child: Opacity(
                opacity: twoOpacity,
                child: Text('Ultimate')
              ),
            ),
          ],
        )
      ],
    );
  }
}
