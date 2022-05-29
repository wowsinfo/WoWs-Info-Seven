import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/extensions/list.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';
import 'package:wowsinfo/providers/wiki/filter_ship_provider.dart';
import 'package:wowsinfo/repositories/localisation.dart';

void showFilterShipDialog(
  BuildContext context,
  void Function(ShipFilter) onFilter,
) {
  showDialog(
    context: context,
    builder: (context) => ChangeNotifierProvider(
      create: (context) => FilterShipProvider(context),
      builder: (context, widget) => _ShipFilterDialog(
        onFilter: onFilter,
      ),
    ),
  );
}

class _ShipFilterDialog extends StatelessWidget {
  _ShipFilterDialog({
    Key? key,
    required this.onFilter,
  }) : super(key: key);

  final Function(ShipFilter) onFilter;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterShipProvider>(context);
    return Dialog(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: renderListTitle(
                  context,
                  Localisation.instance.shipNameFilterName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: nameController,
                  // remove underline
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '...',
                  ),
                ),
              ),
              const Divider(),
              renderListTitle(context, Localisation.instance.tierFilterName),
              renderTierList(context),
              const Divider(),
              renderListTitle(
                context,
                Localisation.instance.shipTypeFilterName,
              ),
              renderTypeList(context),
              const Divider(),
              renderListTitle(context, provider.regionFilterName),
              renderRegionList(context),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => provider.resetAll(),
                    icon: const Icon(Icons.refresh),
                  ),
                  IconButton(
                    onPressed: () {
                      onFilter(provider.onFilter(nameController.text));
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderListTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget renderRegionList(BuildContext context) {
    final provider = Provider.of<FilterShipProvider>(context);
    return _FilterList(
      filterList: provider.regionList,
      isSelected: provider.isRegionSelected,
      onSelected: provider.updateRegion,
    );
  }

  Widget renderTypeList(BuildContext context) {
    final provider = Provider.of<FilterShipProvider>(context);
    return _FilterList(
      filterList: provider.typeList,
      isSelected: provider.isTypeSelected,
      onSelected: provider.updateType,
    );
  }

  Widget renderTierList(BuildContext context) {
    final provider = Provider.of<FilterShipProvider>(context);
    return _FilterList(
      filterList: provider.tierList,
      isSelected: provider.isTierSelected,
      onSelected: provider.updateTier,
    );
  }
}

/// A list of chips that can be selected
@immutable
class _FilterList extends StatelessWidget {
  const _FilterList({
    Key? key,
    required this.filterList,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final List<String> filterList;
  final bool Function(int) isSelected;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: App.isMobile ? -8 : 8,
          runSpacing: 8,
          children: [
            for (final filter in filterList.enumerate())
              InkWell(
                onTap: () => onSelected(filter.value),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: isSelected(filter.key),
                      onChanged: (_) => onSelected(filter.value),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        filter.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
