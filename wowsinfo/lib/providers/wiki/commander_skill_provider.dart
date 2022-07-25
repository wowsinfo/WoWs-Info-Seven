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
  String get selectedDescriptions {
    if (_selectedSkills.isEmpty) return '';
    var additionalDecription = '';
    final skillDescription = _selectedSkills
        .map((skill) {
          final commanderSkill = GameRepository.instance.skillOf(skill.name);
          final passiveSkill = commanderSkill?.skillDescription;
          if (passiveSkill != null) {
            additionalDecription += '\n$passiveSkill';
          }
          if (commanderSkill == null) return null;
          return commanderSkill.modifiers.merge(
            commanderSkill.logicTrigger.modifiers,
          );
        })
        .where((skill) => skill != null)
        .reduce((prev, curr) => prev?.merge(curr))
        .toString()
        .split('\n')
        // there are skills for like battleships, we don't want to show it if it is currently a destroyer
        .where((line) =>
            !line.contains(')') ||
            (line.contains(')') && line.contains(_selectedTab)))
        .join('\n');
    // remove extra spaces
    additionalDecription = additionalDecription.replaceAll('\n\n', '\n').trim();
    return '$additionalDecription\n\n$skillDescription';
  }

  bool isSkillSelected(ShipSkill skill) => _selectedSkills.contains(skill);

  void selectSkill(ShipSkill skill) {
    if (_selectedSkills.contains(skill)) {
      _logger.fine('Skill already selected: $skill');
      // remove from the selection
      _selectedSkills.remove(skill);
      // if this is the only skill selected for the tier, remove eveything below it
      if (_selectedSkills.any((s) => s.tier == skill.tier) == false) {
        _selectedSkills.removeWhere((s) => s.tier > skill.tier);
      }
      // update the points
      _selectedPoints =
          _selectedSkills.fold(0, (prev, curr) => prev + curr.tier);
      notifyListeners();
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

  void reset() {
    _selectedPoints = 0;
    _selectedSkills.clear();
    notifyListeners();
  }

  void onLongPress(ShipSkill skill) {
    // Show the information of the skill
    final commanderSkill = GameRepository.instance.skillOf(skill.name);
    if (commanderSkill == null) {
      assert(false, 'Skill not found: ${skill.name}');
      return;
    }

    final skillName = Localisation.instance.stringOf(commanderSkill.name);
    showDialog(
      context: _context,
      builder: (context) => AlertDialog(
        title: Text(skillName ?? '-'),
        content: Text(commanderSkill.fullDescriptions),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  String get selectedPoints => _selectedPoints.toString();
  String get totalPoints => _maxPoints.toString();
  String get pointInfo => '$selectedPoints / $totalPoints';
}
