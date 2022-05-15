import 'package:flutter/foundation.dart';

import 'consumable.dart';

class Aircraft {
  Aircraft({
    required this.type,
    required this.nation,
    required this.name,
    required this.health,
    required this.totalPlanes,
    required this.visibility,
    required this.speed,
    required this.aircraft,
  });

  final String type;
  final String nation;
  final String name;
  final num? health;
  final int? totalPlanes;
  final double? visibility;
  final double? speed;

  /// This field can be empty for older entries (post CV rework).
  final AircraftInfo? aircraft;

  factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        type: json['type'],
        nation: json['nation'],
        name: json['name'],
        health: json['health'],
        totalPlanes: json['totalPlanes'],
        visibility: json['visibility'],
        speed: json['speed'],
        aircraft: json['aircraft'] == null
            ? null
            : AircraftInfo.fromJson(json['aircraft']),
      );
}

@immutable
class AircraftInfo {
  const AircraftInfo({
    required this.restoreTime,
    required this.maxAircraft,
    required this.attacker,
    required this.attackCount,
    required this.cooldown,
    required this.minSpeed,
    required this.maxSpeed,
    required this.boostTime,
    required this.boostReload,
    required this.bombName,
    required this.consumables,
  });

  final double restoreTime;
  final int maxAircraft;
  final int attacker;
  final int attackCount;
  final num cooldown;
  final double minSpeed;
  final double maxSpeed;
  final num boostTime;
  final double? boostReload;
  final String bombName;
  final List<List<Consumable>>? consumables;

  factory AircraftInfo.fromJson(Map<String, dynamic> json) => AircraftInfo(
        restoreTime: json['restoreTime'],
        maxAircraft: json['maxAircraft'],
        attacker: json['attacker'],
        attackCount: json['attackCount'],
        cooldown: json['cooldown'].toDouble(),
        minSpeed: json['minSpeed'].toDouble(),
        maxSpeed: json['maxSpeed'].toDouble(),
        boostTime: json['boostTime'],
        boostReload: json['boostReload'],
        bombName: json['bombName'],
        consumables: json['consumables'] == null
            ? null
            : List<List<Consumable>>.from(
                json['consumables'].map((x) => List<Consumable>.from(
                      x.map((x) => Consumable.fromJson(x)),
                    )),
              ),
      );
}
