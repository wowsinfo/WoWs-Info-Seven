import 'package:flutter/material.dart';

/// CrossTick class
class CrossTick extends StatelessWidget {
  final bool value;
  const CrossTick({Key key, this.value = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value 
    ? Icon(Icons.check, color: Colors.green) 
    : Icon(Icons.close, color: Colors.red);
  }
}
