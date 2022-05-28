import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showShipModuleDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) => Container(),
  );
}

class _ShipModuleDialog extends StatefulWidget {
  const _ShipModuleDialog({
    Key key,
    @required this.ship,
    @required this.module,
  }) : super(key: key);

  final Ship ship;
  final Module module;

  @override
  _ShipModuleDialogState createState() => _ShipModuleDialogState();
}

class _ShipModuleDialogState extends State<_ShipModuleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _moduleController = TextEditingController();
  final _moduleCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _moduleController.text = widget.module.name;
    _moduleCountController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Module'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _moduleController,
              decoration: const InputDecoration(
                labelText: 'Module',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a module name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _moduleCountController,
              decoration: const InputDecoration(
                labelText: 'Count',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a module count';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              final module = Module(
                name: _moduleController.text,
                count: int.parse(_moduleCountController.text),
              );
              widget.ship.modules.add(module);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
