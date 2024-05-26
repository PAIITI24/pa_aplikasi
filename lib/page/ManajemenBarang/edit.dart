import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:flutter/material.dart';

class EditBarang extends StatefulWidget {
  final String namaObat;
  final String kategori;
  final int jumlah;
  final String tanggal;
  final String deskripsi;

  const EditBarang({
    Key? key,
    required this.namaObat,
    required this.kategori,
    required this.jumlah,
    required this.tanggal,
    required this.deskripsi,
  }) : super(key: key);

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _jumlahController;
  late TextEditingController _expiredController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.namaObat);
    _kategoriController = TextEditingController(text: widget.kategori);
    _jumlahController = TextEditingController(text: widget.jumlah.toString());
    _expiredController = TextEditingController(text: widget.tanggal);
    _deskripsiController = TextEditingController(text: widget.deskripsi);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_expiredController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _expiredController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _updateData() {
    // Lakukan update data sesuai dengan nilai yang diinputkan
    String namaObat = _namaController.text;
    String kategori = _kategoriController.text;
    int jumlah = int.tryParse(_jumlahController.text) ?? 0;
    String tanggal = _expiredController.text;
    String deskripsi = _deskripsiController.text;

    // Lakukan proses update data sesuai dengan logika aplikasi Anda
    // Misalnya, mengirim data ke backend untuk update data di database

    // Setelah update selesai, Anda bisa melakukan navigasi kembali atau memberikan notifikasi kepada pengguna
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _jumlahController.dispose();
    _expiredController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: TopBar(context, title: "Edit Barang"),
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
                  const H1("Edit Barang"),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        TextField(
                          controller: _namaController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Barang',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _kategoriController,
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _jumlahController,
                          decoration: const InputDecoration(
                            labelText: 'Jumlah',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _expiredController,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Kadaluarsa',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _deskripsiController,
                          decoration: const InputDecoration(
                            labelText: 'Deskripsi',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _updateData,
                          child: const Text('Update'),
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
