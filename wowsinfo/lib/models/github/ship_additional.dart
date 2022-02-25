import 'dart:convert';

import 'package:wowsinfo/models/Cacheable.dart';

/// This is the `ShipInfoAdditional` class
class ShipInfoAdditional implements Cacheable {
  double alphaPiercingHE;
  AP ap;
  double sigma;
  List<Consumable> consumable;
  List<int> permoflage;

  ShipInfoAdditional.fromJson(Map<String, dynamic> json) {
    this.alphaPiercingHE = json['alphaPiercingHE'];
    this.ap = AP.fromJson(json['ap']);
    this.sigma = json['sigma'];
    this.consumable = (json['consumables'] as List)
        .map((e) => Consumable.fromJson(e))
        .toList(growable: false);
    this.permoflage = (json['permoflages'] as List).cast<int>();
  }

  Map<String, dynamic> toJson() {
    return {
      'alphaPiercingHE': this.alphaPiercingHE,
      'ap': this.ap,
      'sigma': this.sigma,
      'consumables': this.consumable,
      'permoflages': this.permoflage,
    };
  }

  @override
  bool isValid() => consumable.isNotEmpty;

  @override
  output() => jsonEncode(toJson());
}

/// This is the `AP` class
class AP {
  double weight;
  double diameter;
  double drag;
  double velocity;
  double krupp;

  AP.fromJson(Map<String, dynamic> json) {
    this.weight = json['weight'];
    this.diameter = json['diameter'];
    this.drag = json['drag'];
    this.velocity = json['velocity'];
    this.krupp = json['krupp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': this.weight,
      'diameter': this.diameter,
      'drag': this.drag,
      'velocity': this.velocity,
      'krupp': this.krupp,
    };
  }
}

/// This is the `Consumable` class
class Consumable {
  String name;
  String type;

  Consumable.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'type': this.type,
    };
  }
}
