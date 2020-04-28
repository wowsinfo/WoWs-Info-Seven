import 'package:flutter/material.dart';

/// ShipParameter class, it shows a LinearProgressIndicator
class ShipParameter extends StatelessWidget {
  final MapEntry<String, int> paramater;
  const ShipParameter({Key key, this.paramater}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make sure there are only 2 values and the value is not null
    if (paramater.value != null && paramater.value > 0) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(paramater.key),
                  Text(paramater.value.toString().replaceFirst('.0', '')),
                ],
              ),
            ),
            SizedBox(
              height: 4,
              child: LinearProgressIndicator(
                value: (paramater.value.toDouble()) / 100,
              ),
            )
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }
}
