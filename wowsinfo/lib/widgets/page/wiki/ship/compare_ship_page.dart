import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/providers/wiki/compare_ship_provider.dart';
import 'package:wowsinfo/widgets/shared/filter_ship_dialog.dart';

class CompareShipPage extends StatefulWidget {
  const CompareShipPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CompareShipPageState();
}

class _CompareShipPageState extends State<CompareShipPage> {
  late final _provider = CompareShipProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Ship'),
      ),
      body: ChangeNotifierProvider.value(
        value: _provider,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              fixedLeftColumns: 1,
              columns: [
                DataColumn2(
                  label: Text('Column A'),
                  size: ColumnSize.L,
                  fixedWidth: 100,
                ),
                DataColumn(
                  label: Text('Column B'),
                ),
                DataColumn(
                  label: Text('Column C'),
                ),
                DataColumn(
                  label: Text('Column D'),
                ),
                DataColumn(
                  label: Text('Column NUMBERS'),
                  numeric: true,
                ),
              ],
              rows: List<DataRow>.generate(
                  100,
                  (index) => DataRow(cells: [
                        DataCell(Text('A' * (10 - index % 10))),
                        DataCell(Text('B' * (10 - (index + 5) % 10))),
                        DataCell(Text('C' * (15 - (index + 5) % 10))),
                        DataCell(Text('D' * (15 - (index + 10) % 10))),
                        DataCell(Text(((index + 0.1) * 25.4).toString()))
                      ]))),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFilterShipDialog(context, (filter) {
            _provider.filter = filter;
          });
        },
        child: const Icon(Icons.filter_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
