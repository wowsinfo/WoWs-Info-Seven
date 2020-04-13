import '../APIModel.dart';

/// This is the `WikiAchievement` class
class WikiAchievement extends APIModel {
  Map<String, Achievement> achievement;

  WikiAchievement.fromJson(Map<String, dynamic> json) {
    this.achievement = json.map((a, b) => MapEntry(a, Achievement.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.achievement.cast<String, dynamic>();
}

/// This is the `Achievement` class
class Achievement {
  String description;
  String image;
  String achievementId;
  String imageInactive;
  int hidden;
  String name;

  Achievement.fromJson(Map<String, dynamic> json) {
    this.description = json['description'];
    this.image = json['image'];
    this.achievementId = json['achievement_id'];
    this.imageInactive = json['image_inactive'];
    this.hidden = json['hidden'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': this.description,
      'image': this.image,
      'achievement_id': this.achievementId,
      'image_inactive': this.imageInactive,
      'hidden': this.hidden,
      'name': this.name,
    };
  }
}
