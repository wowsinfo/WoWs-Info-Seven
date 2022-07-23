import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/models/gamedata/consumable.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/gamedata/ship_additional.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/models/wowsinfo/ship_upgrades.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/localisation/localisation.dart';

/// For the individual ship information.
class ShipInfoProvider with ChangeNotifier {
  final _logger = Logger('ShipInfoProvider');

  final BuildContext _context;
  final Ship _ship;
  late final _shipModules = ShipModules(_ship);
  late final _shipUpgrades = ShipUpgrades(_ship);
  ShipInfoProvider(this._context, this._ship) {
    _shipModules.unpackModules();
    _shipUpgrades.unpackUpgrades();
  }

  ShipModuleSelection get selection => _shipModules.selection;
  void updateSelection(ShipModuleSelection selection) {
    _shipModules.updateSelection(selection);
    _logger.fine('Updated ship module selection');
    notifyListeners();
  }

  String _percent(num? value) {
    if (value == null) return '-';
    // some might be 0.35 instead of 35.0
    if (value < 1) return value.toPercentString();
    return value.asPercentString();
  }

  String _format(num? value, {String suffix = ''}) {
    if (value == null) return '-';
    return '${value.toDecimalString()} $suffix';
  }

  /// This is to calculate the maximum or minimum value
  /// TODO: to be removed in 2.0 because it will be dynamic instead
  String _calc(num? value, double factor) {
    if (value == null) return '-';
    final calculated = (value * factor).toDecimalString();
    return '${value.toDecimalString()} - $calculated';
  }

  String _calcAdd(num? value, double offset) {
    if (value == null) return '-';
    final calculated = (value + offset).toDecimalString();
    return '${value.toDecimalString()} - $calculated';
  }

  String get title => '$shipIcon ${_ship.id}';
  String get tier => GameInfo.tiers[_ship.tier - 1];

  String get shipName {
    final name = Localisation.instance.stringOf(_ship.name);
    if (name == null) return '-';
    return '$tier $name';
  }

  String get shipIcon => _ship.index;
  String get description =>
      Localisation.instance.stringOf(_ship.description) ?? '-';
  String get type => Localisation.instance.stringOf(_ship.typeId) ?? '-';
  String get region => Localisation.instance.stringOf(_ship.regionId) ?? '-';
  String? get costCR => _ship.costCr > 0 ? _format(_ship.costCr) : null;
  String? get costGold => _ship.costGold > 0 ? _format(_ship.costGold) : null;
  ShipAdditional? get shipAdditional =>
      GameRepository.instance.shipAdditionalOf(_ship.id.toString());

  late final bool canChangeModules = _shipModules.canChangeModules;
  late final ShipModuleMap moduleList = _shipModules.moduleList;

  // Hull
  HullInfo? get _hullInfo => _shipModules.hullInfo?.data;
  bool get renderHull => _hullInfo != null;
  String get health => _format(_hullInfo?.health);
  String get torpedoProtection => _percent(_hullInfo?.protection);

  // Main battery
  GunInfo? get _mainGunInfo => _shipModules.gunInfo?.data;
  bool get renderMainGun => _mainGunInfo != null;
  WeaponInfo? get _gun => _mainGunInfo?.guns.first;
  String get gunReloadTime =>
      _format(_gun?.reload, suffix: Localisation.instance.second);
  // Consider the fire control system here
  String get gunRange {
    final suo = _shipModules.fireControlInfo;
    final range = _mainGunInfo?.range;
    if (range == null) return '-';
    if (suo == null) {
      return _format(range / 1000, suffix: Localisation.instance.kilometer);
    }

    // increase the range
    final improvedRange = range * suo.data.maxDistCoef;
    return _format(
      improvedRange / 1000,
      suffix: Localisation.instance.kilometer,
    );
  }

