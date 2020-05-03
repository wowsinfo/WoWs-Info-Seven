import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';

/// This is the `WikiCommanderSkill` class
class WikiCommanderSkill extends Cacheable {
  Map<String, Skill> skill;

  WikiCommanderSkill.fromJson(Map<String, dynamic> json) {
    this.skill = json.map((a, b) => MapEntry(a, Skill.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.skill.cast<String, dynamic>();
  
  @override
  void save() => cached.saveCommanderSkill(this);
}

/// This is the `Skill` class
class Skill extends WikiItem {
  int typeId;
  String typeName;
  List<Perk> perk;
  int tier;

  Skill.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.typeId = json['type_id'];
    this.typeName = json['type_name'];
    this.perk = (json['perks'] as List).map((e) => Perk.fromJson(e)).toList(growable: false);
    this.tier = json['tier'];
    this.image = json['icon'];
    
    // Add description here
    this.description = typeName + '\n' + perk.map((e) => e.description).join('\n');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'type_id': this.typeId,
      'type_name': this.typeName,
      'perks': this.perk,
      'tier': this.tier,
      'icon': this.image,
    };
  }
}

/// This is the `Perk` class
class Perk {
  int perkId;
  String description;

  Perk.fromJson(Map<String, dynamic> json) {
    this.perkId = json['perk_id'];
    this.description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'perk_id': this.perkId,
      'description': this.description,
    };
  }
}
