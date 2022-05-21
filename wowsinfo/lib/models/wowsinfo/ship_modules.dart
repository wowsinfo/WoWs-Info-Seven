import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class ShipModules {
  final _logger = Logger('ShipModules');

  final Ship _ship;
  ShipModules(this._ship);

  final List<HullInfo> _hullInfo = [];
  final List<GunInfo> _gunInfo = [];
  final List<GunInfo> _secondaryInfo = [];
  final List<TorpedoInfo> _torpInfo = [];
  final List<PingerInfo> _pingerInfo = [];
  final List<FireControlInfo> _fireControlInfo = [];
  final List<AirSupportInfo> _airSupportInfo = [];
  final List<DepthChargeInfo> _depthChargeInfo = [];

  // aircrafts
  final List<Aircraft> _fighterInfo = [];
  final List<Aircraft> _skipBomberInfo = [];
  final List<Aircraft> _torpedoBomberInfo = [];
  final List<Aircraft> _diveBomberInfo = [];

  // selected modules by default 0
  int _selectedHull = 0;
  int _selectedGun = 0;
  int _selectedSecondary = 0;
  int _selectedTorp = 0;
  int _selectedPinger = 0;
  int _selectedFireControl = 0;
  int _selectedAirSupport = 0;
  int _selectedDepthCharge = 0;

  int _selectedFighter = 0;
  int _selectedSkipBomber = 0;
  int _selectedTorpedoBomber = 0;
  int _selectedDiveBomber = 0;

  T? _valueAt<T>(List<T> list, int index) {
    if (index < 0 || index >= list.length) return null;
    return list[index];
  }

  late final bool canChangeModules = _hullInfo.length > 1 ||
      _gunInfo.length > 1 ||
      _secondaryInfo.length > 1 ||
      _torpInfo.length > 1 ||
      _pingerInfo.length > 1 ||
      _fireControlInfo.length > 1 ||
      _airSupportInfo.length > 1 ||
      _depthChargeInfo.length > 1 ||
      _fighterInfo.length > 1 ||
      _skipBomberInfo.length > 1 ||
      _torpedoBomberInfo.length > 1 ||
      _diveBomberInfo.length > 1;

  HullInfo? get hullInfo => _valueAt(_hullInfo, _selectedHull);
  GunInfo? get gunInfo => _valueAt(_gunInfo, _selectedGun);
  GunInfo? get secondaryInfo => _valueAt(_secondaryInfo, _selectedSecondary);
  TorpedoInfo? get torpedoInfo => _valueAt(_torpInfo, _selectedTorp);
  PingerInfo? get pingerInfo => _valueAt(_pingerInfo, _selectedPinger);
  FireControlInfo? get fireControlInfo =>
      _valueAt(_fireControlInfo, _selectedFireControl);
  AirSupportInfo? get airSupportInfo =>
      _valueAt(_airSupportInfo, _selectedAirSupport);
  DepthChargeInfo? get depthChargeInfo =>
      _valueAt(_depthChargeInfo, _selectedDepthCharge);

  Aircraft? get fighterInfo => _valueAt(_fighterInfo, _selectedFighter);
  Aircraft? get skipBomberInfo =>
      _valueAt(_skipBomberInfo, _selectedSkipBomber);
  Aircraft? get torpedoBomberInfo =>
      _valueAt(_torpedoBomberInfo, _selectedTorpedoBomber);
  Aircraft? get diveBomberInfo =>
      _valueAt(_diveBomberInfo, _selectedDiveBomber);

  void updateHull(int index) {
    _selectedHull = index;
  }

  void updateGun(int index) {
    _selectedGun = index;
  }

  void updateSecondary(int index) {
    _selectedSecondary = index;
  }

  void updateTorpedo(int index) {
    _selectedTorp = index;
  }

  void updatePinger(int index) {
    _selectedPinger = index;
  }

  void updateFireControl(int index) {
    _selectedFireControl = index;
  }

  void updateAirSupport(int index) {
    _selectedAirSupport = index;
  }

  void updateDepthCharge(int index) {
    _selectedDepthCharge = index;
  }

  void updateFighter(int index) {
    _selectedFighter = index;
  }

  void updateSkipBomber(int index) {
    _selectedSkipBomber = index;
  }

  void updateTorpedoBomber(int index) {
    _selectedTorpedoBomber = index;
  }

  void updateDiveBomber(int index) {
    _selectedDiveBomber = index;
  }

  void unpackModules() {
    final shipModules = _ship.components;
    for (final module in _ship.modules.entries) {
      final moduleType = module.key;
      final modules = module.value;
      for (final module in modules) {
        final components = module.components;
        switch (moduleType) {
          case '_Hull':
            for (final key in components['hull'] ?? []) {
              final info = shipModules[key];
              _hullInfo.add(HullInfo.fromJson(info));
            }
            for (final key in components['depthCharges'] ?? []) {
              // TODO: same as below, should be removed
              final info = shipModules[key]['depthCharge'];
              _depthChargeInfo.add(DepthChargeInfo.fromJson(info));
            }
            for (final key in components['airSupport'] ?? []) {
              // TODO: we should remove this in the game
              final info = shipModules[key]['airSupport'];
              _airSupportInfo.add(AirSupportInfo.fromJson(info));
            }
            for (final key in components['atba'] ?? []) {
              final info = shipModules[key];
              _secondaryInfo.add(GunInfo.fromJson(info));
            }
            for (final key in components['pinger'] ?? []) {
              final info = shipModules[key];
              _pingerInfo.add(PingerInfo.fromJson(info));
            }

            break;
          case '_Artillery':
            for (final key in components['artillery'] ?? []) {
              final info = shipModules[key];
              _gunInfo.add(GunInfo.fromJson(info));
            }
            break;
          case '_Torpedoes':
            for (final key in components['torpedoes'] ?? []) {
              final info = shipModules[key];
              _torpInfo.add(TorpedoInfo.fromJson(info));
            }
            break;
          case '_Suo':
            for (final key in components['fireControl'] ?? []) {
              final info = shipModules[key];
              _fireControlInfo.add(FireControlInfo.fromJson(info));
            }
            break;
          case '_SkipBomber':
          case '_TorpedoBomber':
          case '_DiveBomber':
          case '_Fighter':
            // add all aircrafts' information
            for (final plane in components.values.first) {
              for (final key in List<String>.from(shipModules[plane])) {
                final info = GameRepository.instance.aircraftOf(key);
                if (info == null) {
                  _logger.warning('Cannot find aircraft info of $key');
                  continue;
                }

                switch (moduleType) {
                  case '_SkipBomber':
                    _skipBomberInfo.add(info);
                    break;
                  case '_TorpedoBomber':
                    _torpedoBomberInfo.add(info);
                    break;
                  case '_DiveBomber':
                    _diveBomberInfo.add(info);
                    break;
                  case '_Fighter':
                    _fighterInfo.add(info);
                    break;
                }
              }
            }
            break;
          case '_Sonar':
          case '_Abilities':
          case '_SecondaryWeapons':
          case '_PrimaryWeapons':
          case '_FlightControl':
          case '_Engine':
            // ignore these for now
            break;
          default:
            // we don't need to use everything but we should know about it
            throw UnimplementedError('Unknown module - $moduleType');
        }
      }
    }

    _logger.fine('Unpacked modules of ${_ship.index}');
  }
}
