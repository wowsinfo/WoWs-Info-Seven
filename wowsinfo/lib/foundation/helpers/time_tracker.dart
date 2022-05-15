import 'package:logging/logging.dart';

class TimeTracker {
  final _logger = Logger('TimeTracking');
  late final DateTime _timer;

  TimeTracker() {
    _timer = DateTime.now();
  }

  /// Log the time taken so far
  void log({String? message}) {
    final duration = DateTime.now().difference(_timer);
    _logger.info('${message ?? 'Time'} ${duration.inMilliseconds} ms');
  }
}
