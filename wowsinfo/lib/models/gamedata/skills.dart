import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/modifier.dart';

@immutable
class CommanderSkill {
  const CommanderSkill({
    // required this.logicTrigger,
    required this.canBeLearned,
    required this.isEpic,
    required this.modifiers,
    required this.skillType,
    required this.uiTreatAsTrigger,
    required this.name,
  });

  // final LogicTrigger logicTrigger;
  final bool canBeLearned;
  final bool isEpic;
  final Modifiers modifiers;
  final int skillType;
  final bool uiTreatAsTrigger;
  final String name;

  String get descriptions => modifiers.toString();

  factory CommanderSkill.fromJson(Map<String, dynamic> json) => CommanderSkill(
        // logicTrigger: LogicTrigger.fromJson(json['LogicTrigger']),
        canBeLearned: json['canBeLearned'],
        isEpic: json['isEpic'],
        modifiers: Modifiers.fromJson(json['modifiers']),
        skillType: json['skillType'],
        uiTreatAsTrigger: json['uiTreatAsTrigger'],
        name: json['name'],
      );
}

@immutable
class LogicTrigger {
  const LogicTrigger({
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
}
