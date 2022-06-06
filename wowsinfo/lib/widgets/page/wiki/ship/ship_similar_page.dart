import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';

class ShipSimilarPage extends StatelessWidget {
  const ShipSimilarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisation.of(context).warship_compare_similar),
      ),
      body: Container(),
    );
  }
}
