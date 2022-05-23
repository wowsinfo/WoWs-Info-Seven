import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

typedef ShipModuleMap = Map<String, List<ShipModuleInfo>>;

class ShipModules {
  final _logger = Logger('ShipModules');

  final Ship _ship;
  ShipModules(this._ship);

  int _gunCount = 0;
  int _torpCount = 0;
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

  /// Decided in [unpackModules]
  late final bool canChangeModules = _gunCount > 1 ||
      _torpCount > 1 ||
      _hullInfo.length > 1 ||
      _fireControlInfo.length > 1 ||
      _engineInfo.length > 1 ||
      _skipBomberInfo.length > 1 ||
      _torpedoBomberInfo.length > 1 ||
      _diveBomberInfo.length > 1 ||
      _fighterInfo.length > 1;

  late final ShipModuleMap moduleList = _makeModuleList();

  /// Get all modules with at least 2 items in it.
  ShipModuleMap _makeModuleList() {
    final ShipModuleMap moduleMap = {};
    if (_hullInfo.length > 1) {
      moduleMap['aaa'] = _hullInfo.map((e) => e.module!).toList();
    }
    if (_gunCount > 1) {
      moduleMap['bbb'] = _gunInfo.map((e) => e.module!).toList();
    }
    if (_torpCount > 1) {
      moduleMap['ccc'] = _torpInfo.map((e) => e.module!).toList();
    }
    if (_fireControlInfo.length > 1) {
      moduleMap['ddd'] = _fireControlInfo.map((e) => e.module!).toList();
    }
    if (_engineInfo.length > 1) {
      moduleMap['eee'] = _engineInfo.map((e) => e.module!).toList();
    }
    if (_fighterInfo.length > 1) {
      moduleMap['fff'] = _fighterInfo.map((e) => e.module!).toList();
    }
    if (_skipBomberInfo.length > 1) {
      moduleMap['ggg'] = _skipBomberInfo.map((e) => e.module!).toList();
    }
    if (_torpedoBomberInfo.length > 1) {
      moduleMap['hhh'] = _torpedoBomberInfo.map((e) => e.module!).toList();
    }
    if (_diveBomberInfo.length > 1) {
      moduleMap['iii'] = _diveBomberInfo.map((e) => e.module!).toList();
    }
    return moduleMap;
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

  void updateEngine(int index) {
    _selectedEngine = index;
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

        // add a temp helper function
        void addModule<T>(
          String key,
          T Function(Map<String, dynamic>) creator,
          void Function(ShipModuleHolder<T>) add,
        ) {
          final moduleList = components[key];
          if (moduleList == null || moduleList.isEmpty) return;
          final info = shipModules[moduleList.first];
          final holder = ShipModuleHolder(module, creator(info));
          add(holder);
        }

        switch (moduleType) {
          case '_Hull':
            addModule('hull', HullInfo.fromJson, _hullInfo.add);
            addModule(
                'depthCharges', DepthChargeInfo.fromJson, _depthChargeInfo.add);
            addModule(
                'airSupport', AirSupportInfo.fromJson, _airSupportInfo.add);
            addModule('atba', GunInfo.fromJson, _secondaryInfo.add);
            addModule('pinger', PingerInfo.fromJson, _pingerInfo.add);

            // There can be multiple of guns & torps. However, they can be the
            // same although having different names. It is only accurate from
            // the hull itself.
            _gunCount = components['artillery']?.length ?? 0;
            _torpCount = components['torpedoes']?.length ?? 0;
            break;
          case '_Artillery':
            addModule('artillery', GunInfo.fromJson, _secondaryInfo.add);
            break;
          case '_Torpedoes':
            addModule('torpedoes', TorpedoInfo.fromJson, _torpInfo.add);
            break;
          case '_Suo':
            addModule(
                'fireControl', FireControlInfo.fromJson, _fireControlInfo.add);
            break;
          case '_Engine':
            final moduleList = components['engine'];
            if (moduleList == null || moduleList.isEmpty) return;
            final info = shipModules[moduleList.first];
            final holder = ShipModuleHolder(module, EngineInfo.fromJson(info));
            _engineInfo.add(holder);
            break;
          case '_SkipBomber':
          case '_TorpedoBomber':
          case '_DiveBomber':
          case '_Fighter':
            // add all aircrafts' information
            final plane = components.values.first.first;
            // NOTE: we need the first one only, some ships have broken
            // entries like Midway. TODO: we should remove additional ones
            final key = List<String>.from(shipModules[plane]).first;
            final info = GameRepository.instance.aircraftOf(key);
            if (info == null) {
              _logger.warning('Cannot find aircraft info of $key');
              continue;
            } else {
              _logger.fine('Found aircraft ($moduleType) info of $key');
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
  final ShipModuleInfo? module;
  final T data;

  ShipModuleHolder(this.module, this.data);
}
