import 'package:flutter/foundation.dart';

@immutable
class GameInfo {
  const GameInfo({
    required this.regions,
    required this.types,
  });

  final List<String> regions;
  final List<String> types;

  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
        regions: List<String>.from(json['regions']),
        types: List<String>.from(json['types']),
      );
}
