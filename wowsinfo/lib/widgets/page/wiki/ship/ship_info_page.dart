import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/foundation/colours.dart';
import 'package:wowsinfo/models/gamedata/consumable.dart';
import 'package:wowsinfo/models/gamedata/modernization.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/gamedata/ship_additional.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/providers/wiki/scroll_provider.dart';
import 'package:wowsinfo/providers/wiki/ship_info_provider.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/providers/wiki/similar_ship_provider.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/ship_module_dialog.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/ship_penetration_dialog.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/similar_ship_list.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';
import 'package:wowsinfo/widgets/shared/text_with_caption.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_additional_box.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_cell.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_icon.dart';

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
    _provider = ShipInfoProvider(widget.ship);
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
        bottomNavigationBar: buildSimilarShips(),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              title: Text(_provider.title),
              floating: true,
            ),
            SliverMasonryGrid(
              delegate: SliverChildListDelegate(
                [
                  _ShipTitleSection(
                    icon: _provider.shipIcon,
                    name: _provider.shipNameWithTier,
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
                  if (_provider.renderMainGun)
                    _ShipMainBattery(ship: widget.ship),
                  if (_provider.renderSpecials) const _ShipSpecial(),
                  if (_provider.renderSecondaryGun) const _ShipSecondaries(),
                  if (_provider.renderPinger) const _ShipPinger(),
                  if (_provider.renderSubmarineBattery) const _ShipBattery(),
                  if (_provider.renderTorpedo) const _ShipTorpedo(),
                  if (_provider.renderAirDefense) const _ShipAirDefense(),
                  if (_provider.renderAirSupport) const _ShipAirSupport(),
                  if (_provider.renderDepthCharge) const _ShipDepthCharge(),
                  if (_provider.renderMobility) const _ShipMobility(),
                  if (_provider.renderVisibility) const _ShipVisibility(),
                  if (_provider.hasUpgrades) const _ShipUpgrades(),
                  if (_provider.hasNextShip) const _ShipNextShip(),
                  if (_provider.hasConsumables) const _ShipConsumables(),
                  Container(height: 32)
                ],
              ),
              gridDelegate:
                  const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget? buildSimilarShips() {
    if (!_similarProvider.hasSimilarShips) return null;

    // Animated offset change
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShipIcon(
              icon: icon,
              height: 128,
              hero: true,
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
    return Card(
      child: Padding(
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
      ),
    );
  }
}

class _ShipMainBattery extends StatelessWidget {
  const _ShipMainBattery({
    Key? key,
    required this.ship,
  }) : super(key: key);

  final Ship ship;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                TextWithCaption(
                  title: 'Sigma',
                  value: provider.gunSigma,
                ),
              ],
            ),
            if (provider.hasBurstFire)
              _renderBurstFire(context, provider.burstFireHolder),
            Center(
              child: Text(
                provider.gunName,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.bar_chart_sharp),
              onPressed: () {
                showShipPenetrationDialog(context, ship);
              },
              label: const Text('show ap penetration curve'),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                for (final shell in provider.shells)
                  _renderShell(context, shell),
              ],
            ),
          ],
        ),
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

  Widget _renderBurstFire(BuildContext context, BurstFireHolder? holder) {
    if (holder == null) {
      assert(false, "Burst fire holder shouldn't be null here, not expected");
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            Localisation.instance.burstFire,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            TextWithCaption(
              title: Localisation.instance.burstFireCount,
              value: holder.shots,
            ),
            TextWithCaption(
              title: Localisation.instance.burstFireInterval,
              value: holder.interval,
            ),
            TextWithCaption(
              title: Localisation.instance.burstFireReload,
              value: holder.reload,
            ),
          ],
        ),
        if (holder.modifiers != null)
          Center(
            child: Text(
              holder.modifiers!,
              textAlign: TextAlign.center,
            ),
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
    return Card(
      child: Padding(
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

class _ShipPinger extends StatelessWidget {
  const _ShipPinger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                Localisation.instance.sonar,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                TextWithCaption(
                  title: Localisation.instance.reloadTime,
                  value: provider.pingerReloadTime,
                ),
                TextWithCaption(
                  title: Localisation.instance.pingerDuration,
                  value: provider.pingerDuration,
                ),
                TextWithCaption(
                  title: Localisation.instance.shellVelocity,
                  value: provider.pingerSpeed,
                ),
                TextWithCaption(
                  title: Localisation.instance.maximumRange,
                  value: provider.pingerRange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipBattery extends StatelessWidget {
  const _ShipBattery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                Localisation.instance.diveCapacity,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                TextWithCaption(
                  title: Localisation.instance.batteryMaxCapacity,
                  value: provider.submarineBatteryCapacity,
                ),
                TextWithCaption(
                  title: Localisation.instance.batteryConsumption,
                  value: provider.submarineBatteryUseRate,
                ),
                TextWithCaption(
                  title: Localisation.instance.bateryRegen,
                  value: provider.submarineBatteryRegen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipTorpedo extends StatelessWidget {
  const _ShipTorpedo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
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
          TextWithCaption(
            title: Localisation.instance.floodChance,
            value: info.floodChance ?? '-',
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
    return Card(
      child: Padding(
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
            for (final bubble in provider.airBubbles)
              renderAirBubble(context, bubble),
            for (final aa in provider.airDefenses)
              ...renderAirDefense(context, aa),
          ],
        ),
      ),
    );
  }

  Wrap renderAirBubble(BuildContext context, AirBubbleHolder info) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      spacing: 16,
      children: [
        TextWithCaption(
          title: Localisation.instance.bubbleExplosion,
          value: info.explosions,
        ),
        TextWithCaption(
          title: Localisation.instance.gunDamage,
          value: info.damage,
        ),
        TextWithCaption(
          title: Localisation.instance.hitChance,
          value: info.hitChance,
        ),
        TextWithCaption(
          title: Localisation.instance.aaRange,
          value: info.range,
        ),
      ],
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
            title: Localisation.instance.gunDamage,
            value: info.damage,
          ),
          TextWithCaption(
            title: Localisation.instance.hitChance,
            value: info.hitChance,
          ),
          TextWithCaption(
            title: Localisation.instance.aaRange,
            value: info.range,
          ),
        ],
      ),
    ];
  }
}

