import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class ShipUpgrades {
  final _logger = Logger('ShipUpgrades');

  final Ship _ship;
  ShipUpgrades(this._ship);

  late final List<Modernization> _modernizations;
  late final List<List<Modernization>> _modernizationsBySlot;

  List<Modernization> get modernizations => _modernizations;
  List<List<Modernization>> get modernizationsBySlot => _modernizationsBySlot;

  void unpackUpgrades() {
    final upgrades = GameRepository.instance.modernizationList;
    final List<Modernization> shipUpgrades = [];
    int maxSlot = 0;
    for (final upgrade in upgrades) {
      if (upgrade.isFor(_ship)) {
        shipUpgrades.add(upgrade);
        final slot = upgrade.slot;
        if (slot > maxSlot) maxSlot = slot;
      }
    }
    _logger.fine('Unpacked ${shipUpgrades.length} upgrades for ${_ship.name}');
    assert(shipUpgrades.length < 30, 'Too many upgrades for ${_ship.name}');

    _modernizations = shipUpgrades;
    // slot is from 0
    _modernizationsBySlot = _unpackUpgradesBySlot(max: maxSlot + 1);
  }

  List<List<Modernization>> _unpackUpgradesBySlot({required int max}) {
    final List<List<Modernization>> modernizationsBySlot = [];
    for (final slot in List.generate(max, (s) => s)) {
      _logger.fine('Unpacking slot $slot');
      modernizationsBySlot.add(
        _modernizations.where((upgrade) => upgrade.slot == slot).toList(),
      );
    }
    return modernizationsBySlot;
  }
}
