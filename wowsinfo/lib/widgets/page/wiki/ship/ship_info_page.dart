import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/foundation/colours.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/gamedata/ship_additional.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/providers/wiki/scroll_provider.dart';
import 'package:wowsinfo/providers/wiki/ship_info_provider.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/providers/wiki/similar_ship_provider.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/ship_module_dialog.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/similar_ship_list.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';
import 'package:wowsinfo/widgets/shared/text_with_caption.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_additional_box.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_cell.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_icon.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_name.dart';

class ShipInfoPage extends StatefulWidget {
  const ShipInfoPage({
    Key? key,
    required this.ship,
  }) : super(key: key);

  final Ship ship;

  @override
  State<ShipInfoPage> createState() => _ShipInfoPageState();
}

class _ShipInfoPageState extends State<ShipInfoPage>
    with SingleTickerProviderStateMixin {
  late final ShipInfoProvider _provider;
  late final SimilarShipProvider _similarProvider;

  late final ScrollProvider _scrollProvider;
  final ScrollController _scrollController = ScrollController();

  late final _slideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void initState() {
    super.initState();
    _provider = ShipInfoProvider(context, widget.ship);
    _similarProvider = SimilarShipProvider(widget.ship);
    _scrollProvider = ScrollProvider(
      scroll: _scrollController,
      animation: _slideController,
      height: 130,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _provider),
        ChangeNotifierProvider.value(value: _scrollProvider),
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(_provider.title),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ShipTitleSection(
                icon: _provider.shipIcon,
                name: _provider.shipName,
                region: _provider.region,
                type: _provider.type,
                costCR: _provider.costCR,
                costGold: _provider.costGold,
                additional: _provider.shipAdditional,
                description: _provider.description,
              ),
              if (_provider.canChangeModules)
                Consumer<ShipInfoProvider>(
                  builder: (context, value, child) => _ShipModuleButton(
                    title: 'Change Ship Modules',
                    shipModules: value.moduleList,
                    selection: value.selection,
                  ),
                ),
              if (_provider.renderHull) const _ShipSurvivabilty(),
              if (_provider.renderMainGun) const _ShipMainBattery(),
              if (_provider.renderSecondaryGun) const _ShipSecondaries(),
              if (_provider.renderTorpedo) const _ShipTorpedo(),
              if (_provider.renderAirDefense) const _ShipAirDefense(),
              if (_provider.renderMobility) const _ShipMobility(),
              if (_provider.renderVisibility) const _ShipVisibility(),
              if (_provider.hasUpgrades) const _ShipUpgrades(),
              if (_provider.hasNextShip) const _ShipNextShip(),
              Container(height: 64),
            ],
          ),
        ),
        bottomNavigationBar: buildSimilarShips(),
      ),
    );
  }

  Widget? buildSimilarShips() {
    if (!_similarProvider.hasSimilarShips) return null;

    return Consumer<ScrollProvider>(
      builder: (context, value, child) => AnimatedSwitcher(
        // TODO: improve the animation here, it should slide down
        transitionBuilder: (w, a) => SizeTransition(
          sizeFactor: a,
          child: w,
        ),
        duration: const Duration(milliseconds: 300),
        child: value.display
            ? SimilarShipList(
                source: widget.ship,
                ships: _similarProvider.similarShips,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _ShipTitleSection extends StatelessWidget {
  const _ShipTitleSection({
    Key? key,
    required this.icon,
    required this.name,
    required this.region,
    required this.type,
    this.costCR,
    this.costGold,
    this.additional,
    required this.description,
  }) : super(key: key);

  final String icon;
  final String name;
  final String region;
  final String type;
  final String? costCR;
  final String? costGold;
  final String description;
  final ShipAdditional? additional;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShipIcon(
              icon: icon,
              height: 128,
            ),
            Center(
              child: Text(name, style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(child: Text(region)),
            ),
            Center(child: Text(type)),
            if (costCR != null)
              Center(
                child: Text(
                  costCR!,
                  style: const TextStyle(color: WoWsColours.creditPrice),
                ),
              ),
            if (costGold != null)
              Center(
                child: Text(
                  costGold!,
                  style: const TextStyle(color: WoWsColours.goldPrice),
                ),
              ),
            if (additional != null)
              ShipAdditionalBox(shipAdditional: additional!),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipModuleButton extends StatelessWidget {
  const _ShipModuleButton({
    Key? key,
    required this.title,
    required this.shipModules,
    required this.selection,
  }) : super(key: key);

  final String title;
  final ShipModuleMap shipModules;
  final ShipModuleSelection selection;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        child: Text(title),
        onPressed: () => showShipModuleDialog(
          context,
          shipModules,
          selection,
          (selection) => provider.updateSelection(selection),
        ),
      ),
    );
  }
}

class _ShipSurvivabilty extends StatelessWidget {
  const _ShipSurvivabilty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            Localisation.instance.durability,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextWithCaption(
                title: Localisation.instance.health,
                value: provider.health,
              ),
              TextWithCaption(
                title: Localisation.instance.torpedoProtection,
                value: provider.torpedoProtection,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShipMainBattery extends StatelessWidget {
  const _ShipMainBattery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Localisation.instance.artillery,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 16,
            children: [
              TextWithCaption(
                title: Localisation.instance.gunReloadTime,
                value: provider.gunReloadTime,
              ),
              TextWithCaption(
                title: Localisation.instance.gunRange,
                value: provider.gunRange,
              ),
              // TODO: this doesn't align as expected
              TextWithCaption(
                title: Localisation.of(context).warship_weapon_configuration,
                value: provider.gunConfiguration,
              ),
              TextWithCaption(
                title: Localisation.instance.gunDispersion,
                value: '',
              ),
              TextWithCaption(
                title: Localisation.instance.gunRotationTime,
                value: provider.gunRotationTime,
              ),
            ],
          ),
          Center(
            child: Text(
              provider.gunName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final shell in provider.shells) _renderShell(context, shell),
            ],
          )
        ],
      ),
    );
  }

  Widget _renderShell(BuildContext context, ShellHolder shell) {
    return Column(
      children: [
        Text(shell.name, style: Theme.of(context).textTheme.titleLarge),
        if (shell.burnChance != null)
          TextWithCaption(
            title: Localisation.instance.shellFireChance,
            value: shell.burnChance!,
          ),
        if (shell.weight != null)
          TextWithCaption(
            title: Localisation.instance.shellWeight,
            value: shell.weight!,
          ),
        if (shell.damage != null)
          TextWithCaption(
            title: Localisation.instance.gunDamage,
            value: shell.damage!,
          ),
        if (shell.velocity != null)
          TextWithCaption(
            title: Localisation.instance.shellVelocity,
            value: shell.velocity!,
          ),
        if (shell.penetration != null)
          TextWithCaption(
            title: Localisation.instance.shellPenetration,
            value: shell.penetration!,
          ),
        if (shell.overmatch != null)
          TextWithCaption(
            title: Localisation.of(context).warship_weapon_ap_overmatch,
            value: shell.overmatch!,
          ),
      ],
    );
  }
}

