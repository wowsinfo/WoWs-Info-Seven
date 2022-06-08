abstract class Counter {
  void add(num value);
}

/// Calculate the average values
class AverageCounter implements Counter {
  num _total = 0;
  int _count = 0;
  double _average = 0;

  double get average => _average;

  @override
  void add(num value) {
    _total += value;
    _count++;
    _average = _total / _count;
  }
}

/// Calculate the total values
class TotalCounter implements Counter {
  num _total = 0;
  num get total => _total;

  @override
  void add(num value) {
    _total += value;
  }
}
