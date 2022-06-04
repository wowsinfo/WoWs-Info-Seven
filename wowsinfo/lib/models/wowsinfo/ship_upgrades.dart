import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class ShipUpgrades {
  final _logger = Logger('ShipUpgrades');

  final Ship _ship;
  ShipUpgrades(this._ship);

  void unpackUpgrades() {
    final upgrades = GameRepository.instance.modernizationList;
    final List<Modernization> shipUpgrades = [];
    for (final upgrade in upgrades) {
      if (upgrade.isFor(_ship)) {
        shipUpgrades.add(upgrade);
        _logger.fine('Found upgrade: ${upgrade.name}');
      }
    }
    _logger.fine('Unpacked ${shipUpgrades.length} upgrades for ${_ship.name}');
  }
}
