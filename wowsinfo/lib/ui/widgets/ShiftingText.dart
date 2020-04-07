import 'dart:async';

import 'package:flutter/material.dart';

/// ShiftingText class
class ShiftingText extends StatefulWidget {
  ShiftingText({Key key}) : super(key: key);

  @override
  _ShiftingTextState createState() => _ShiftingTextState();
}


class _ShiftingTextState extends State<ShiftingText> with SingleTickerProviderStateMixin {
  Animation<double> oneOpacity;
  Animation<double> onePadding;
  Animation<double> twoOpacity;
  Animation<double> twoPadding;
  String oneText;
  String twoText;
  AnimationController controller;
  
  final animationDuration = const Duration(milliseconds: 500);
  final list  = ['RE', 'Origin', 'Pro', 'Ultimate', 'Gold'];
  int nameIndex = 0;

  @override
  void initState() {
    super.initState();

    oneText = list[nameIndex];
    twoText = list[nameIndex];
    controller = AnimationController(vsync: this, duration: animationDuration);
    oneOpacity = Tween<double>(begin: 1, end: 0).animate(controller);
    onePadding = Tween<double>(begin: 24, end: 0).animate(controller);
    twoOpacity = Tween<double>(begin: 0, end: 1).animate(controller);
    twoPadding = Tween<double>(begin: 0, end: 24).animate(controller)
      ..addListener(() => setState(() {}));
    
    // We do this everything 2 seconds
    Timer.periodic(Duration(milliseconds: 2000), (_) {
      nameIndex++;
      if (nameIndex >= list.length) nameIndex = 0;

      setState(() {
        twoText = list[nameIndex];
      });
      
      controller.forward().whenComplete(() {
        // Update label text
        controller.reset();
        setState(() {
          oneText = list[nameIndex];
        });
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              padding: EdgeInsets.only(top: onePadding.value),
              child: Opacity(
                opacity: oneOpacity.value,
                child: Text(oneText),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: twoPadding.value),
              child: Opacity(
                opacity: twoOpacity.value,
                child: Text(twoText),
              ),
            ),
          ],
        )
      ],
    );
  }
}
