import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';

class ManagementListKategoriObat extends StatefulWidget {
  const ManagementListKategoriObat({super.key});

  @override
  State<ManagementListKategoriObat> createState() =>
      _ManagementListObatKategoriState();
}

class _ManagementListObatKategoriState
    extends State<ManagementListKategoriObat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const H1('Daftar Kategori Obat'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Tambah Kategori Obat'),
          ),
        ]),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          summaryItem("Jumlah Jenis Obat", "15"),
        ]),
        const SizedBox(height: 40),
        const H2('Tabel Data'),
        const SizedBox(height: 10),
        TableStokObat()
      ],
    );
  }

  Widget summaryItem(String title, String info) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              children: [
                H3(title),
                Text(
                  info,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.w900),
                )
              ],
            )));
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
        DataColumn(
            label: Text(
          'Actions',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Obat 1')),
          DataCell(Text('100')),
          DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 2')),
          DataCell(Text('200')),
          DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 3')),
          DataCell(Text('300')),
          DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 4')),
          DataCell(Text('400')),
          DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 5')),
          DataCell(Text('500')),
          DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
      ],
    );
  }

  Widget Actions(int id) {
    return Row(children: [
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color?>(Colors.red[900])),
        child: Text("Delete", style: TextStyle(color: Colors.red.shade50)),
      ),
      SizedBox(width: 10),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color?>(Colors.amber[900])),
        child: Text("Edit", style: TextStyle(color: Colors.black)),
      )
    ]);
  }
}
