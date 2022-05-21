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
        title: Text(widget.ship.name),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _ShipTitleSection(icon: _provider.shipIcon),
        ]),
      ),
    );
  }
}

class _ShipTitleSection extends StatelessWidget {
  const _ShipTitleSection({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ShipIcon(
            name: icon,
            height: 128,
          ),
        ],
      ),
    );
  }
}
