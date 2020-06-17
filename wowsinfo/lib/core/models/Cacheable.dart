import 'package:wowsinfo/core/models/APIModel.dart';
import 'package:wowsinfo/core/providers/CachedData.dart';

/// The parent of all Cacheable models including GitHub ones
abstract class Cacheable extends APIModel {
  final CachedData cached;
  Cacheable(this.cached);
  
  /// Save this into disk, don't need to check for null
  void save();
}
