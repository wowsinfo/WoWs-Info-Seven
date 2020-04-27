import 'package:flutter/material.dart';

/// ErrorIconWithText class
class ErrorIconWithText extends StatelessWidget {
  ErrorIconWithText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.error, color: Colors.red, size: 64),
        Text('Failed to load!')
      ],
    );
  }
}
