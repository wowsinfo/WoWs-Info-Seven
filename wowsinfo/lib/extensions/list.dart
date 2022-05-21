extension ListExtenstion<T> on List<T> {
  Iterable<MapEntry<int, T>> enumerate() {
    return asMap().entries.map((e) => MapEntry(e.key, e.value));
  }
}