class _ShipSecondaries extends StatelessWidget {
  const _ShipSecondaries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              '${Localisation.instance.secondaryBattery} (${provider.secondaryRange})',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          for (final gun in provider.secondaryGuns)
            ...renderSecondaries(context, gun),
        ],
      ),
    );
  }

  List renderSecondaries(BuildContext context, SecondaryGunHolder info) {
    return [
      Center(
        child: Text(
          info.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 16,
        children: [
          TextWithCaption(
            title: Localisation.instance.gunReloadTime,
            value: info.reloadTime ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.shellVelocity,
            value: info.velocity ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.shellFireChance,
            value: info.burnChance ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.gunDamage,
            value: info.damage ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.shellPenetration,
            value: info.penetration ?? '-',
          ),
        ],
      ),
    ];
  }
}

class _ShipTorpedo extends StatelessWidget {
  const _ShipTorpedo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Localisation.instance.torpedoes,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 16,
            children: [
              TextWithCaption(
                title: Localisation.instance.torpedoReloadTime,
                value: provider.torpedoReloadTime,
              ),
              TextWithCaption(
                title: Localisation.of(context).warship_weapon_configuration,
                value: provider.torpedoConfiguration,
              ),
              TextWithCaption(
                title: Localisation.instance.torpedoRotationTime,
                value: provider.torpedoRotationTime,
              ),
            ],
          ),
          for (final torp in provider.torpedoes)
            ...renderTorpedoInfo(context, torp),
        ],
      ),
    );
  }

  List renderTorpedoInfo(BuildContext context, TorpedoHolder info) {
    return [
      Center(
        child: Text(
          '${info.name} (${info.reactionTime ?? '-'})',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 16,
        children: [
          TextWithCaption(
            title: Localisation.instance.torpedoDamage,
            value: info.damage ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.torpedoDetection,
            value: info.visibility ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.torpedoRange,
            value: info.range ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.torpedoSpeed,
            value: info.speed ?? '-',
          ),
        ],
      ),
    ];
  }
}

