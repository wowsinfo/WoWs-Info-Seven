import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/UI/PersonalRating.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';

/// RatingBar class
class RatingBar extends StatelessWidget {
  final PersonalRating rating;
  final bool compact;
  RatingBar({Key key, this.rating, this.compact = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        color: rating.colour,
        height: 16,
      );
    } else {
      return Theme(
        data: ThemeData(
          buttonTheme: ButtonThemeData(
            buttonColor: rating.colour,
            textTheme: ButtonTextTheme.primary
          )
        ),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: RaisedButton(
            child: Text(rating.personalRating.myFixedString(0)),
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
