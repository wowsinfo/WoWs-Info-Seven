import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/app.dart';

// Set a max width for the dialog or any widgets
@immutable
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    Key? key,
    this.maxWidth,
    required this.child,
  }) : super(key: key);

  final double? maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? App.maxDialogWidth,
      ),
      child: child,
    );
  }
}
