import 'consumable.dart';

const _tierList = [
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
  '✱',
  '✸',
  '✹',
  '✺',
];

class Ship {
  Ship({
    required this.name,
    required this.description,
    required this.year,
    required this.paperShip,
    required this.id,
    required this.index,
    required this.tier,
    required this.region,
    required this.type,
    required this.group,
    required this.consumables,
    required this.costXp,
    required this.costGold,
    required this.costCr,
    this.nextShips,
    this.airDefense,
  });

  final String name;
  final String description;
  final String year;
  final bool paperShip;
  final int id;
  final String index;
  final int tier;
  final String region;
  final String type;
  final String group;
  final List<List<Consumable>> consumables;
  final int costXp;
  final int costGold;
  final int costCr;
  final List<int>? nextShips;
  final AirDefense? airDefense;

  /// Convert to tier symbol, [tier] starts from 1.
  String get tierString => _tierList[tier - 1];

  @override
  String toString() {
    return 'Ship{name: $name, description: $description, year: $year, paperShip: $paperShip, id: $id, index: $index, tier: $tier, region: $region, type: $type, group: $group, consumables: $consumables, costXp: $costXp, costGold: $costGold, costCr: $costCr, nextShips: $nextShips, airDefense: $airDefense}';
  }

  int greater(Ship other) {
    // sort by tier, type, nation
    if (tier == other.tier) {
      if (type == other.type) {
        if (region == other.region) {
          return id - other.id;
        }
        return region.compareTo(other.region);
      }
      // cv first
      return other.type.compareTo(type);
    }

    return tier - other.tier;
  }

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        name: json['name'],
        description: json['description'],
        year: json['year'],
        paperShip: json['paperShip'],
        id: json['id'],
        index: json['index'],
        tier: json['tier'],
        region: json['region'],
        type: json['type'],
        group: json['group'],
        consumables: List<List<Consumable>>.from(json['consumables'].map((x) =>
            List<Consumable>.from(x.map((x) => Consumable.fromJson(x))))),
        costXp: json['costXP'],
        costGold: json['costGold'],
        costCr: json['costCR'],
        nextShips: json['nextShips'] == null
            ? null
            : List<int>.from(json['nextShips']),
        airDefense: json['airDefense'] == null
            ? null
            : AirDefense.fromJson(json['airDefense']),
      );
}

class AirDefense {
  AirDefense({
    this.medium,
    this.near,
    this.far,
    this.bubbles,
  });

  final AuraInfo? medium;
  final AuraInfo? near;
  final AuraInfo? far;
  final AirBubbles? bubbles;

  factory AirDefense.fromJson(Map<String, dynamic> json) => AirDefense(
        medium:
            json['medium'] == null ? null : AuraInfo.fromJson(json['medium']),
        near: json['near'] == null ? null : AuraInfo.fromJson(json['near']),
        far: json['far'] == null ? null : AuraInfo.fromJson(json['far']),
        bubbles: json['bubbles'] == null
            ? null
            : AirBubbles.fromJson(json['bubbles']),
      );
}

class AirBubbles {
  AirBubbles({
    required this.inner,
    required this.outer,
    required this.rof,
    required this.minRange,
    required this.maxRange,
    required this.spawnTime,
    required this.damage,
  });

  final int inner;
  final int outer;
  final num rof;
  final double minRange;
  final double maxRange;
  final double spawnTime;
  final num damage;

  factory AirBubbles.fromJson(Map<String, dynamic> json) => AirBubbles(
        inner: json['inner'],
        outer: json['outer'],
        rof: json['rof'],
        minRange: json['minRange'].toDouble(),
        maxRange: json['maxRange'].toDouble(),
        spawnTime: json['spawnTime'].toDouble(),
        damage: json['damage'],
      );
}

class AuraInfo {
  AuraInfo({
    required this.minRange,
    required this.maxRange,
    required this.hitChance,
    required this.damage,
    required this.rof,
    required this.dps,
  });

  final double minRange;
  final double maxRange;
  final double hitChance;
  final num damage;
  final double rof;
  final num dps;

  factory AuraInfo.fromJson(Map<String, dynamic> json) => AuraInfo(
        minRange: json['minRange'].toDouble(),
        maxRange: json['maxRange'].toDouble(),
        hitChance: json['hitChance'].toDouble(),
        damage: json['damage'],
        rof: json['rof'].toDouble(),
        dps: json['dps'],
      );
}
