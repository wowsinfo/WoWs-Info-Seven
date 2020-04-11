/// This is the `WikiCommanderSkill` class
class WikiCommanderSkill {
  Map<String, Skill> skill;

  WikiCommanderSkill.fromJson(Map<String, dynamic> json) {
    this.skill = json..map((a, b) => MapEntry(a, Skill.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.skill.cast<String, dynamic>();
}

/// This is the `Skill` class
class Skill {
  String name;
  int typeId;
  String typeName;
  List<Perk> perk;
  int tier;
  String icon;

  Skill.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.typeId = json['type_id'];
    this.typeName = json['type_name'];
    this.perk = json['perks'];
    this.tier = json['tier'];
    this.icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'type_id': this.typeId,
      'type_name': this.typeName,
      'perks': this.perk,
      'tier': this.tier,
      'icon': this.icon,
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