  // Group guns together and format like 3 x 2 1 x 3 (9)
  String get gunConfiguration {
    final guns = _mainGunInfo?.guns;
    if (guns == null) return '-';

    List<String> config = [];
    // int total = 0;
    for (final gun in guns) {
      config.add('${gun.each} x ${gun.count}');
      // total += gun.each * gun.count;
    }

    if (config.isEmpty) return '-';
    return config.join(' ');
  }

  String get gunRotationTime =>
      _format(_gun?.rotation, suffix: Localisation.instance.second);
  String get gunName =>
      Localisation.instance.stringOf(_shipModules.gunInfo?.module?.name) ?? '-';

  bool get hasBurstFire => _mainGunInfo?.burst != null;
  Burst? get burst => _mainGunInfo?.burst;
  BurstFireHolder? get burstFireHolder => _extractBurstFire(burst);
  BurstFireHolder? _extractBurstFire(Burst? burst) {
    if (burst == null) return null;
    return BurstFireHolder(
      reload:
          _format(burst.fullReloadTime, suffix: Localisation.instance.second),
      interval:
          _format(burst.burstReloadTime, suffix: Localisation.instance.second),
      shots: _format(burst.shotsCount),
      modifiers: burst.modifiers?.toString(),
    );
  }

  // String get burstShots => _format(burst?.shotsCount);
  // String get burstReloadTime =>
  //     _format(burst?.burstReloadTime, suffix: Localisation.instance.second);
  // String get burstFullReloadTime =>
  //     _format(burst?.fullReloadTime, suffix: Localisation.instance.second);
  // // Only for certain ships like Conde
  // String? get burstModifier => burst?.modifiers?.toString();

  List<ShellHolder> get shells => _extractShells(_mainGunInfo);
  List<ShellHolder> _extractShells(GunInfo? gunInfo) {
    if (gunInfo == null) return [];
    final List<ShellHolder> shells = [];
    final gun = gunInfo.guns.first;
    for (final ammo in gun.ammo) {
      final ammoInfo = GameRepository.instance.projectileOf(ammo);
      if (ammoInfo == null) continue;

      _logger.fine('Found ammo: ${ammoInfo.name}');
      final type = ammoInfo.ammoType;
      if (type == null) continue;

      final shell = ShellHolder(name: type);
      shell.burnChance = _percent(ammoInfo.burnChance);
      shell.damage = _format(ammoInfo.damage);
      shell.velocity =
          _format(ammoInfo.speed, suffix: Localisation.instance.meterPerSecond);
      shell.weight =
          _format(ammoInfo.weight, suffix: Localisation.instance.kilogram);
      switch (ammoInfo.ammoType) {
        case 'HE':
          shell.penetration =
              _format(ammoInfo.penHe, suffix: Localisation.instance.millimeter);
          break;
        case 'AP':
          shell.overmatch = _format(ammoInfo.overmatch,
              suffix: Localisation.instance.millimeter);
          break;
        case 'CS':
          shell.penetration = _format(ammoInfo.penSAP,
              suffix: Localisation.instance.millimeter);
          break;
        default:
          _logger.severe('Unknown ammo type: ${ammoInfo.type}');
          continue;
      }
      shells.add(shell);
    }
    return shells;
  }

  // Secondaries
  GunInfo? get _secondaryInfo => _shipModules.secondaryInfo?.data;
  bool get renderSecondaryGun => _secondaryInfo != null;
  List<SecondaryGunHolder> get secondaryGuns =>
      _extractSecondaryGuns(_secondaryInfo);
  String get secondaryRange {
    final range = _secondaryInfo?.range;
    if (range == null) return '-';
    return _format(range / 1000, suffix: Localisation.instance.kilometer);
  }

