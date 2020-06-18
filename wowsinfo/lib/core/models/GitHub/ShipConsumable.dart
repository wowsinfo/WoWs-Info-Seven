import 'package:wowsinfo/core/models/Cacheable.dart';

/// This is the `ShipConsumable` class
class ShipConsumable extends Cacheable {
  Map<String, BasicConsumable> profiles;
  bool canBuy;
  int costCR;
  bool freeOfCharge;
  int id;
  String index;
  String name;

  ShipConsumable.fromJson(Map<String, dynamic> json): super(json) {
    json.forEach((key, value) {
      if (value is Map && value.keys.length > 0) {
        this.profiles[key] = BasicConsumable.fromJson(value);
      }
    });
    this.canBuy = json['canBuy'];
    this.costCR = json['costCR'];
    this.freeOfCharge = json['freeOfCharge'];
    this.id = json['id'];
    this.index = json['index'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'canBuy': this.canBuy,
      'costCR': this.costCR,
      'freeOfCharge': this.freeOfCharge,
      'id': this.id,
      'index': this.index,
      'name': this.name,
    };
  }
}

/// This is the `BasicConsumable` class
class BasicConsumable {
  String consumableType;
  int _numConsumable;
  /// If `_numConsumable` is not present, that means it can be used infinitely
  bool get isInfinite => _numConsumable == null;
  /// If it is infinite, I will treat it as 99
  int get numConsumable => this._numConsumable ?? 99;
  int reloadTime;
  int workTime;

  BasicConsumable.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this._numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this._numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}
