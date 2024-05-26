import 'package:flutter/material.dart';

class ManagementEditKategoriBarang extends StatefulWidget {
  final String namaBarang;
  final String kategori;
  final int jumlah;
  final String kategoriBarang;
  final String deskripsi;

  const ManagementEditKategoriBarang({
    Key? key,
    required this.namaBarang,
    required this.kategori,
    required this.jumlah,
    required this.kategoriBarang,
    required this.deskripsi,
  }) : super(key: key);

  @override
  State<ManagementEditKategoriBarang> createState() => _ManagementEditKategoriBarangState();
}

class _ManagementEditKategoriBarangState extends State<ManagementEditKategoriBarang> {
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _jumlahController;
  late TextEditingController _kategoriBarangController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.namaBarang);
    _kategoriController = TextEditingController(text: widget.kategori);
    _jumlahController = TextEditingController(text: widget.jumlah.toString());
    _kategoriBarangController = TextEditingController(text: widget.kategoriBarang);
    _deskripsiController = TextEditingController(text: widget.deskripsi);
  }

  // Method untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_kategoriBarangController.text) ?? DateTime.now(),
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
      appBar: AppBar(
        title: Text("Edit Kategori Barang"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Judul
              Text(
                "Edit Kategori Barang",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
