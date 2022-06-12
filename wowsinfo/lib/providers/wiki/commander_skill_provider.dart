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

  /// Check [shouldLoadAllTypes] before using this
  List<List<ShipSkill>> get skills => _skills;

  /// DESTOYER is the default tab
  late List<List<ShipSkill>> _skills = _getSkillsFrom(
    type ?? CommanderSkillType.destroyer,
  );
  List<List<ShipSkill>> _getSkillsFrom(CommanderSkillType type) {
    return GameRepository.instance.commandSkillsOf(type);
  }

  List<List<ShipSkill>> _getSkillsFromTab(String tab) {
    if (tab == airCarrier) return _getSkillsFrom(CommanderSkillType.airCarrier);
    if (tab == battleship) return _getSkillsFrom(CommanderSkillType.battleship);
    if (tab == cruiser) return _getSkillsFrom(CommanderSkillType.cruiser);
    if (tab == destroyer) return _getSkillsFrom(CommanderSkillType.destroyer);
    if (tab == submarine) return _getSkillsFrom(CommanderSkillType.submarine);
    throw Exception('Unknown tab: $tab');
  }

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

    _selectedPoints = 0;
    _selectedSkills.clear();

    _skills = _getSkillsFromTab(tab);

    notifyListeners();
  }

  int _selectedPoints = 0;
  final List<ShipSkill> _selectedSkills = [];
  bool isSkillSelected(ShipSkill skill) => _selectedSkills.contains(skill);

  void selectSkill(ShipSkill skill) {
    if (_selectedSkills.contains(skill)) {
      _logger.fine('Skill already selected: $skill');
      return;
    }

    final tier = skill.tier;
    if (tier + _selectedPoints > _maxPoints) {
      _logger.fine('More than max points');
      return;
    }

    if (_selectedPoints == 0 && tier > 1) {
      _logger.fine('Tier too high');
      return;
    }

    // tier 1 can always be selected
    if (_selectedPoints > 0 && tier > 1) {
      // only select higher tiers if there is at least one lower tier selected
      if (!_selectedSkills.any((s) => s.tier == tier - 1)) {
        _logger.fine('$skill cannot be selected');
        return;
      }
    }

    _logger.fine('Selected skill: $skill');
    _selectedSkills.add(skill);
    _selectedPoints += skill.tier;
    _logger.fine('Selected points: $_selectedPoints');
    notifyListeners();
  }

  String get selectedPoints => _selectedPoints.toString();
  String get totalPoints => _maxPoints.toString();
  String get pointInfo => '$selectedPoints / $totalPoints';
}
