import 'package:flutter/material.dart';

/// An animated wrapper to show the widget with a simple popup animation
class PopupBox extends StatefulWidget {
  const PopupBox({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.keepAlive = false,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool keepAlive;

  @override
  State<PopupBox> createState() => _PopupBoxState();
}

class _PopupBoxState extends State<PopupBox>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}