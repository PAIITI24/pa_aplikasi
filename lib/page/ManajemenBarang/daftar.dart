import 'package:flutter/material.dart';
import 'package:aplikasi/page/ManajemenBarang/create.dart';
import 'package:aplikasi/page/ManajemenBarang/edit.dart'; // Import halaman edit barang
import 'package:aplikasi/page/component/titles.dart';

class ManagementListBarang extends StatefulWidget {
  const ManagementListBarang({super.key});

  @override
  State<ManagementListBarang> createState() => _ManagementListBarangState();
}

class _ManagementListBarangState extends State<ManagementListBarang> {
  final List<Map<String, dynamic>> _barangs = [
    {
      'nama': 'Barang 1',
      'stok': 100,
      'harga': 'Rp 10.000',
    },
    {
      'nama': 'Barang 2',
      'stok': 200,
      'harga': 'Rp 20.000',
    },
    // Tambah barang lainnya di sini
  ];

  void _deleteBarang(int index) {
    setState(() {
      _barangs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const H1('Daftar Barang'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ManagementCreateBarang()));
              },
              child: const Text('Tambah Barang'),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            summaryItem("Jumlah Jenis Barang", "${_barangs.length}"),
          ],
        ),
        const SizedBox(height: 40),
        const H2('Tabel Data'),
        const SizedBox(height: 10),
        TableStokBarang(),
      ],
    );
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
      rows: _barangs.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> barang = entry.value;
        return DataRow(cells: [
          DataCell(Text(barang['nama'])),
          DataCell(Text(barang['stok'].toString())),
          DataCell(Text(barang['harga'])),
          DataCell(Actions(index)),
        ]);
      }).toList(),
    );
  }

  Widget Actions(int index) {
    Map<String, dynamic> barang = _barangs[index];
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            _deleteBarang(index);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.red[900]),
          ),
          child: Text("Delete", style: TextStyle(color: Colors.red.shade50)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditBarang(
                namaObat: barang['nama'],
                kategori:
                    'Kategori', // Ganti dengan kategori barang yang sesuai
                jumlah: barang[
                    'stok'], // Ganti dengan jumlah stok barang yang sesuai
                tanggal:
                    '2024-05-24', // Ganti dengan tanggal kadaluarsa yang sesuai
                deskripsi:
                    'Deskripsi', // Ganti dengan deskripsi barang yang sesuai
              ),
            ));
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.amber[900]),
          ),
          child: const Text("Edit", style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}
