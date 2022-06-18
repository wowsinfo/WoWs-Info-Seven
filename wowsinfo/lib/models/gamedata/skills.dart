import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/modifier.dart';

@immutable
class CommanderSkill {
  const CommanderSkill({
    required this.logicTrigger,
    required this.canBeLearned,
    required this.isEpic,
    required this.modifiers,
    required this.skillType,
    required this.uiTreatAsTrigger,
    required this.name,
  });

  final LogicTrigger logicTrigger;
  final bool canBeLearned;
  final bool isEpic;
  final Modifiers modifiers;
  final int skillType;
  final bool uiTreatAsTrigger;
  final String name;

  String get descriptions => '$modifiers${logicTrigger.modifiers}';

  factory CommanderSkill.fromJson(Map<String, dynamic> json) => CommanderSkill(
        logicTrigger: LogicTrigger.fromJson(json['LogicTrigger']),
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

  final num burnCount;
  final num changePriorityTargetPenalty;
  final String consumableType;
  final num coolingDelay;
  final List<List<num>> coolingInterpolator;
  final String dividerType;
  final num dividerValue;
  final num duration;
  final num energyCoeff;
  final num floodCount;
  final List<List<num>> heatInterpolator;
  final Modifiers modifiers;
  final String triggerDescIds;
  final String triggerType;

  factory LogicTrigger.fromJson(Map<String, dynamic> json) => LogicTrigger(
        burnCount: json['burnCount'],
        changePriorityTargetPenalty: json['changePriorityTargetPenalty'],
        consumableType: json['consumableType'],
        coolingDelay: json['coolingDelay'],
        coolingInterpolator: List<List<num>>.from(
            json['coolingInterpolator'].map((x) => List<num>.from(x))),
        dividerType: json['dividerType'],
        dividerValue: json['dividerValue'],
        duration: json['duration'],
        energyCoeff: json['energyCoeff'],
        floodCount: json['floodCount'],
        heatInterpolator: List<List<num>>.from(
            json['heatInterpolator'].map((x) => List<num>.from(x))),
        modifiers: Modifiers.fromJson(json['modifiers']),
        triggerDescIds: json['triggerDescIds'],
        triggerType: json['triggerType'],
      );
}
