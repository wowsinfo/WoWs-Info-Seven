import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/modifier.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

@immutable
class Modernization {
  const Modernization({
    required this.slot,
    required this.id,
    required this.costCR,
    required this.name,
    required this.icon,
    required this.description,
    this.level,
    this.type,
    this.nation,
    required this.modifiers,
    this.ships,
    this.excludes,
    this.special,
    this.unique,
  });

  final int slot;
  final int id;
  final int costCR;
  final String name;
  final String icon;
  final String description;
  final List<int>? level;
  final List<String>? type;
  final List<String>? nation;
  final Modifiers modifiers;
  final List<int>? ships;
  final List<int>? excludes;
  final bool? special;
  final bool? unique;

  @override
  String toString() {
    final description = modifiers.toString();
    if (unique != null && ships != null) {
      // try to get the ship name for unique upgrades
      final shipName = GameRepository.instance.shipNameOf(
        ships!.first.toString(),
      );
      if (shipName != null) {
        return '$description\n$shipName';
      }
    }

    return description;
  }

  int greater(Modernization other) {
    if (special == other.special && unique == other.unique) {
      return id - other.id;
    }

    if (special == null && unique == null) return 2;
    if (unique == null && other.unique != null) return 1;
    return -1;
  }

  bool isFor(Ship ship) {
    // special cases, certain ships can bypass all conditions
    final shipId = ship.id;
    if (ships != null && ships!.contains(shipId)) {
      return true;
    }

    if (excludes != null && excludes!.contains(shipId)) {
      return false;
    }

    // need to match ship nation/region, tier and type if they are valid
    // it is necesary to make an emptry list here because region, type and tier can all be null
    // this means that the upgrade is valid for selected ships like special or unique
    final region = nation ?? [];
    final type = this.type ?? [];
    final tier = level ?? [];

    if (!region.contains(ship.region)) return false;
    if (!type.contains(ship.type)) return false;
    if (!tier.contains(ship.tier)) return false;
    return true;
  }

  factory Modernization.fromJson(Map<String, dynamic> json) => Modernization(
        slot: json['slot'],
        id: json['id'],
        costCR: json['costCR'],
        name: json['name'],
        icon: json['icon'],
        description: json['description'],
        level: json['level'] == null ? null : List<int>.from(json['level']),
        type: json['type'] == null ? null : List<String>.from(json['type']),
        nation:
            json['nation'] == null ? null : List<String>.from(json['nation']),
        modifiers: Modifiers.fromJson(json['modifiers']),
        ships: json['ships'] == null ? null : List<int>.from(json['ships']),
        excludes:
            json['excludes'] == null ? null : List<int>.from(json['excludes']),
        special: json['special'],
        unique: json['unique'],
      );
}
