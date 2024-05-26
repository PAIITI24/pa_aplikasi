import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import '../component/titles.dart';

class ManagementEditKategoriBarang extends StatefulWidget {
  final int id;
  final String namaBarang = "test";
  final String kategori = "Hayoohh";
  final String jumlah = "123";  
  final String kategoriBarang = "pepek";
  final String deskripsi = "pepek";

  const ManagementEditKategoriBarang({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ManagementEditKategoriBarang> createState() =>
      _ManagementEditKategoriBarangState();
}

class _ManagementEditKategoriBarangState
    extends State<ManagementEditKategoriBarang> {
  late TextEditingController _namaController = TextEditingController();
  late TextEditingController _kategoriController = TextEditingController();
  late TextEditingController _jumlahController = TextEditingController();
  late TextEditingController _kategoriBarangController =
      TextEditingController();
  late TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.namaBarang);
    _jumlahController = TextEditingController(text: widget.jumlah.toString());
    _kategoriBarangController =
        TextEditingController(text: widget.kategoriBarang);
    _deskripsiController = TextEditingController(text: widget.deskripsi);
  }

  // Method untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.tryParse(_kategoriBarangController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _kategoriBarangController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _jumlahController.dispose();
    _kategoriBarangController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: TopBar(context, title: "Edit Kategori Barang"),
      body: Center(
        child: BoxWithMaxWidth(
          maxWidth: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Judul
              const H1(
                "Edit Kategori Barang",
              ),
              SizedBox(height: 25),
              // Form input
              Column(
                children: [
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama Barang',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _kategoriController,
                    decoration: InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _jumlahController,
                    decoration: InputDecoration(
                      labelText: 'Jumlah',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _kategoriBarangController,
                    decoration: InputDecoration(
                      labelText: 'Kategori Barang',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _deskripsiController,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add your update logic here
                    },
                    child: Text('Update'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
