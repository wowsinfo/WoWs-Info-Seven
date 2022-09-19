import 'package:flutter/material.dart';

/// Animates the child for the first time based on its interval start
class DebutEffect extends StatefulWidget {
  const DebutEffect({
    Key? key,
    required this.child,
    this.intervalStart = 0,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.keepAlive = true,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final double intervalStart;
  final Curve curve;
  final bool keepAlive;

  @override
  State<DebutEffect> createState() => _DebutEffectState();
}

class _DebutEffectState extends State<DebutEffect>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // this is the magic, intervalStart will calculate when it should start
    final curve = Interval(
      widget.intervalStart,
      1,
      curve: widget.curve,
    );

    _controller = AnimationController(vsync: this, duration: widget.duration);

    // moving up animation
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 30),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curve,
      ),
    );

    // simple fade in
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curve,
      ),
    );

    // start it after a delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: _offsetAnimation.value,
        child: child,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
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
