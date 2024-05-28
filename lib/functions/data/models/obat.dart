import 'package:intl/intl.dart';

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

  factory KategoriObat.fromJson(Map<String, dynamic> json) {
    var obatFromJson = json['obat'] as List?;
    List<Obat>? obatList = obatFromJson?.map((i) => Obat.fromJson(i)).toList();

    var dateFormat = DateFormat("dd/MM/yyyy");

    return KategoriObat(
      id: json['id'],
      namaKategoriObat: json['nama_kategori_obat'],
      createdAt: dateFormat.parse(json['created_at']),
      updatedAt: dateFormat.parse(json['updated_at']),
      obat: obatList,
    );
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");

    return {
      'id': id,
      'nama_kategori_obat': namaKategoriObat,
      'created_at': createdAt == null ? null : dateFormat.format(createdAt!),
      'updated_at': createdAt == null ? null : dateFormat.format(updatedAt!),
      'obat': obat?.map((obat) => obat.toJson()).toList(),
    };
  }
}

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

  factory Obat.fromJson(Map<String, dynamic> json) {
    var dateFormat = DateFormat("dd/MM/yyyy");

    var kategoriObatFromJson = json['kategori'] as List?;
    List<KategoriObat>? kategoriObatList =
        kategoriObatFromJson?.map((i) => KategoriObat.fromJson(i)).toList();

    return Obat(
      id: json['id'],
      namaObat: json['nama_obat'],
      jumlahStok: json['jumlah_stok'],
      dosisObat: json['dosis_obat'],
      bentukSediaan: json['bentuk_sediaan'],
      hargaSediaan: json['harga'].toDouble(),
      gambar: json['gambar'],
      createdAt: dateFormat.parse(json['created_at']),
      updatedAt: dateFormat.parse(json['updated_at']),
      kategoriObat: kategoriObatList,
    );
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");

    return {
      'id': id,
      'nama_obat': namaObat,
      'jumlah_stok': jumlahStok,
      'dosis_obat': dosisObat,
      'bentuk_sediaan': bentukSediaan,
      'harga': hargaSediaan,
      'gambar': gambar,
      'created_at': createdAt == null ? null : dateFormat.format(createdAt!),
      'updated_at': updatedAt == null ? null : dateFormat.format(updatedAt!),
      'kategori': kategoriObat?.map((kobat) => kobat.toJson()).toList(),
    };
  }
}
