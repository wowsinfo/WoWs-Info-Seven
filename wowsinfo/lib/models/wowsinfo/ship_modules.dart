import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/repositories/localisation.dart';

typedef ShipModuleMap<T> = Map<ShipModuleType, List<ShipModuleHolder<T>>>;

/// All ship module types.
enum ShipModuleType {
  hull,
  gun,
  secondary,
  torpedo,
  pinger,
  fireControl,
  engine,
  airSupport,
  airDefense,
  depthCharge,
  fighter,
  skipBomber,
  torpedoBomber,
  diveBomber,
  unknown;

  /// The key from the GameData
  String get key {
    switch (this) {
      case ShipModuleType.hull:
        return 'hull';
      case ShipModuleType.gun:
        return 'artillery';
      case ShipModuleType.secondary:
        return 'atba';
      case ShipModuleType.torpedo:
        return 'torpedoes';
      case ShipModuleType.pinger:
        return 'pinger';
      case ShipModuleType.fireControl:
        return 'fireControl';
      case ShipModuleType.engine:
        return 'engine';
      case ShipModuleType.airSupport:
        return 'airSupport';
      case ShipModuleType.airDefense:
        return 'airDefense';
      case ShipModuleType.depthCharge:
        return 'depthCharges';
      case ShipModuleType.fighter:
      case ShipModuleType.skipBomber:
      case ShipModuleType.torpedoBomber:
      case ShipModuleType.diveBomber:
        return ''; // aircrafts are special so they don't need a key
      case ShipModuleType.unknown:
        throw ArgumentError('Unknown module type: $this');
    }
  }

