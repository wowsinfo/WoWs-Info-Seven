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
        child: SingleChildScrollView(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('RollNo')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Class')),
              DataColumn(label: Text('Section')),
              DataColumn(label: Text('Email')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Arya')),
                DataCell(Text('6')),
                DataCell(Text('A')),
                DataCell(Text('aaa@gamilc.aom')),
              ]),
            ],
          ),
        )),
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
