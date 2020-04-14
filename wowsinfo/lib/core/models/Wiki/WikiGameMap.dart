import '../Cacheable.dart';

/// This is the `WikiGameMap` class
class WikiGameMap extends Cacheable {
  Map<String, GameMap> gameMap;

  WikiGameMap.fromJson(Map<String, dynamic> json) {
    this.gameMap = json.map((a, b) => MapEntry(a, GameMap.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.gameMap.cast<String, dynamic>();
}

/// This is the `GameMap` class
class GameMap {
  String description;
  String name;
  String icon;

  GameMap.fromJson(Map<String, dynamic> json) {
    this.description = json['description'];
    this.name = json['name'];
    this.icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': this.description,
      'name': this.name,
      'icon': this.icon,
    };
  }
}