  /// The module type's name.
  String? get name {
    switch (this) {
      case ShipModuleType.hull:
        return Localisation.instance.hull;
      case ShipModuleType.gun:
        return Localisation.instance.artillery;
      case ShipModuleType.secondary:
        return Localisation.instance.secondaries;
      case ShipModuleType.torpedo:
        return Localisation.instance.torpedoes;
      case ShipModuleType.pinger:
        return Localisation.instance.sonar;
      case ShipModuleType.fireControl:
        return Localisation.instance.fireControl;
      case ShipModuleType.engine:
        return Localisation.instance.engine;
      case ShipModuleType.depthCharge:
      case ShipModuleType.airSupport:
        return '';
      case ShipModuleType.airDefense:
        return Localisation.instance.airDefense;
      case ShipModuleType.fighter:
        return Localisation.instance.fighter;
      case ShipModuleType.skipBomber:
        return Localisation.instance.skipBomber;
      case ShipModuleType.torpedoBomber:
        return Localisation.instance.torpedoBomber;
      case ShipModuleType.diveBomber:
        return Localisation.instance.diveBomber;
      case ShipModuleType.unknown:
        throw ArgumentError('Unknown module type: $this');
    }
  }
}

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
  final List<ShipModuleHolder<AirDefense>> _airDefenseInfo = [];
  final List<ShipModuleHolder<DepthChargeInfo>> _depthChargeInfo = [];

  // aircrafts
  final List<ShipModuleHolder<Aircraft>> _fighterInfo = [];
  final List<ShipModuleHolder<Aircraft>> _skipBomberInfo = [];
  final List<ShipModuleHolder<Aircraft>> _torpedoBomberInfo = [];
  final List<ShipModuleHolder<Aircraft>> _diveBomberInfo = [];

  ShipModuleSelection _moduleSelection = ShipModuleSelection();
  ShipModuleSelection get selection => _moduleSelection;
  void updateSelection(ShipModuleSelection selection) {
    _moduleSelection = selection;
  }

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
    if (_hullInfo.length > 1) moduleMap[ShipModuleType.hull] = _hullInfo;
    if (_gunCount > 1) moduleMap[ShipModuleType.gun] = _gunInfo;
    if (_torpCount > 1) moduleMap[ShipModuleType.torpedo] = _torpInfo;
    if (_fireControlInfo.length > 1) {
      moduleMap[ShipModuleType.fireControl] = _fireControlInfo;
    }
    if (_engineInfo.length > 1) moduleMap[ShipModuleType.engine] = _engineInfo;
    if (_fighterInfo.length > 1) {
      moduleMap[ShipModuleType.fighter] = _fighterInfo;
    }
    if (_skipBomberInfo.length > 1) {
      moduleMap[ShipModuleType.skipBomber] = _skipBomberInfo;
    }
    if (_torpedoBomberInfo.length > 1) {
      moduleMap[ShipModuleType.torpedoBomber] = _torpedoBomberInfo;
    }
    if (_diveBomberInfo.length > 1) {
      moduleMap[ShipModuleType.diveBomber] = _diveBomberInfo;
    }
    return moduleMap;
  }

  ShipModuleHolder<HullInfo>? get hullInfo =>
      _valueAt(_hullInfo, _moduleSelection.hullIndex);
  ShipModuleHolder<GunInfo>? get gunInfo =>
      _valueAt(_gunInfo, _moduleSelection.gunIndex);
  ShipModuleHolder<GunInfo>? get secondaryInfo =>
      _valueAt(_secondaryInfo, _moduleSelection.secondaryIndex);
  ShipModuleHolder<TorpedoInfo>? get torpedoInfo =>
      _valueAt(_torpInfo, _moduleSelection.torpIndex);
  ShipModuleHolder<EngineInfo>? get engineInfo =>
      _valueAt(_engineInfo, _moduleSelection.engineIndex);
  ShipModuleHolder<PingerInfo>? get pingerInfo =>
      _valueAt(_pingerInfo, _moduleSelection.pingerIndex);
  ShipModuleHolder<FireControlInfo>? get fireControlInfo =>
      _valueAt(_fireControlInfo, _moduleSelection.fireControlIndex);
  ShipModuleHolder<AirSupportInfo>? get airSupportInfo =>
      _valueAt(_airSupportInfo, _moduleSelection.airSupportIndex);
  ShipModuleHolder<AirDefense>? get airDefenseInfo =>
      _valueAt(_airDefenseInfo, _moduleSelection.airDefenseIndex);
  ShipModuleHolder<DepthChargeInfo>? get depthChargeInfo =>
      _valueAt(_depthChargeInfo, _moduleSelection.depthChargeIndex);

  ShipModuleHolder<Aircraft>? get fighterInfo =>
      _valueAt(_fighterInfo, _moduleSelection.fighterIndex);
  ShipModuleHolder<Aircraft>? get skipBomberInfo =>
      _valueAt(_skipBomberInfo, _moduleSelection.skipBomberIndex);
  ShipModuleHolder<Aircraft>? get torpedoBomberInfo =>
      _valueAt(_torpedoBomberInfo, _moduleSelection.torpedoBomberIndex);
  ShipModuleHolder<Aircraft>? get diveBomberInfo =>
      _valueAt(_diveBomberInfo, _moduleSelection.diveBomberIndex);

  void unpackModules() {
    final shipModules = _ship.components;
    for (final module in _ship.modules.entries) {
      final moduleType = module.key;
      final modules = module.value;
      for (final module in modules) {
        final components = module.components;

        // add a temp helper function
        void addModule<T>(
          ShipModuleType type,
          T Function(Map<String, dynamic>) creator,
          void Function(ShipModuleHolder<T>) add,
        ) {
          final moduleList = components[type.key];
          if (moduleList == null || moduleList.isEmpty) return;
          final info = shipModules[moduleList.first];
          if (info == null) {
            _logger.severe('Module $moduleList not found');
            return;
          }
          final holder = ShipModuleHolder<T>(
            module: module,
            type: type,
            data: creator(info),
          );
          add(holder);
        }

        switch (moduleType) {
          case '_Hull':
            addModule(ShipModuleType.hull, HullInfo.fromJson, _hullInfo.add);
            addModule(ShipModuleType.depthCharge, DepthChargeInfo.fromJson,
                _depthChargeInfo.add);
            addModule(ShipModuleType.airSupport, AirSupportInfo.fromJson,
                _airSupportInfo.add);
            addModule(ShipModuleType.airDefense, AirDefense.fromJson,
                _airDefenseInfo.add);
            addModule(
                ShipModuleType.secondary, GunInfo.fromJson, _secondaryInfo.add);
            addModule(
                ShipModuleType.pinger, PingerInfo.fromJson, _pingerInfo.add);

            // There can be multiple of guns & torps. However, they can be the
            // same although having different names. It is only accurate from
            // the hull itself.
            _gunCount = components['artillery']?.length ?? 0;
            _torpCount = components['torpedoes']?.length ?? 0;
            break;
          case '_Artillery':
            addModule(ShipModuleType.gun, GunInfo.fromJson, _gunInfo.add);
            break;
          case '_Torpedoes':
            addModule(
                ShipModuleType.torpedo, TorpedoInfo.fromJson, _torpInfo.add);
            break;
          case '_Suo':
            addModule(ShipModuleType.fireControl, FireControlInfo.fromJson,
                _fireControlInfo.add);
            break;
          case '_Engine':
            final moduleList = components[ShipModuleType.engine.key];
            if (moduleList == null || moduleList.isEmpty) return;
            final info = shipModules[moduleList.first];
            final holder = ShipModuleHolder(
              type: ShipModuleType.engine,
              module: module,
              data: EngineInfo.fromJson(info),
            );
            _engineInfo.add(holder);
            break;
          case '_SkipBomber':
          case '_TorpedoBomber':
          case '_DiveBomber':
          case '_Fighter':
            // add all aircrafts' information
            final plane = components.values.first.first;
            // NOTE: we need the first one only, some ships have broken
            // entries like Midway. TODO: we should remove additional ones from
            // the game data in the future.
            final key = List<String>.from(shipModules[plane]).first;
            final info = GameRepository.instance.aircraftOf(key);
            if (info == null) {
              _logger.warning('Cannot find aircraft info of $key');
              continue;
            } else {
              _logger.fine('Found aircraft ($moduleType) info of $key');
            }

            switch (moduleType) {
              case '_SkipBomber':
                final holder = ShipModuleHolder(
                  type: ShipModuleType.skipBomber,
                  module: module,
                  data: info,
                );
                _skipBomberInfo.add(holder);
                break;
              case '_TorpedoBomber':
                final holder = ShipModuleHolder(
                  type: ShipModuleType.torpedoBomber,
                  module: module,
                  data: info,
                );
                _torpedoBomberInfo.add(holder);
                break;
              case '_DiveBomber':
                final holder = ShipModuleHolder(
                  type: ShipModuleType.diveBomber,
                  module: module,
                  data: info,
                );
                _diveBomberInfo.add(holder);
                break;
              case '_Fighter':
                final holder = ShipModuleHolder(
                  type: ShipModuleType.fighter,
                  module: module,
                  data: info,
                );
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

    // save the sorting if there are no alternative modules
    if (canChangeModules) _sortModuleLists();
    _logger.fine('Unpacked modules of ${_ship.index}');
  }

  /// Sort all lists to make sure the order is always correct
  void _sortModuleLists() {
    _hullInfo.sort((a, b) => a.compareTo(b));
    _secondaryInfo.sort((a, b) => a.compareTo(b));
    _pingerInfo.sort((a, b) => a.compareTo(b));
    _torpInfo.sort((a, b) => a.compareTo(b));
    _fireControlInfo.sort((a, b) => a.compareTo(b));
    _engineInfo.sort((a, b) => a.compareTo(b));
    _skipBomberInfo.sort((a, b) => a.compareTo(b));
    _torpedoBomberInfo.sort((a, b) => a.compareTo(b));
    _diveBomberInfo.sort((a, b) => a.compareTo(b));
    _fighterInfo.sort((a, b) => a.compareTo(b));
    _airSupportInfo.sort((a, b) => a.compareTo(b));
    _depthChargeInfo.sort((a, b) => a.compareTo(b));
    _logger.fine('Sorted all module lists');
  }
}

/// A data holder with a [ShipModuleInfo] and the data [T].
class ShipModuleHolder<T> {
  const ShipModuleHolder({
    this.module,
    required this.data,
    required this.type,
  });

  final ShipModuleInfo? module;
  final T data;
  final ShipModuleType type;

  int compareTo(ShipModuleHolder other) {
    if (other.module == null) return 0;
    if (module == null) return 0;
    return module!.compareTo(other.module!);
  }
}
