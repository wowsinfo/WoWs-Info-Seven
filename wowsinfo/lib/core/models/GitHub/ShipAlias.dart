import 'package:wowsinfo/core/models/Cacheable.dart';

/// This is the `ShipAlias` class
class ShipAlias extends Cacheable {
  Map<String, Alias> alias;

  ShipAlias.fromJson(Map<String, dynamic> json) {
    this.alias = json.map((key, value) => MapEntry(key, Alias.fromJson(value)));
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': this.alias.cast<String, dynamic>(),
    };
  }

  @override
  void save() => cached.saveAlias(this);
}

/// This is the `Alias` class
class Alias {
  String name;

  Alias.fromJson(Map<String, dynamic> json) {
    this.name = json['alias'];
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': this.name,
    };
  }
}
