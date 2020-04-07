import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';

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
  List<String> list;
  final randomIndex = Random();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: animationDuration);
    oneOpacity = Tween<double>(begin: 1, end: 0).animate(controller);
    onePadding = Tween<double>(begin: 24, end: 0).animate(controller);
    twoOpacity = Tween<double>(begin: 0, end: 1).animate(controller);
    twoPadding = Tween<double>(begin: 0, end: 24).animate(controller)
      ..addListener(() => setState(() {}));


    // We do this everything 2 seconds
    Timer.periodic(Duration(seconds: 4), (_) {
      setState(() {
        twoText = list[randomIndex.nextInt(list.length)];
      });
      
      controller.forward().whenComplete(() {
        // Update label text
        controller.reset();
        setState(() {
          oneText = twoText;
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
    final lang = AppLocalization.of(context);
    list = [
      lang.localised('suffix_re'),
      lang.localised('suffix_origin'),
      lang.localised('suffix_origin+'),
      lang.localised('suffix_go'),
      lang.localised('suffix_pro'),
      lang.localised('suffix_ultimate'),
      lang.localised('suffix_future'),
      lang.localised('suffix_free'),
      lang.localised('suffix_new'),
      lang.localised('suffix_ultra'),
      // Symbols
      '#', '∞', 'Φ', 'Ω', '★',
      // Emoji
      '( ͡° ͜ʖ ͡°)', '¯\_(ツ)_/¯', '>_<', '0_0', '', '^_^', 'QAQ',
      // Years
      '2017', '2018', '2019', '2020',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('WoWs Info '),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: onePadding.value),
                child: Opacity(
                  opacity: oneOpacity.value,
                  // Provide a default value here
                  child: SizedBox(
                    height: 25,
                    child: Center(child: Text(oneText ?? lang.localised('suffix_re')))
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: twoPadding.value),
                child: Opacity(
                  opacity: twoOpacity.value,
                  // Provide a default value here, make sure it is the same as above
                  child: SizedBox(
                    height: 25,
                    child: Center(child: Text(twoText ?? lang.localised('suffix_re')))
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
