/// A basic interface to allow models to be merged
abstract class Mergeable<T> {
  /// Merge with another object
  merge(T object);
  /// Merge with a list of objects
  mergeAll(Iterable<T> object);
}
