import 'package:logging/logging.dart';
import 'package:wowsinfo/models/gamedata/aircraft.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

typedef ShipModuleMap<T> = Map<String, List<ShipModuleHolder<T>>>;

class ShipModules {
  final _logger = Logger('ShipModules');

  final Ship _ship;
  final void Function() notifyChanges;
  ShipModules(this._ship, {required this.notifyChanges});

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
    if (_hullInfo.length > 1) moduleMap['aaa'] = _hullInfo;
    if (_gunCount > 1) moduleMap['bbb'] = _gunInfo;
    if (_torpCount > 1) moduleMap['ccc'] = _torpInfo;
    if (_fireControlInfo.length > 1) moduleMap['ddd'] = _fireControlInfo;
    if (_engineInfo.length > 1) moduleMap['eee'] = _engineInfo;
    if (_fighterInfo.length > 1) moduleMap['fff'] = _fighterInfo;
    if (_skipBomberInfo.length > 1) moduleMap['ggg'] = _skipBomberInfo;
    if (_torpedoBomberInfo.length > 1) moduleMap['hhh'] = _torpedoBomberInfo;
    if (_diveBomberInfo.length > 1) moduleMap['iii'] = _diveBomberInfo;
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

  bool isSelected(String key, int index) {
    switch (key) {
      case 'engine':
        return _selectedEngine == index;
      case 'artillery':
        return _selectedGun == index;
      case 'atba':
        return _selectedSecondary == index;
      case 'torpedoes':
        return _selectedTorp == index;
      case 'pinger':
        return _selectedPinger == index;
      case 'fireControl':
        return _selectedFireControl == index;
      case 'airSupport':
        return _selectedAirSupport == index;
      case 'depthCharges':
        return _selectedDepthCharge == index;
      case 'fighter':
        return _selectedFighter == index;
      case 'skipBomber':
        return _selectedSkipBomber == index;
      case 'torpedoBomber':
        return _selectedTorpedoBomber == index;
      case 'hull':
        return _selectedHull == index;
      default:
        return false;
    }
  }

  void updateHull(int index) {
    _selectedHull = index;
    _logger.fine('updateHull: $index');
    notifyChanges();
  }

  void updateGun(int index) {
    _selectedGun = index;
    _logger.fine('updateGun: $index');
    notifyChanges();
  }

  void updateSecondary(int index) {
    _selectedSecondary = index;
    _logger.fine('updateSecondary: $index');
    notifyChanges();
  }

  void updateTorpedo(int index) {
    _selectedTorp = index;
    _logger.fine('updateTorpedo: $index');
    notifyChanges();
  }

  void updateEngine(int index) {
    _selectedEngine = index;
    _logger.fine('updateEngine: $index');
    notifyChanges();
  }

  void updatePinger(int index) {
    _selectedPinger = index;
    _logger.fine('updatePinger: $index');
    notifyChanges();
  }

  void updateFireControl(int index) {
    _selectedFireControl = index;
    _logger.fine('updateFireControl: $index');
    notifyChanges();
  }

  void updateAirSupport(int index) {
    _selectedAirSupport = index;
    _logger.fine('updateAirSupport: $index');
    notifyChanges();
  }

  void updateDepthCharge(int index) {
    _selectedDepthCharge = index;
    _logger.fine('updateDepthCharge: $index');
    notifyChanges();
  }

  void updateFighter(int index) {
    _selectedFighter = index;
    _logger.fine('updateFighter: $index');
    notifyChanges();
  }

  void updateSkipBomber(int index) {
    _selectedSkipBomber = index;
    _logger.fine('updateSkipBomber: $index');
    notifyChanges();
  }

  void updateTorpedoBomber(int index) {
    _selectedTorpedoBomber = index;
    _logger.fine('updateTorpedoBomber: $index');
    notifyChanges();
  }

  void updateDiveBomber(int index) {
    _selectedDiveBomber = index;
    _logger.fine('updateDiveBomber: $index');
    notifyChanges();
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
          void Function(int) onSelect,
        ) {
          final moduleList = components[key];
          if (moduleList == null || moduleList.isEmpty) return;
          final info = shipModules[moduleList.first];
          final holder = ShipModuleHolder<T>(
            module: module,
            name: key,
            data: creator(info),
            onSelect: onSelect,
          );
          add(holder);
        }

        switch (moduleType) {
          case '_Hull':
            addModule('hull', HullInfo.fromJson, _hullInfo.add, updateHull);
            addModule('depthCharges', DepthChargeInfo.fromJson,
                _depthChargeInfo.add, updateDepthCharge);
            addModule('airSupport', AirSupportInfo.fromJson,
                _airSupportInfo.add, updateAirSupport);
            addModule(
                'atba', GunInfo.fromJson, _secondaryInfo.add, updateSecondary);
            addModule(
                'pinger', PingerInfo.fromJson, _pingerInfo.add, updatePinger);

            // There can be multiple of guns & torps. However, they can be the
            // same although having different names. It is only accurate from
            // the hull itself.
            _gunCount = components['artillery']?.length ?? 0;
            _torpCount = components['torpedoes']?.length ?? 0;
            break;
          case '_Artillery':
            addModule(
                'artillery', GunInfo.fromJson, _secondaryInfo.add, updateGun);
            break;
          case '_Torpedoes':
            addModule('torpedoes', TorpedoInfo.fromJson, _torpInfo.add,
                updateTorpedo);
            break;
          case '_Suo':
            addModule('fireControl', FireControlInfo.fromJson,
                _fireControlInfo.add, updateFireControl);
            break;
          case '_Engine':
            final moduleList = components['engine'];
            if (moduleList == null || moduleList.isEmpty) return;
            final info = shipModules[moduleList.first];
            final holder = ShipModuleHolder(
              name: 'engine',
              module: module,
              data: EngineInfo.fromJson(info),
              onSelect: updateEngine,
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
            // entries like Midway. TODO: we should remove additional ones
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
                  name: 'skipBomber',
                  module: module,
                  data: info,
                  onSelect: updateSkipBomber,
                );
                _skipBomberInfo.add(holder);
                break;
              case '_TorpedoBomber':
                final holder = ShipModuleHolder(
                  name: 'torpedoBomber',
                  module: module,
                  data: info,
                  onSelect: updateTorpedoBomber,
                );
                _torpedoBomberInfo.add(holder);
                break;
              case '_DiveBomber':
                final holder = ShipModuleHolder(
                  name: 'diveBomber',
                  module: module,
                  data: info,
                  onSelect: updateDiveBomber,
                );
                _diveBomberInfo.add(holder);
                break;
              case '_Fighter':
                final holder = ShipModuleHolder(
                  name: 'fighter',
                  module: module,
                  data: info,
                  onSelect: updateFighter,
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

    _logger.fine('Unpacked modules of ${_ship.index}');
  }
}

/// A data holder with a [ShipModuleInfo] and the data [T].
class ShipModuleHolder<T> {
  ShipModuleHolder({
    this.module,
    required this.data,
    required this.name,
    required this.onSelect,
  });

  final ShipModuleInfo? module;
  final T data;
  final String name;
  final void Function(int) onSelect;
}
