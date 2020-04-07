import 'package:flutter/material.dart';

/// ShiftingText class
class ShiftingText extends StatefulWidget {
  ShiftingText({Key key}) : super(key: key);

  @override
  _ShiftingTextState createState() => _ShiftingTextState();
}


class _ShiftingTextState extends State<ShiftingText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('WoWs Info '),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RE'),
            Text('Ultimate'),
          ],
        )
      ],
    );
  }
}
