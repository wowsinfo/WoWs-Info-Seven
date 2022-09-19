import 'package:flutter/material.dart';
import 'package:wowsinfo/extensions/list.dart';
import 'package:wowsinfo/widgets/animation/debut_effect.dart';

/// A single use widget to show children of a column with a popup animation
class PopupColumn extends StatefulWidget {
  const PopupColumn({
    Key? key,
    required this.children,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.keepAlive = true,
    // compatible with [Column]
    this.textDirection,
    this.textBaseline,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final bool keepAlive;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  @override
  State<PopupColumn> createState() => _PopupColumnState();
}

class _PopupColumnState extends State<PopupColumn>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final count = widget.children.length.toDouble();
    return Column(
      textDirection: widget.textDirection,
      textBaseline: widget.textBaseline,
      mainAxisAlignment: widget.mainAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      crossAxisAlignment: widget.crossAxisAlignment,
      verticalDirection: widget.verticalDirection,
      children: widget.children.enumerate().map((item) {
        final index = item.key;
        final child = item.value;
        return DebutEffect(
          intervalStart: index / count,
          keepAlive: widget.keepAlive,
          duration: widget.duration,
          curve: widget.curve,
          child: child,
        );
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
