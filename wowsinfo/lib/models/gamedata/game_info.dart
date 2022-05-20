import 'package:flutter/foundation.dart';

@immutable
class GameInfo {
  const GameInfo({
    required this.regions,
    required this.types,
  });

  final List<String> regions;
  final List<String> types;

  /// preserved for future tiers
  static const List<String> preversedTiers = [
    '✱',
    '✸',
    '✹',
    '✺',
  ];

  // TODO: where should we put this??? in game info or ship info?
  static const List<String> tiers = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    '★',
  ];

  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
        regions: List<String>.from(json['regions']),
        types: List<String>.from(json['types']),
      );
}
