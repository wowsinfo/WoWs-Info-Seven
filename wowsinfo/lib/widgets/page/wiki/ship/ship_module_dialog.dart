import 'package:flutter/material.dart';
import 'package:wowsinfo/extensions/list.dart';
import 'package:wowsinfo/models/wowsinfo/ship_module_selection.dart';
import 'package:wowsinfo/models/wowsinfo/ship_modules.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

void showShipModuleDialog(
  BuildContext context,
  ShipModuleMap modules,
  ShipModuleSelection selection,
) {
  showDialog(
    context: context,
    builder: (_) => _ShipModuleDialog(
      modules: modules,
      selection: selection,
    ),
  );
}

class _ShipModuleDialog extends StatefulWidget {
  const _ShipModuleDialog({
    Key? key,
    required this.modules,
    required this.selection,
  }) : super(key: key);

  final ShipModuleMap modules;
  final ShipModuleSelection selection;

  @override
  _ShipModuleDialogState createState() => _ShipModuleDialogState();
}

class _ShipModuleDialogState extends State<_ShipModuleDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: renderModuleMap(context),
        ),
      ),
    );
  }

  List<Widget> renderModuleMap(BuildContext context) {
    final entries = widget.modules.entries;
    return entries.map((entry) {
      final moduleType = entry.key;
      final list = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              moduleType.name ?? 'X',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          for (final module in list.enumerate())
            buildModuleListTile(
              context,
              module.key,
              widget.selection.isSelected(moduleType, module.key),
              module.value,
            ),
          // add divider if this is not the last module
          if (entry.key != entries.last.key) const Divider(),
          // add the update button to dimiss the dialog
          if (entry.key == entries.last.key)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
        ],
      );
    }).toList(growable: false);
  }

  ListTile buildModuleListTile(
    BuildContext context,
    int index,
    bool selected,
    ShipModuleHolder module,
  ) {
    final info = module.module!;
    final selection = widget.selection;
    final type = module.type;
    return ListTile(
      leading: Checkbox(
        value: selected,
        onChanged: (_) => selection.updateSelected(type, index),
      ),
      title: Text(GameRepository.instance.stringOf(info.name) ?? ''),
      subtitle: Text(info.cost.costCr.toString()),
      trailing: Text('${info.cost.costXp} XP'),
      onTap: () => selection.updateSelected(type, index),
    );
  }
}
