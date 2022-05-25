import 'package:flutter/material.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/providers/wiki/ship_info_provider.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/shared/text_with_caption.dart';
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

class _ShipInfoPageState extends State<ShipInfoPage> {
  late final _provider = ShipInfoProvider(context, widget.ship);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _ShipModuleButton(
                title: 'Change Ship Modules',
                moduleMap: _provider.moduleList,
              ),
            if (_provider.renderHull)
              _ShipSurvivabilty(
                health: _provider.health,
                protection: _provider.torpedoProtection,
              ),
          ],
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
            Text(name),
            Text(region),
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
    required this.moduleMap,
  }) : super(key: key);

  final String title;
  final ShipModuleMap moduleMap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SingleChildScrollView(
                child: Column(
                  children: renderModuleMap(context),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> renderModuleMap(BuildContext context) {
    final entries = moduleMap.entries;
    return entries.map((entry) {
      final moduleName = entry.key;
      final list = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              moduleName,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          for (final module in list)
            ListTile(
              title: Text(GameRepository.instance.stringOf(module.name) ?? ''),
              subtitle: Text(module.cost.costCr.toString()),
              trailing: Text(module.cost.costXp.toString() + ' XP'),
              onTap: () {},
            ),
          // add divider if this is not the last module
          if (entry.key != entries.last.key) const Divider(),
        ],
      );
    }).toList();
  }
}

class _ShipSurvivabilty extends StatelessWidget {
  const _ShipSurvivabilty({
    Key? key,
    required this.health,
    required this.protection,
  }) : super(key: key);

  final String health;
  final String protection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Surviabilty',
            style: Theme.of(context).textTheme.headline6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextWithCaption(
                title: 'Health',
                value: health,
              ),
              TextWithCaption(
                title: 'Protection',
                value: protection,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShipMainBettery extends StatelessWidget {
  const _ShipMainBettery({
    Key? key,
    required this.reload,
    required this.range,
    required this.config,
    required this.dispersion,
    required this.rotation,
    required this.gunName,
  }) : super(key: key);

  final String reload;
  final String range;
  final String config;
  final String dispersion;
  final String rotation;

  final String gunName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Main Battery',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
