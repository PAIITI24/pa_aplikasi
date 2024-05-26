import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';

class ObatView extends StatefulWidget {
  const ObatView({super.key});

  @override
  State<ObatView> createState() => _ObatViewState();
}

class _ObatViewState extends State<ObatView> {
  @override
  Widget build(BuildContext context) {
    print("Building ObatView"); // Debugging print statement
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const H1('per Agustus'),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 30),
        const H2('Selayang Pandang'),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          summaryItem("Halo", "300"),
          summaryItem("Halo", "300"),
          summaryItem("Halo", "300"),
        ]),
        const SizedBox(height: 40),
        const H2('Tabel Data'),
        const SizedBox(height: 10),
        TableStokObat()
      ],
    );
  }
}

Widget summaryItem(String title, String info) {
  return Expanded(
      child: Card(
    margin: const EdgeInsets.all(10),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            H3(title),
            Text(
              info,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
            )
          ],
        )),
  ));
}

Widget TableStokObat() {
  return DataTable(
    columns: const [
      DataColumn(
          label: Text(
        'Nama Obat',
        style: TextStyle(fontWeight: FontWeight.w900),
      )),
      DataColumn(
          label: Text(
        'Stok',
        style: TextStyle(fontWeight: FontWeight.w900),
      )),
      DataColumn(
          label: Text(
        'Harga',
        style: TextStyle(fontWeight: FontWeight.w900),
      )),
    ],
    rows: const [
      DataRow(cells: [
        DataCell(Text('Obat 1')),
        DataCell(Text('100')),
        DataCell(Text('Rp 10.000')),
      ]),
      DataRow(cells: [
        DataCell(Text('Obat 2')),
        DataCell(Text('200')),
        DataCell(Text('Rp 20.000')),
      ]),
      DataRow(cells: [
        DataCell(Text('Obat 3')),
        DataCell(Text('300')),
        DataCell(Text('Rp 30.000')),
      ]),
      DataRow(cells: [
        DataCell(Text('Obat 4')),
        DataCell(Text('400')),
        DataCell(Text('Rp 40.000')),
      ]),
      DataRow(cells: [
        DataCell(Text('Obat 5')),
        DataCell(Text('500')),
        DataCell(Text('Rp 50.000')),
      ]),
    ],
  );
}
