import 'package:flutter/material.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/providers/wiki/ship_info_provider.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_icon.dart';

class ShipInfoPage extends StatefulWidget {
  const ShipInfoPage({
    Key? key,
    required this.ship,
  }) : super(key: key);

  final Ship ship;

  @override
  _ShipInfoPageState createState() => _ShipInfoPageState();
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
        child: Column(children: [
          _ShipTitleSection(
            icon: _provider.shipIcon,
            name: _provider.shipName,
            region: _provider.region,
            type: _provider.type,
            costCR: _provider.costCR,
            costGold: _provider.costGold,
            description: _provider.description,
          ),
        ]),
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
          Text(description),
        ],
      ),
    );
  }
}
