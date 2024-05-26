import 'package:aplikasi/functions/obat/kategori/create.dart';
import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:flutter/material.dart';

class ManajementCreateBarang extends StatefulWidget {
  const ManajementCreateBarang({super.key});

  @override
  State<ManajementCreateBarang> createState() => _ManajementCreateBarangState();
}

class _ManajementCreateBarangState extends State<ManajementCreateBarang> {
  final TextEditingController _namaKategori = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: TopBar(context, title: "Add a Barang"),
      body: Center(
        child: BoxWithMaxWidth(
          maxWidth: 1000,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const H1("Create Barang"),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        TextField(
                          controller: _namaKategori,
                          decoration: const InputDecoration(
                            labelText: 'Nama Barang',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            CreateKategoriObat(_namaKategori.text);
                          },
                          child: const Text('Simpan'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