class _ShipAirDefense extends StatelessWidget {
  const _ShipAirDefense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Localisation.instance.airDefense,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          for (final aa in provider.airDefenses)
            ...renderAirDefense(context, aa),
        ],
      ),
    );
  }

  List renderAirDefense(BuildContext context, AirDefenseHolder info) {
    return [
      Center(
        child: Text(
          info.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 16,
        children: [
          TextWithCaption(
            title: Localisation.instance.aaRange,
            value: info.range ?? '-',
          ),
          TextWithCaption(
            title: Localisation.instance.gunDamage,
            value: info.damage ?? '-',
          ),
        ],
      ),
    ];
  }
}

class _ShipMobility extends StatelessWidget {
  const _ShipMobility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Localisation.instance.mobility,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 16,
            children: [
              TextWithCaption(
                title: Localisation.instance.rudderTime,
                value: provider.rudderTime,
              ),
              TextWithCaption(
                title: Localisation.instance.maxSpeed,
                value: provider.maxSpeed,
              ),
              TextWithCaption(
                title: Localisation.instance.turningRadius,
                value: provider.turninRadius,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShipVisibility extends StatelessWidget {
  const _ShipVisibility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Localisation.instance.visibility,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 16,
            children: [
              TextWithCaption(
                title: Localisation.instance.airDetection,
                value: provider.planeVisibility,
              ),
              TextWithCaption(
                title: Localisation.instance.seaDetection,
                value: provider.seaVisibility,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShipUpgrades extends StatelessWidget {
  const _ShipUpgrades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Center(
      child: Column(
        children: [
          Text(
            Localisation.instance.upgrades,
            style: Theme.of(context).textTheme.headline6,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: provider.upgrades.map((slots) {
                assert(slots.isNotEmpty, 'There should be at least one slot');
                final slotNumber = slots[0].slot + 1;
                return Column(
                  children: [
                    Text(slotNumber.toString()),
                    for (final upgrade in slots)
                      renderUpgrade(context, upgrade),
                  ],
                );
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderUpgrade(BuildContext context, Modernization upgrade) {
    final name = upgrade.icon;
    return AssetImageLoader(name: 'gamedata/app/assets/upgrades/$name.png');
  }
}

class _ShipNextShip extends StatelessWidget {
  const _ShipNextShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Column(
      children: [
        Text(
          Localisation.instance.nextShip,
          style: Theme.of(context).textTheme.headline6,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: provider.nextShips.map((ship) {
              return renderNextShip(context, ship);
            }).toList(growable: false),
          ),
        )
      ],
    );
  }

  Widget renderNextShip(BuildContext context, Ship? nextShip) {
    assert(nextShip != null, 'Next ship should not be null');
    if (nextShip == null) return Container();
    return ShipCell(
      icon: nextShip.index,
      name: Localisation.instance.stringOf(nextShip.name) ?? '-',
      isPremium: nextShip.isPremium,
      isSpecial: nextShip.isSpecial,
      onTap: () {
        Navigator.of(context).push(
          App.platformPageRoute(
            builder: (context) => ShipInfoPage(ship: nextShip),
          ),
        );
      },
    );
  }
}
