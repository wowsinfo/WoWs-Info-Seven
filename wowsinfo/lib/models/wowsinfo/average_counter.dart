/// Calculate the average values
class AverageCounter {
  num _total = 0;
  int _count = 0;
  double _average = 0;

  double get average => _average;

  void add(num value) {
    _total += value;
    _count++;
    _average = _total / _count;
  }
}