  List<SecondaryGunHolder> _extractSecondaryGuns(GunInfo? gunInfo) {
    if (gunInfo == null) return [];
    final List<SecondaryGunHolder> guns = [];
    for (final gun in gunInfo.guns) {
      final ammo = gun.ammo.first;
      final ammoInfo = GameRepository.instance.projectileOf(ammo);
      if (ammoInfo == null) continue;

      final holder = SecondaryGunHolder(
        name: Localisation.instance.stringOf(ammo, prefix: 'IDS_') ?? '-',
      );

      holder.burnChance = _percent(ammoInfo.burnChance);
      holder.damage = _format(ammoInfo.damage);
      holder.velocity =
          _format(ammoInfo.speed, suffix: Localisation.instance.meterPerSecond);
      holder.reloadTime =
          _format(gun.reload, suffix: Localisation.instance.second);

      switch (ammoInfo.ammoType) {
        case 'HE':
          holder.penetration =
              _format(ammoInfo.penHe, suffix: Localisation.instance.millimeter);
          break;
        case 'CS':
          holder.penetration = _format(ammoInfo.penSAP,
              suffix: Localisation.instance.millimeter);
          break;
        default:
          break;
      }
      guns.add(holder);
    }
    return guns;
  }

  // Torpedo
  TorpedoInfo? get _torpedoInfo => _shipModules.torpedoInfo?.data;
  bool get renderTorpedo => _torpedoInfo != null;
  WeaponInfo? get _torpedo => _torpedoInfo?.launchers.first;
  String get torpedoReloadTime =>
      _format(_torpedo?.reload, suffix: Localisation.instance.second);
  String get torpedoRotationTime =>
      _format(_torpedo?.rotation, suffix: Localisation.instance.second);
  String get torpedoConfiguration {
    final launchers = _torpedoInfo?.launchers;
    if (launchers == null) return '-';

    List<String> config = [];
    // int total = 0;
    for (final launcher in launchers) {
      config.add('${launcher.count} x ${launcher.each}');
      // total += launcher.each * launcher.count;
    }

    if (config.isEmpty) return '-';
    return config.join(' ');
  }

  List<TorpedoHolder> get torpedoes => _extractTorpedoes(_torpedoInfo);
  List<TorpedoHolder> _extractTorpedoes(TorpedoInfo? torpedoInfo) {
    if (_torpedo == null) return [];
    final List<TorpedoHolder> torpedoes = [];
    for (final ammo in _torpedo!.ammo) {
      final ammoInfo = GameRepository.instance.projectileOf(ammo);
      if (ammoInfo == null) continue;

      final torpName = Localisation.instance.stringOf(ammo, prefix: 'IDS_');
      final holder = TorpedoHolder(name: torpName ?? '-');
      // calculate the actual torpedo damage
      final alphaDamage = ammoInfo.alphaDamage ?? 0;
      final damage = ammoInfo.damage ?? 0;
      final actualDamage = (alphaDamage / 3 + damage).round();
      if (actualDamage > 0) {
        holder.damage = _format(actualDamage);
      }

      final range = ammoInfo.range ?? 0;
      final actualRange = (range / (100.0 / 3.0));
      if (actualRange > 0) {
        holder.range =
            _format(actualRange, suffix: Localisation.instance.kilometer);
      }
      final visibility = ammoInfo.visibility;
      if (visibility != null) {
        holder.visibility =
            _format(visibility, suffix: Localisation.instance.kilometer);
      }
      final speed = ammoInfo.speed;
      if (speed != null) {
        holder.speed = _format(speed, suffix: Localisation.instance.knot);
      }

      // 2.6854 is the scale WG uses in game
      final reaction = (visibility ?? 0) / (speed ?? 1) / 2.6854 * 1000;
      if (reaction > 0) {
        holder.reactionTime =
            _format(reaction, suffix: Localisation.instance.second);
      }
      torpedoes.add(holder);
    }
    return torpedoes;
  }

  String get torpedoName =>
      Localisation.instance
          .stringOf('IDS_${_torpedoInfo?.launchers[0].ammo[0]}') ??
      '';

  // Air Defense, it is coming from main battery, secondaries and AA guns
  AirDefense? get _airDefense => _shipModules.airDefenseInfo?.data;
  bool get renderAirDefense => airDefenses.isNotEmpty;
  List<AirDefenseHolder> get airDefenses => _extractAirDefenses(
        _airDefense,
        _mainGunInfo,
        _secondaryInfo,
      );

