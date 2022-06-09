import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';

/// Handle hiding a widget while scrolling.
/// https://stackoverflow.com/a/68702926
class ScrollProvider extends ChangeNotifier {
  final _logger = Logger('ScrollProvider');

  bool _display = true;
  bool get display => _display;

  late final double _offset;
  double get offset => display ? _offset : 0.0;

  ScrollProvider({
    required ScrollController scroll,
    required AnimationController animation,
    required double height,
  }) {
    _offset = -height;
    scroll.addListener(() {
      final direction = scroll.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        if (_display) {
          animation.forward();
          _display = false;
          _logger.fine('Hiding widget');
          notifyListeners();
        }
      } else if (direction == ScrollDirection.forward) {
        if (!_display) {
          animation.reverse();
          _display = true;
          _logger.fine('Showing widget');
          notifyListeners();
        }
      }
    });
  }
}
