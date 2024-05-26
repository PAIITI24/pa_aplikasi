import 'package:flutter/material.dart';
import 'package:aplikasi/page/ManajemenObat/create.dart';
import 'package:aplikasi/page/ManajemenObat/edit.dart';
import 'package:aplikasi/page/component/titles.dart';

class ManagementListObat extends StatefulWidget {
  const ManagementListObat({super.key});

  @override
  State<ManagementListObat> createState() => _ManagementListObatState();
}

class _ManagementListObatState extends State<ManagementListObat> {
  final List<Map<String, dynamic>> _medicines = [
    {
      'nama': 'Obat 1',
      'kategori': 'Kategori 1',
      'jumlah': 100,
      'tanggal': '2024-12-31',
      'deskripsi': 'Deskripsi Obat 1',
      'harga': 'Rp 10.000',
    },
    {
      'nama': 'Obat 2',
      'kategori': 'Kategori 2',
      'jumlah': 200,
      'tanggal': '2024-11-30',
      'deskripsi': 'Deskripsi Obat 2',
      'harga': 'Rp 20.000',
    },
    // Add more medicines here
  ];

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red.shade50, // Light red background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.red, width: 2),
          ),
          title: const Text('Confirm Deletion',
              style: TextStyle(color: Colors.red)),
          content: const Text(
            'Are you sure you want to delete this item?',
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _medicines.removeAt(index); // Remove the item
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Red background
              ),
            ),
          ],
        );
      },
    );
  }

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
        TableStokObat(context)
      ],
    );
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
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
              )
            ],
          )),
    ));
  }

  Widget TableStokObat(BuildContext context) {
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
          'Aksi',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
      ],
      rows: _medicines.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> medicine = entry.value;
        return DataRow(cells: [
          DataCell(Text(medicine['nama'])),
          DataCell(Text(medicine['jumlah'].toString())),
          DataCell(Text(medicine['harga'])),
          DataCell(Actions(context, index)),
        ]);
      }).toList(),
    );
  }

  Widget Actions(BuildContext context, int index) {
    Map<String, dynamic> medicine = _medicines[index];
    return Row(children: [
      ElevatedButton(
        onPressed: () {
          _showDeleteConfirmationDialog(index);
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.red[900])),
        child: Text("Delete", style: TextStyle(color: Colors.red.shade50)),
      ),
      SizedBox(width: 10),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ManagementEditObat(
                  namaObat: medicine['nama'],
                  kategori: medicine['kategori'],
                  jumlah: medicine['jumlah'],
                  tanggal: medicine['tanggal'],
                  deskripsi: medicine['deskripsi'])));
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.amber[900])),
        child: Text("Edit", style: TextStyle(color: Colors.black)),
      )
    ]);
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
        'Aksi',
        style: TextStyle(fontWeight: FontWeight.w900),
      )),
    ],
    rows: [
      DataRow(cells: [
        const DataCell(Text('Obat 1')),
        const DataCell(Text('100')),
        const DataCell(Text('Rp 10.000')),
        DataCell(Actions(1)),
      ]),
      DataRow(cells: [
        const DataCell(Text('Obat 2')),
        const DataCell(Text('200')),
        const DataCell(Text('Rp 20.000')),
        DataCell(Actions(2)),
      ]),
      DataRow(cells: [
        const DataCell(Text('Obat 3')),
        const DataCell(Text('300')),
        const DataCell(Text('Rp 30.000')),
        DataCell(Actions(3)),
      ]),
      DataRow(cells: [
        const DataCell(Text('Obat 4')),
        const DataCell(Text('400')),
        const DataCell(Text('Rp 40.000')),
        DataCell(Actions(4)),
      ]),
      DataRow(cells: [
        const DataCell(Text('Obat 5')),
        const DataCell(Text('500')),
        const DataCell(Text('Rp 50.000')),
        DataCell(Actions(5)),
      ]),
    ],
  );
}

Widget Actions(int id) {
  return Row(children: [
    ElevatedButton(
      onPressed: () {
        // Add your delete logic here
      },
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.red[900])),
      child: Text("Delete", style: TextStyle(color: Colors.red.shade50)),
    ),
    const SizedBox(width: 10),
    ElevatedButton(
      onPressed: () {
        // Add your edit logic here
      },
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color?>(Colors.amber[900])),
      child: const Text("Edit", style: TextStyle(color: Colors.black)),
    )
  ]);
}
