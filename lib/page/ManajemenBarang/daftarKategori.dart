import 'package:aplikasi/page/ManajemenObat/createKategori.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';

class ManagementListKategoriBarang extends StatefulWidget {
  const ManagementListKategoriBarang({super.key});

  @override
  State<ManagementListKategoriBarang> createState() => _ManagementListKategoriBarangState();
}

class _ManagementListKategoriBarangState extends State<ManagementListKategoriBarang> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const H1('Daftar Barang'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ManagementCreateKategori()));
            },
            child: const Text('Tambah Barang'),
          ),
        ]),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          summaryItem("Jumlah Jenis Barang", "15"),
        ]),
        const SizedBox(height: 40),
        const H2('Tabel Data'),
        const SizedBox(height: 10),
        TableStokBarang()
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

  Widget TableStokBarang() {
    return DataTable(
      columns: const [
        DataColumn(
            label: Text(
          'Nama Barang',
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
          const DataCell(Text('Barang 1')),
          const DataCell(Text('100')),
          const DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          const DataCell(Text('Barang 2')),
          const DataCell(Text('200')),
          const DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          const DataCell(Text('Barang 3')),
          const DataCell(Text('300')),
          const DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          const DataCell(Text('Barang 4')),
          const DataCell(Text('400')),
          const DataCell(Text('1000')),
          DataCell(Actions(10)),
        ]),
        DataRow(cells: [
          const DataCell(Text('Barang 5')),
          const DataCell(Text('500')),
          const DataCell(Text('1000')),
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
            backgroundColor:
                WidgetStateProperty.all<Color?>(Colors.red[900])),
        child: Text("Delete", style: TextStyle(color: Colors.red.shade50)),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color?>(Colors.amber[900])),
        child: const Text("Edit", style: TextStyle(color: Colors.black)),
      )
    ]);
  }
}
