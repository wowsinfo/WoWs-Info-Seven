import 'package:flutter/material.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';

void showFilterShipDialog(BuildContext context, Function(ShipFilter) onFilter) {
  showDialog(
    context: context,
    builder: (context) => _ShipFilterDialog(
      onFilter: onFilter,
    ),
  );
}

class _ShipFilterDialog extends StatefulWidget {
  const _ShipFilterDialog({
    Key? key,
    required this.onFilter,
  }) : super(key: key);

  final Function(ShipFilter) onFilter;

  @override
  _ShipFilterDialogState createState() => _ShipFilterDialogState();
}

class _ShipFilterDialogState extends State<_ShipFilterDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Ships'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nation',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Type',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Tier',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          ElevatedButton(
            onPressed: () {
              ///
            },
            child: const Text('Filter'),
          )
        ],
      ),
    );
  }
}
