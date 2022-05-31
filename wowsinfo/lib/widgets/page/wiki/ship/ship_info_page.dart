import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/providers/wiki/ship_info_provider.dart';
import 'package:wowsinfo/repositories/localisation.dart';
import 'package:wowsinfo/widgets/page/wiki/ship/ship_module_dialog.dart';
import 'package:wowsinfo/widgets/shared/text_with_caption.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_icon.dart';

late final _logger = Logger('ShipInfoPage');

class ShipInfoPage extends StatefulWidget {
  const ShipInfoPage({
    Key? key,
    required this.ship,
  }) : super(key: key);

  final Ship ship;

  @override
  State<ShipInfoPage> createState() => _ShipInfoPageState();
}

class _ShipInfoPageState extends State<ShipInfoPage> {
  late final ShipInfoProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = ShipInfoProvider(context, widget.ship);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(_provider.title),
        ),
        body: SingleChildScrollView(
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
              if (_provider.renderTorpedo) const _ShipTorpedo(),
            ],
          ),
        ),
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
    required this.description,
  }) : super(key: key);

  final String icon;
  final String name;
  final String region;
  final String type;
  final String? costCR;
  final String? costGold;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ShipIcon(
              name: icon,
              height: 128,
            ),
            Text(name, style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(region),
            ),
            Text(type),
            if (costCR != null) Text(costCR!),
            if (costGold != null) Text(costGold!),
            Text(
              description,
              textAlign: TextAlign.center,
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
                title: 'TODO config',
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
            title: 'OVERMATCH TODO!!!!!!!!!!!!!!!!!!',
            value: shell.overmatch!,
          ),
      ],
    );
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
                title: 'TODO config',
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
