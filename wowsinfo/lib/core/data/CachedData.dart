import 'package:wowsinfo/core/data/LocalData.dart';

/// It handles cached data but mainly wiki
/// - it is usually read only
/// - it only updates when necessary
class CachedData extends LocalData {
  /// Singleton pattern 
  CachedData._init();
  static final CachedData shared = CachedData._init();

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}
