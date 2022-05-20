import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';
import 'package:wowsinfo/providers/wiki/filter_ship_provider.dart';

void showFilterShipDialog(BuildContext context, Function(ShipFilter) onFilter) {
  showDialog(
    context: context,
    builder: (context) => ChangeNotifierProvider(
      create: (context) => FilterShipProvider(),
      builder: (context, widget) => _ShipFilterDialog(
        onFilter: onFilter,
      ),
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
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
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
            // render a list of names in chips and we need to animate when we move a chip up to be selected
            renderTierList(),
            const Divider(),
            renderRegionList(),
            const Divider(),
            renderTypeList(),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Filter'),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderFilterList(
    List<String> filterList,
    List<bool> selectedList,
    Function(String) onSelected,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          for (final key in filterList)
            FilterChip(
              pressElevation: 0,
              selected: selectedList[filterList.indexOf(key)],
              label: Text(key),
              onSelected: (_) => onSelected(key),
            )
        ],
      ),
    );
  }

  Widget renderRegionList() {
    final provider = Provider.of<FilterShipProvider>(context);
    return _renderFilterList(
      provider.regionList,
      provider.regionSelectedList,
      provider.updateRegion,
    );
  }

  Widget renderTypeList() {
    final provider = Provider.of<FilterShipProvider>(context);
    return _renderFilterList(
      provider.typeList,
      provider.typeSelectedList,
      provider.updateType,
    );
  }

  Widget renderTierList() {
    final provider = Provider.of<FilterShipProvider>(context);
    return _renderFilterList(
      provider.tierList,
      provider.tierSelectedList,
      provider.updateTier,
    );
  }
}
