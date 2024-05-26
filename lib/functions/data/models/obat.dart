// KategoriObat class
class KategoriObat {
  int? id;
  String? namaKategoriObat;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Obat>? obat;

  KategoriObat({
    this.id,
    this.namaKategoriObat,
    this.createdAt,
    this.updatedAt,
    this.obat,
  });

  // Method to parse JSON and create a KategoriObat object
  factory KategoriObat.fromJson(Map<String, dynamic> json) {
    return KategoriObat(
      id: json['id'],
      namaKategoriObat: json['nama_kategori_obat'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString().split('-').reversed.join('-'))
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString().split('-').reversed.join('-'))
          : null,
      obat: json['obat'] != null
          ? (json['obat'] as List).map((i) => Obat.fromJson(i)).toList()
          : null,
    );
  }

  // Method to convert a KategoriObat object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori_obat': namaKategoriObat,
      'created_at': createdAt?.toString().split(' ')[0].split('-').reversed.join('-'),
      'updated_at': updatedAt?.toString().split(' ')[0].split('-').reversed.join('-'),
      'obat': obat?.map((o) => o.toJson()).toList(),
    };
  }
}

// Obat class
class Obat {
  int? id;
  String? namaObat;
  int? jumlahStok;
  String? dosisObat;
  String? bentukSediaan;
  double? hargaSediaan; // Changed Float to double
  String? gambar;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<KategoriObat>? kategoriObat;

  Obat({
    this.id,
    this.namaObat,
    this.jumlahStok,
    this.dosisObat,
    this.bentukSediaan,
    this.hargaSediaan,
    this.gambar,
    this.createdAt,
    this.updatedAt,
    this.kategoriObat,
  });

  // Method to parse JSON and create an Obat object
  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      id: json['id'],
      namaObat: json['nama_obat'],
      jumlahStok: json['jumlah_stok'],
      dosisObat: json['dosis_obat'],
      bentukSediaan: json['bentuk_sediaan'],
      hargaSediaan: json['harga'].toDouble(), // Ensuring float conversion
      gambar: json['gambar'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString().split('-').reversed.join('-'))
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString().split('-').reversed.join('-'))
          : null,
      kategoriObat: json['kategori'] != null
          ? (json['kategori'] as List)
              .map((i) => KategoriObat.fromJson(i))
              .toList()
          : null,
    );
  }

  // Method to convert an Obat object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_obat': namaObat,
      'jumlah_stok': jumlahStok,
      'dosis_obat': dosisObat,
      'bentuk_sediaan': bentukSediaan,
      'harga': hargaSediaan,
      'gambar': gambar,
      'created_at': createdAt?.toString().split(' ')[0].split('-').reversed.join('-'),
      'updated_at': updatedAt?.toString().split(' ')[0].split('-').reversed.join('-'),
      'kategori': kategoriObat?.map((k) => k.toJson()).toList(),
    };
  }
}