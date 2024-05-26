import 'package:flutter/material.dart';
import 'package:aplikasi/page/ManajemenObat/editKategori.dart';
import 'package:aplikasi/page/component/titles.dart';

class ManagementListKategoriBarang extends StatefulWidget {
  const ManagementListKategoriBarang({Key? key}) : super(key: key);

  @override
  State<ManagementListKategoriBarang> createState() =>
      _ManagementListKategoriBarangState();
}

class _ManagementListKategoriBarangState
    extends State<ManagementListKategoriBarang> {
  List<Map<String, String>> _categories = [
    {'nama': 'Barang 1', 'stok': '100', 'harga': '1000'},
    {'nama': 'Barang 2', 'stok': '200', 'harga': '1000'},
    {'nama': 'Barang 3', 'stok': '300', 'harga': '1000'},
    {'nama': 'Barang 4', 'stok': '400', 'harga': '1000'},
    {'nama': 'Barang 5', 'stok': '500', 'harga': '1000'},
  ];

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
          summaryItem("Jumlah Jenis Barang", _categories.length.toString()),
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            H3(title),
            Text(
              info,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
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
            'Actions',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ],
      rows: _categories
          .asMap()
          .entries
          .map((entry) => DataRow(
                cells: [
                  DataCell(Text(entry.value['nama']!)),
                  DataCell(Text(entry.value['stok']!)),
                  DataCell(Text(entry.value['harga']!)),
                  DataCell(Actions(entry.key)),
                ],
              ))
          .toList(),
    );
  }

  Widget Actions(int id) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ManagementEditKategori(
                      id: id,
                      // Pass the category details to the edit page
                      nama: _categories[id]['nama']!,
                      stok: _categories[id]['stok']!,
                      harga: _categories[id]['harga']!,
                    )));
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.amber[900]),
          ),
          child: Text("Edit", style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _showDeleteConfirmationDialog(id);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.red[900]),
          ),
          child: Text("Hapus", style: TextStyle(color: Colors.red.shade50)),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.red, width: 2),
          ),
          title: const Text(
            'Konfirmasi Hapus',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Apakah Anda yakin ingin menghapus barang ini?',
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _categories.removeAt(id);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
