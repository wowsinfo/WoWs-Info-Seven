import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowsinfo/core/models/UI/PersonalRating.dart';

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
            child: Text(rating.getComment(context), textAlign: TextAlign.center),
            onPressed: () {
              // Convert the map to
              final ratings = rating.getRatingMap(context).asMap();
              final radius = BorderRadius.circular(16);
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: radius,
                  ),
                  child: ClipRRect(
                    borderRadius: radius,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ...ratings.map((i, e) {
                            final colour = rating.getColour(i);
                            final style = getStyle(colour);
                            return MapEntry(i, Container(
                              color: colour,
                              child: ListTile(
                                title: Text(e.key, style: style),
                                trailing: Text(e.value, style: style),
                              ),
                            ));
                          }).values.toList(growable: false),
                          ListTile(
                            title: Text('Read more on wows-number.com'),
                            subtitle: Text('by Wiochi'),
                            onTap: () => launch('https://wows-numbers.com/personal/rating'),
                          ),
                        ],
                      )
                    ),
                  ),
                )
              );
            },
          ),
        ),
      );
    }
  }

  TextStyle getStyle(MaterialColor colour) {
    return TextStyle(
      color: ThemeData.estimateBrightnessForColor(colour) == Brightness.dark
       ? Colors.white 
       : Colors.black
    );
  }
}