  List<AirDefenseHolder> _extractAirDefenses(
    AirDefense? airDefense,
    GunInfo? mainGunInfo,
    GunInfo? secondaryInfo,
  ) {
    final List<AirDefenseHolder> airDefenses = [];
    final mid = airDefense?.medium;
    final near = airDefense?.near;
    final far = airDefense?.far;
    final mainFar = mainGunInfo?.far;
    final mainBubble = mainGunInfo?.bubbles;
    final secondaryFar = secondaryInfo?.far;
    final secondaryBubble = secondaryInfo?.bubbles;

    for (final bubble in [mainBubble, secondaryBubble]) {
      if (bubble == null) continue;
      final holder = AirDefenseHolder(
        name: 'TODO',
      );

      holder.range =
          _format(bubble.maxRange, suffix: Localisation.instance.kilometer);
      holder.damage = _format(bubble.damage);
      airDefenses.add(holder);
    }

    for (final aa in [mainFar, secondaryFar, far, mid, near]) {
      if (aa == null) continue;
      final holder = AirDefenseHolder(
        name: 'TODO',
      );

      holder.range =
          _format(aa.maxRange, suffix: Localisation.instance.kilometer);
      holder.damage = _format(aa.damage);
      airDefenses.add(holder);
    }

    return airDefenses;
  }

  // Mobility
  MobilityInfo? get _mobility => _hullInfo?.mobility;
  bool get renderMobility => _mobility != null;
  String get rudderTime =>
      _format(_mobility?.rudderTime, suffix: Localisation.instance.second);
  String get maxSpeed =>
      _format(_mobility?.speed, suffix: Localisation.instance.knot);
  String get turninRadius =>
      _format(_mobility?.turningRadius, suffix: Localisation.instance.meter);

  // Visibility
  VisibilityInfo? get _visibility => _hullInfo?.visibility;
  bool get renderVisibility => _visibility != null;
  String get seaVisibility =>
      _format(_visibility?.sea, suffix: Localisation.instance.kilometer);
  String get planeVisibility =>
      _format(_visibility?.plane, suffix: Localisation.instance.kilometer);

  // Upgrades
  bool get hasUpgrades => _shipUpgrades.modernizations.isNotEmpty;
  List<List<Modernization>> get upgrades => _shipUpgrades.modernizationsBySlot;

  // Next ship
  bool get hasNextShip => _ship.nextShips?.isNotEmpty ?? false;
  Iterable<Ship?> get nextShips =>
      _ship.nextShips?.map(
        (e) => GameRepository.instance.shipOf(e.toString()),
      ) ??
      [];

  // Consumables
  bool get hasConsumables => _ship.consumables.isNotEmpty;
  List<List<Consumable>> get consumables => _ship.consumables;
}

/// This model is used to hold the shell information
class ShellHolder {
  ShellHolder({
    required this.name,
  });

  final String name;
  String? burnChance;
  String? weight;
  String? velocity;
  String? damage;
  String? penetration;
  String? overmatch;
}

class BurstFireHolder {
  BurstFireHolder({
    required this.reload,
    required this.interval,
    required this.shots,
    this.modifiers,
  });

  final String reload;
  final String interval;
  final String shots;
  final String? modifiers;
}

class SecondaryGunHolder {
  SecondaryGunHolder({
    required this.name,
  });

  final String name;
  String? reloadTime;
  String? burnChance;
  String? damage;
  String? penetration;
  String? velocity;
}

class TorpedoHolder {
  TorpedoHolder({
    required this.name,
  });

  final String name;
  String? damage;
  String? range;
  String? visibility;
  String? speed;
  String? reactionTime;
}

class AirDefenseHolder {
  AirDefenseHolder({
    required this.name,
  });

  final String name;
  String? configuration;
  String? damage;
  String? range;
}
