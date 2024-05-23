import 'package:aplikasi/page/ManajemenObat/create.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';

class ManagementListObat extends StatefulWidget {
  const ManagementListObat({super.key});

  @override
  State<ManagementListObat> createState() => _ManagementListObatState();
}

class _ManagementListObatState extends State<ManagementListObat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const H1('Daftar Obat'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ManagementCreateObat()));
            },
            child: const Text('Tambah Obat'),
          ),
        ]),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          summaryItem("Jumlah Jenis Obat", "15"),
          summaryItem("Jumlah Obat", "78"),
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
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
