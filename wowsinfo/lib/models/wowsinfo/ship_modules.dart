import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class ShipModules {
  final _logger = Logger('ShipModules');

  final Ship _ship;
  ShipModules(this._ship);

  final List<ShipModuleHolder<HullInfo>> _hullInfo = [];
  final List<ShipModuleHolder<GunInfo>> _gunInfo = [];
  final List<ShipModuleHolder<GunInfo>> _secondaryInfo = [];
  final List<ShipModuleHolder<TorpedoInfo>> _torpInfo = [];
  final List<ShipModuleHolder<PingerInfo>> _pingerInfo = [];
  final List<ShipModuleHolder<FireControlInfo>> _fireControlInfo = [];
  final List<ShipModuleHolder<EngineInfo>> _engineInfo = [];
  final List<ShipModuleHolder<AirSupportInfo>> _airSupportInfo = [];
  final List<ShipModuleHolder<DepthChargeInfo>> _depthChargeInfo = [];

  // aircrafts
  final List<ShipModuleHolder<Aircraft>> _fighterInfo = [];
  final List<ShipModuleHolder<Aircraft>> _skipBomberInfo = [];
  final List<ShipModuleHolder<Aircraft>> _torpedoBomberInfo = [];
  final List<ShipModuleHolder<Aircraft>> _diveBomberInfo = [];

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

  ShipModuleHolder<T>? _valueAt<T>(List<ShipModuleHolder<T>> list, int index) {
    if (index < 0 || index >= list.length) return null;
    return list[index];
  }

  late final bool canChangeModules = _hullInfo.length > 1 ||
      _gunInfo.length > 1 ||
      _secondaryInfo.length > 1 ||
      _torpInfo.length > 1 ||
      _pingerInfo.length > 1 ||
      _fireControlInfo.length > 1 ||
      _engineInfo.length > 1 ||
      _airSupportInfo.length > 1 ||
      _depthChargeInfo.length > 1 ||
      _fighterInfo.length > 1 ||
      _skipBomberInfo.length > 1 ||
      _torpedoBomberInfo.length > 1 ||
      _diveBomberInfo.length > 1;

  late final List<List<ShipModuleInfo>> moduleList = _makeModuleList();

  /// Get all modules with at least 2 items in it.
  List<List<ShipModuleInfo>> _makeModuleList() {
    final List<List<ShipModuleInfo>> list = [];
    if (_hullInfo.length > 1) list.add(_hullInfo.map((e) => e.module).toList());
    if (_gunInfo.length > 1) list.add(_gunInfo.map((e) => e.module).toList());
    if (_torpInfo.length > 1) list.add(_torpInfo.map((e) => e.module).toList());
    if (_secondaryInfo.length > 1) {
      list.add(_secondaryInfo.map((e) => e.module).toList());
    }
    if (_engineInfo.length > 1) {
      list.add(_engineInfo.map((e) => e.module).toList());
    }
    if (_pingerInfo.length > 1) {
      list.add(_pingerInfo.map((e) => e.module).toList());
    }
    if (_fireControlInfo.length > 1) {
      list.add(_fireControlInfo.map((e) => e.module).toList());
    }
    if (_airSupportInfo.length > 1) {
      list.add(_airSupportInfo.map((e) => e.module).toList());
    }
    if (_depthChargeInfo.length > 1) {
      list.add(_depthChargeInfo.map((e) => e.module).toList());
    }
    if (_fighterInfo.length > 1) {
      list.add(_fighterInfo.map((e) => e.module).toList());
    }
    if (_skipBomberInfo.length > 1) {
      list.add(_skipBomberInfo.map((e) => e.module).toList());
    }
    if (_torpedoBomberInfo.length > 1) {
      list.add(_torpedoBomberInfo.map((e) => e.module).toList());
    }
    if (_diveBomberInfo.length > 1) {
      list.add(_diveBomberInfo.map((e) => e.module).toList());
    }
    return list;
  }

  HullInfo? get hullInfo => _valueAt(_hullInfo, _selectedHull)?.data;
  GunInfo? get gunInfo => _valueAt(_gunInfo, _selectedGun)?.data;
  GunInfo? get secondaryInfo =>
      _valueAt(_secondaryInfo, _selectedSecondary)?.data;
  TorpedoInfo? get torpedoInfo => _valueAt(_torpInfo, _selectedTorp)?.data;
  EngineInfo? get engineInfo => _valueAt(_engineInfo, _selectedEngine)?.data;
  PingerInfo? get pingerInfo => _valueAt(_pingerInfo, _selectedPinger)?.data;
  FireControlInfo? get fireControlInfo =>
      _valueAt(_fireControlInfo, _selectedFireControl)?.data;
  AirSupportInfo? get airSupportInfo =>
      _valueAt(_airSupportInfo, _selectedAirSupport)?.data;
  DepthChargeInfo? get depthChargeInfo =>
      _valueAt(_depthChargeInfo, _selectedDepthCharge)?.data;

  Aircraft? get fighterInfo => _valueAt(_fighterInfo, _selectedFighter)?.data;
  Aircraft? get skipBomberInfo =>
      _valueAt(_skipBomberInfo, _selectedSkipBomber)?.data;
  Aircraft? get torpedoBomberInfo =>
      _valueAt(_torpedoBomberInfo, _selectedTorpedoBomber)?.data;
  Aircraft? get diveBomberInfo =>
      _valueAt(_diveBomberInfo, _selectedDiveBomber)?.data;

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
              final holder = ShipModuleHolder(module, HullInfo.fromJson(info));
              _hullInfo.add(holder);
            }
            for (final key in components['depthCharges'] ?? []) {
              final info = shipModules[key];
              final holder =
                  ShipModuleHolder(module, DepthChargeInfo.fromJson(info));
              _depthChargeInfo.add(holder);
            }
            for (final key in components['airSupport'] ?? []) {
              final info = shipModules[key];
              final holder =
                  ShipModuleHolder(module, AirSupportInfo.fromJson(info));
              _airSupportInfo.add(holder);
            }
            for (final key in components['atba'] ?? []) {
              final info = shipModules[key];
              final holder = ShipModuleHolder(module, GunInfo.fromJson(info));
              _secondaryInfo.add(holder);
            }
            for (final key in components['pinger'] ?? []) {
              final info = shipModules[key];
              final holder =
                  ShipModuleHolder(module, PingerInfo.fromJson(info));
              _pingerInfo.add(holder);
            }
            break;
          case '_Artillery':
            for (final key in components['artillery'] ?? []) {
              final info = shipModules[key];
              final holder = ShipModuleHolder(module, GunInfo.fromJson(info));
              _gunInfo.add(holder);
            }
            break;
          case '_Torpedoes':
            for (final key in components['torpedoes'] ?? []) {
              final info = shipModules[key];
              final holder =
                  ShipModuleHolder(module, TorpedoInfo.fromJson(info));
              _torpInfo.add(holder);
            }
            break;
          case '_Suo':
            for (final key in components['fireControl'] ?? []) {
              final info = shipModules[key];
              final holder =
                  ShipModuleHolder(module, FireControlInfo.fromJson(info));
              _fireControlInfo.add(holder);
            }
            break;
          case '_Engine':
            for (final key in components['engine'] ?? []) {
              final info = shipModules[key];
              final holder =
                  ShipModuleHolder(module, EngineInfo.fromJson(info));
              _engineInfo.add(holder);
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

                final holder = ShipModuleHolder<Aircraft>(module, info);
                switch (moduleType) {
                  case '_SkipBomber':
                    _skipBomberInfo.add(holder);
                    break;
                  case '_TorpedoBomber':
                    _torpedoBomberInfo.add(holder);
                    break;
                  case '_DiveBomber':
                    _diveBomberInfo.add(holder);
                    break;
                  case '_Fighter':
                    _fighterInfo.add(holder);
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

/// A data holder with a [ShipModuleInfo] and the data [T].
class ShipModuleHolder<T> {
  final ShipModuleInfo module;
  final T data;

  ShipModuleHolder(this.module, this.data);
}