class _ShipAirSupport extends StatelessWidget {
  const _ShipAirSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                Localisation.instance.airSupport,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Center(
              child: Text(
                provider.airSupportName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                TextWithCaption(
                  title: Localisation.instance.reloadTime,
                  value: provider.airSupportReload,
                ),
                TextWithCaption(
                  title: Localisation.instance.availableFlights,
                  value: provider.airSupportCharges,
                ),
                TextWithCaption(
                  title: Localisation.instance.airSupportTotalPlanes,
                  value: provider.airSupportTotalPlanes,
                ),
                TextWithCaption(
                  title: Localisation.instance.planeHealth,
                  value: provider.airSupportPlaneHealth,
                ),
                TextWithCaption(
                  title: Localisation.instance.maximumRange,
                  value: provider.airSupportRange,
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                TextWithCaption(
                  title: Localisation.instance.numberOfBombs,
                  value: provider.airSupportBombs,
                ),
                TextWithCaption(
                  title: Localisation.instance.bombDamage,
                  value: provider.airSupportBombDamage,
                ),
                if (provider.airSupportBombPeneration != '-')
                  TextWithCaption(
                    title: Localisation.instance.shellPenetration,
                    value: provider.airSupportBombPeneration,
                  ),
                if (provider.airSupportBombBurnChance != '-')
                  TextWithCaption(
                    title: Localisation.instance.shellFireChance,
                    value: provider.airSupportBombBurnChance,
                  ),
                if (provider.airSupportBombFloodChance != '-')
                  TextWithCaption(
                    title: Localisation.instance.floodChance,
                    value: provider.airSupportBombFloodChance,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipDepthCharge extends StatelessWidget {
  const _ShipDepthCharge({Key? key}) : super(key: key);

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
              Localisation.instance.depthCharge,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 16,
            children: [
              TextWithCaption(
                  title: Localisation.instance.bombDamage,
                  value: provider.depthChargeDamage),
              TextWithCaption(
                title: Localisation.of(context).warship_weapon_configuration,
                value: provider.depthChargeConfig,
              ),
              TextWithCaption(
                title: Localisation.instance.reloadTime,
                value: provider.depthChargeReload,
              ),
              TextWithCaption(
                title: Localisation.instance.shellFireChance,
                value: provider.depthChargeBurnChance,
              ),
              TextWithCaption(
                title: Localisation.instance.floodChance,
                value: provider.depthChargeFloodChance,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShipSpecial extends StatelessWidget {
  const _ShipSpecial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                provider.specialName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Center(
              child: Text(
                provider.specialDescription,
                textAlign: TextAlign.center,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                TextWithCaption(
                  title: Localisation.instance.actionTime,
                  value: provider.specialDuration,
                ),
                TextWithCaption(
                  title: Localisation.instance.requiredHits,
                  value: provider.specialHitsRequired,
                ),
              ],
            ),
            Center(
              child: Text(
                provider.specialModifier,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipMobility extends StatelessWidget {
  const _ShipMobility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
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
      ),
    );
  }
}

class _ShipVisibility extends StatelessWidget {
  const _ShipVisibility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Padding(
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
      ),
    );
  }
}

class _ShipUpgrades extends StatelessWidget {
  const _ShipUpgrades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
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
    return AssetImageLoader(name: 'data/live/app/assets/upgrades/$name.png');
  }
}

class _ShipNextShip extends StatelessWidget {
  const _ShipNextShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Column(
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
      ),
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

class _ShipConsumables extends StatelessWidget {
  const _ShipConsumables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShipInfoProvider>(context);
    return Card(
      child: Column(
        children: [
          Text(
            Localisation.instance.consumables,
            style: Theme.of(context).textTheme.headline6,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: provider.consumables.map((consumables) {
                assert(
                  consumables.isNotEmpty,
                  'There should be at least one consumable',
                );

                return Column(
                  children: [
                    for (final consumable in consumables)
                      renderConsumable(context, consumable),
                  ],
                );
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderConsumable(BuildContext context, Consumable consumable) {
    final name = consumable.name;
    final type = consumable.type;
    // TODO: this needs to be in the provider, no logic in the UI
    final info = GameRepository.instance.abilityOf(name);
    if (info == null) {
      assert(false, 'Consumable is not found');
      return Container();
    }

    final ability = info.abilities[type];

    final String icon;
    final String description;
    final String displayName;

    // there can be an iconIDs
    final iconID = ability?.iconIDs;
    if (iconID == null) {
      icon = name;
      description = Localisation.instance.stringOf(info.description) ?? '';
      displayName = Localisation.instance.stringOf(info.name) ?? '';
    } else {
      icon = iconID;
      final alter = info.alter?[iconID];
      if (alter == null) {
        assert(false, "Alter isn't found in the ability");
        return Container();
      }
      description = Localisation.instance.stringOf(alter.description) ?? '';
      displayName = Localisation.instance.stringOf(alter.name) ?? '';
    }

    final abilityModifier = ability.toString();
    final consumableCount = ability?.consumableCount;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(displayName),
            content: Text('$description\n\n$abilityModifier'),
          ),
        );
      },
      child: Column(
        children: [
          AssetImageLoader(
            name: 'data/live/app/assets/consumables/$icon.png',
          ),
          if (consumableCount != null) Text(consumableCount),
        ],
      ),
    );
  }
}
