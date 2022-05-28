import 'package:logging/logging.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';

class ShipModuleSelection {
  final _logger = Logger('ShipModuleSelection');

  // selected modules by default 0
  int _selectedHull = 0;
  int _selectedGun = 0;
  int _selectedSecondary = 0;
  int _selectedTorp = 0;
  int _selectedPinger = 0;
  int _selectedFireControl = 0;
  int _selectedEngine = 0;
  int _selectedAirSupport = 0;
  int _selectedDepthCharge = 0;

  int _selectedFighter = 0;
  int _selectedSkipBomber = 0;
  int _selectedTorpedoBomber = 0;
  int _selectedDiveBomber = 0;

  int get hullIndex => _selectedHull;
  int get gunIndex => _selectedGun;
  int get secondaryIndex => _selectedSecondary;
  int get torpIndex => _selectedTorp;
  int get pingerIndex => _selectedPinger;
  int get fireControlIndex => _selectedFireControl;
  int get engineIndex => _selectedEngine;
  int get airSupportIndex => _selectedAirSupport;
  int get depthChargeIndex => _selectedDepthCharge;

  int get fighterIndex => _selectedFighter;
  int get skipBomberIndex => _selectedSkipBomber;
  int get torpedoBomberIndex => _selectedTorpedoBomber;
  int get diveBomberIndex => _selectedDiveBomber;

  /// Check if the module of [type] at [index] is selected
  bool isSelected(ShipModuleType type, int index) {
    switch (type) {
      case ShipModuleType.hull:
        return _selectedHull == index;
      case ShipModuleType.gun:
        return _selectedGun == index;
      case ShipModuleType.secondary:
        return _selectedSecondary == index;
      case ShipModuleType.torpedo:
        return _selectedTorp == index;
      case ShipModuleType.pinger:
        return _selectedPinger == index;
      case ShipModuleType.fireControl:
        return _selectedFireControl == index;
      case ShipModuleType.engine:
        return _selectedEngine == index;
      case ShipModuleType.airSupport:
        return _selectedAirSupport == index;
      case ShipModuleType.depthCharge:
        return _selectedDepthCharge == index;

      case ShipModuleType.fighter:
        return _selectedFighter == index;
      case ShipModuleType.skipBomber:
        return _selectedSkipBomber == index;
      case ShipModuleType.torpedoBomber:
        return _selectedTorpedoBomber == index;
      case ShipModuleType.diveBomber:
        return _selectedDiveBomber == index;
      case ShipModuleType.unknown:
        _logger.severe('Unknown module type: $type');
    }
    return false;
  }

  /// Update selected module [index] based on [type].
  /// Same selection will be ignored.
  void updateSelected(ShipModuleType type, int index) {
    switch (type) {
      case ShipModuleType.hull:
        if (_selectedHull == index) return;
        _selectedHull = index;
        _logger.fine('updateHull: $index');
        break;
      case ShipModuleType.gun:
        if (_selectedGun == index) return;
        _selectedGun = index;
        _logger.fine('updateGun: $index');
        break;
      case ShipModuleType.secondary:
        if (_selectedSecondary == index) return;
        _selectedSecondary = index;
        _logger.fine('updateSecondary: $index');
        break;
      case ShipModuleType.torpedo:
        if (_selectedTorp == index) return;
        _selectedTorp = index;
        _logger.fine('updateTorp: $index');
        break;
      case ShipModuleType.pinger:
        if (_selectedPinger == index) return;
        _selectedPinger = index;
        _logger.fine('updatePinger: $index');
        break;
      case ShipModuleType.fireControl:
        if (_selectedFireControl == index) return;
        _selectedFireControl = index;
        _logger.fine('updateFireControl: $index');
        break;
      case ShipModuleType.engine:
        if (_selectedEngine == index) return;
        _selectedEngine = index;
        _logger.fine('updateEngine: $index');
        break;
      case ShipModuleType.airSupport:
        if (_selectedAirSupport == index) return;
        _selectedAirSupport = index;
        _logger.fine('updateAirSupport: $index');
        break;
      case ShipModuleType.depthCharge:
        if (_selectedDepthCharge == index) return;
        _selectedDepthCharge = index;
        _logger.fine('updateDepthCharge: $index');
        break;
      case ShipModuleType.fighter:
        if (_selectedFighter == index) return;
        _selectedFighter = index;
        _logger.fine('updateFighter: $index');
        break;
      case ShipModuleType.skipBomber:
        if (_selectedSkipBomber == index) return;
        _selectedSkipBomber = index;
        _logger.fine('updateSkipBomber: $index');
        break;
      case ShipModuleType.torpedoBomber:
        if (_selectedTorpedoBomber == index) return;
        _selectedTorpedoBomber = index;
        _logger.fine('updateTorpedoBomber: $index');
        break;
      case ShipModuleType.diveBomber:
        if (_selectedDiveBomber == index) return;
        _selectedDiveBomber = index;
        _logger.fine('updateDiveBomber: $index');
        break;
      case ShipModuleType.unknown:
        _logger.severe('Unknown module type: $type');
    }
  }
}
