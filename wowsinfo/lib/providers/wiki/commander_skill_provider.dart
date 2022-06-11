import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/commander_skills.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class CommanderSkillProvider {
  final _logger = Logger('CommanderSkillProvider');

  final BuildContext _context;

  /// This can be null to load all entries
  final CommanderSkillType? type;
  CommanderSkillProvider(this._context, {this.type});

  bool get shouldLoadAllTypes => type == null;

  /// Check [shouldLoadAllTypes] before using this
  List<List<ShipSkill>> get skills => _skills!;
  late final List<List<ShipSkill>>? _skills = _getSkillsFrom(type);
  List<List<ShipSkill>>? _getSkillsFrom(CommanderSkillType? type) {
    if (type == null) return null;
    return GameRepository.instance.commandSkillsOf(type);
  }

  final allSkills = GameRepository.instance.commanderSkills;
}
