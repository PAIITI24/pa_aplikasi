import 'package:aplikasi/page/ManajemenBarang/create.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';

class ManagementListBarang extends StatefulWidget {
  const ManagementListBarang({Key? key}) : super(key: key);

  @override
  State<ManagementListBarang> createState() => _ManagementListBarangState();
}

class _ManagementListBarangState extends State<ManagementListBarang> {
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
                  builder: (context) => const ManagementCreateBarang()));
            },
            child: const Text('Tambah Barang'),
          ),
        ]),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          summaryItem("Jumlah Jenis Barang", "15"),
          summaryItem("Jumlah Barang", "78"),
        ]),
        const SizedBox(height: 40),
        const H2('Tabel Data'),
        const SizedBox(height: 10),
        TableStokBarang()
      ],
    );
  }
}

Widget summaryItem(String title, String info) {
  return Expanded(
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            H3(title),
            Text(
              info,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget TableStokBarang() {
  return DataTable(
    columns: const [
      DataColumn(
        label: Text(
          'Nama Barang',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      DataColumn(
        label: Text(
          'Stok',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      DataColumn(
        label: Text(
          'Harga',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      DataColumn(
        label: Text(
          'Aksi',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    ],
    rows: [
      DataRow(cells: [
        DataCell(Text('Barang 1')),
        DataCell(Text('100')),
        DataCell(Text('Rp 10.000')),
        DataCell(Actions(1)),
      ]),
      DataRow(cells: [
        DataCell(Text('Barang 2')),
        DataCell(Text('200')),
        DataCell(Text('Rp 20.000')),
        DataCell(Actions(2)),
      ]),
      DataRow(cells: [
        DataCell(Text('Barang 3')),
        DataCell(Text('300')),
        DataCell(Text('Rp 30.000')),
        DataCell(Actions(3)),
      ]),
      DataRow(cells: [
        DataCell(Text('Barang 4')),
        DataCell(Text('400')),
        DataCell(Text('Rp 40.000')),
        DataCell(Actions(4)),
      ]),
      DataRow(cells: [
        DataCell(Text('Barang 5')),
        DataCell(Text('500')),
        DataCell(Text('Rp 50.000')),
        DataCell(Actions(5)),
      ]),
    ],
  );
}

Widget Actions(int id) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: () {
          // Add your delete logic here
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.red[900]),
        ),
        child: Text(
          "Delete",
          style: TextStyle(color: Colors.red.shade50),
        ),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        onPressed: () {
          // Add your edit logic here
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.amber[900]),
        ),
        child: const Text("Edit", style: TextStyle(color: Colors.black)),
      )
    ],
  );
}
