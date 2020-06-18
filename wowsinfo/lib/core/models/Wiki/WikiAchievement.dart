import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';

/// This is the `WikiAchievement` class
class WikiAchievement extends Cacheable {
  Map<String, Achievement> achievement;

  WikiAchievement.fromJson(Map<String, dynamic> json) : super(json) {
    this.achievement = json.map((a, b) => MapEntry(a, Achievement.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.achievement.cast<String, dynamic>();
}

/// This is the `Achievement` class
class Achievement extends WikiItem {
  String achievementId;
  String imageInactive;
  int hidden;

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

  @override
  Future displayDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          contentPadding: const EdgeInsets.all(2),
          leading: Image.network(image),
          title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(description)
        ),
      ),
    );
    
    // showModalBottomSheet(
    //   context: context, 
    //   builder: (context) => BottomSheet(
    //     onClosing: () => Navigator.pop(context), 
    //     builder: (context) => ListTile(
    //       title: Text(a.name),
    //       subtitle: Text(a.description),
    //     ),
    //   ),
    // );
  }
}
