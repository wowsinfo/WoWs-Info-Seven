// To parse this JSON data, do
//
//     final skills = skillsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Skills skillsFromJson(String str) => Skills.fromJson(json.decode(str));

String skillsToJson(Skills data) => json.encode(data.toJson());

class Skills {
  Skills({
    required this.skills,
  });

  final Map<String, CommanderSkillInfo> skills;

  factory Skills.fromJson(Map<String, dynamic> json) => Skills();
}

class CommanderSkillInfo {
  CommanderSkillInfo({
    // required this.logicTrigger,
    required this.canBeLearned,
    required this.isEpic,
    required this.modifiers,
    required this.skillType,
    required this.tier,
    required this.uiTreatAsTrigger,
    required this.name,
  });

  // final LogicTrigger logicTrigger;
  final bool canBeLearned;
  final bool isEpic;
  final AaDamageConstantBubblesModifiers modifiers;
  final int skillType;
  final Tier tier;
  final bool uiTreatAsTrigger;
  final String name;

  factory CommanderSkillInfo.fromJson(Map<String, dynamic> json) =>
      CommanderSkillInfo(
        // logicTrigger: LogicTrigger.fromJson(json['LogicTrigger']),
        canBeLearned: json['canBeLearned'],
        isEpic: json['isEpic'],
        modifiers: AaDamageConstantBubblesModifiers.fromJson(json['modifiers']),
        skillType: json['skillType'],
        tier: Tier.fromJson(json['tier']),
        uiTreatAsTrigger: json['uiTreatAsTrigger'],
        name: json['name'],
      );
}

class LogicTrigger {
  LogicTrigger({
    required this.burnCount,
    required this.changePriorityTargetPenalty,
    required this.consumableType,
    required this.coolingDelay,
    required this.coolingInterpolator,
    required this.dividerType,
    required this.dividerValue,
    required this.duration,
    required this.energyCoeff,
    required this.floodCount,
    required this.heatInterpolator,
    required this.modifiers,
    required this.triggerDescIds,
    required this.triggerType,
  });

  final int burnCount;
  final int changePriorityTargetPenalty;
  final String consumableType;
  final int coolingDelay;
  final List<dynamic> coolingInterpolator;
  final String dividerType;
  final int dividerValue;
  final int duration;
  final int energyCoeff;
  final int floodCount;
  final List<dynamic> heatInterpolator;
  final LogicTriggerModifiers modifiers;
  final String triggerDescIds;
  final String triggerType;

  factory LogicTrigger.fromJson(Map<String, dynamic> json) => LogicTrigger(
        burnCount: json['burnCount'],
        changePriorityTargetPenalty: json['changePriorityTargetPenalty'],
        consumableType: json['consumableType'],
        coolingDelay: json['coolingDelay'],
        coolingInterpolator:
            List<dynamic>.from(json['coolingInterpolator'].map((x) => x)),
        dividerType: json['dividerType'],
        dividerValue: json['dividerValue'],
        duration: json['duration'],
        energyCoeff: json['energyCoeff'],
        floodCount: json['floodCount'],
        heatInterpolator:
            List<dynamic>.from(json['heatInterpolator'].map((x) => x)),
        modifiers: LogicTriggerModifiers.fromJson(json['modifiers']),
        triggerDescIds: json['triggerDescIds'],
        triggerType: json['triggerType'],
      );
}

class LogicTriggerModifiers {
  LogicTriggerModifiers();

  factory LogicTriggerModifiers.fromJson(Map<String, dynamic> json) =>
      LogicTriggerModifiers();

  Map<String, dynamic> toJson() => {};
}

class AaDamageConstantBubblesModifiers {
  AaDamageConstantBubblesModifiers({
    required this.aaAuraDamage,
    required this.aaBubbleDamage,
    required this.dcAlphaDamageMultiplier,
  });

  final Tier aaAuraDamage;
  final Tier aaBubbleDamage;
  final Tier dcAlphaDamageMultiplier;

  factory AaDamageConstantBubblesModifiers.fromJson(
          Map<String, dynamic> json) =>
      AaDamageConstantBubblesModifiers(
        aaAuraDamage: Tier.fromJson(json['AAAuraDamage']),
        aaBubbleDamage: Tier.fromJson(json['AABubbleDamage']),
        dcAlphaDamageMultiplier: Tier.fromJson(json['dcAlphaDamageMultiplier']),
      );

  Map<String, dynamic> toJson() => {
        'AAAuraDamage': aaAuraDamage.toJson(),
        'AABubbleDamage': aaBubbleDamage.toJson(),
        'dcAlphaDamageMultiplier': dcAlphaDamageMultiplier.toJson(),
      };
}

class Tier {
  Tier({
    required this.airCarrier,
    required this.auxiliary,
    required this.battleship,
    required this.cruiser,
    required this.destroyer,
    required this.submarine,
  });

  final double airCarrier;
  final int auxiliary;
  final double battleship;
  final double cruiser;
  final int destroyer;
  final int submarine;

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        airCarrier: json['AirCarrier'].toDouble(),
        auxiliary: json['Auxiliary'],
        battleship: json['Battleship'].toDouble(),
        cruiser: json['Cruiser'].toDouble(),
        destroyer: json['Destroyer'],
        submarine: json['Submarine'],
      );

  Map<String, dynamic> toJson() => {
        'AirCarrier': airCarrier,
        'Auxiliary': auxiliary,
        'Battleship': battleship,
        'Cruiser': cruiser,
        'Destroyer': destroyer,
        'Submarine': submarine,
      };
}
