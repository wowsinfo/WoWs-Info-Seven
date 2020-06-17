import 'package:wowsinfo/core/providers/CachedData.dart';
import 'package:wowsinfo/core/models/APIModel.dart';

/// The parent of all Cacheable models including GitHub ones
abstract class Cacheable extends APIModel {
  final cached = CachedData.shared;

  /// Save this into disk, don't need to check for null
  void save();
}
