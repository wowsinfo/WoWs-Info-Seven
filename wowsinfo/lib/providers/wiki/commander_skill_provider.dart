import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/commander_skills.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

const _maxPoints = 21;

class CommanderSkillProvider with ChangeNotifier {
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

  final airCarrier = Localisation.instance.airCarrier;
  final destroyer = Localisation.instance.destroyer;
  final cruiser = Localisation.instance.cruiser;
  final battleship = Localisation.instance.battleship;
  final submarine = Localisation.instance.submarine;

  late String _selectedTab = destroyer;
  String get selectedTab => _selectedTab;
  void select(String tab) {
    _logger.fine('Selected tab: $tab');
    _selectedTab = tab;
    notifyListeners();
  }

  int _selectedPoints = 0;
  String get selectedPoints => _selectedPoints.toString();
  String get totalPoints => _maxPoints.toString();
}
