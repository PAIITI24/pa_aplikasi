import 'package:intl/intl.dart';

class KategoriBarang {
  int? id;
  String? namaKategoriBarang;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Barang>? barang;

  KategoriBarang({
    this.id,
    this.namaKategoriBarang,
    this.createdAt,
    this.updatedAt,
    this.barang,
  });

  factory KategoriBarang.fromJson(Map<String, dynamic> json) {
    var barangFromJson = json['barang'] as List?;
    List<Barang>? barangList =
        barangFromJson?.map((i) => Barang.fromJson(i)).toList();

    var dateFormat = DateFormat("dd/MM/yyyy");

    return KategoriBarang(
      id: json['id'],
      namaKategoriBarang: json['nama_kategori_barang'],
      createdAt: dateFormat.parse(json['created_at']),
      updatedAt: dateFormat.parse(json['updated_at']),
      barang: barangList,
    );
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");

    return {
      'id': id,
      'nama_kategori_barang': namaKategoriBarang,
      'created_at': createdAt == null ? null : dateFormat.format(createdAt!),
      'updated_at': createdAt == null ? null : dateFormat.format(updatedAt!),
      'barang': barang?.map((brg) => brg.toJson()).toList(),
    };
  }
}

class Barang {
  int? id;
  String? namaBarang;
  int? jumlahStok;
  double? harga;
  String? gambar;
  String? deskripsi;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<KategoriBarang>? kategoriBarang;

  Barang({
    this.id,
    this.namaBarang,
    this.jumlahStok,
    this.harga,
    this.gambar,
    this.deskripsi,
    this.createdAt,
    this.updatedAt,
    this.kategoriBarang,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    var dateFormat = DateFormat("dd/MM/yyyy");

    var kategoriBarangFromJson = json['kategori_barang'] as List?;
    List<KategoriBarang>? kategoriBarangList =
        kategoriBarangFromJson?.map((i) => KategoriBarang.fromJson(i)).toList();

    return Barang(
      id: json['id'],
      namaBarang: json['nama_barang'],
      jumlahStok: json['jumlah_stok'],
      harga: json['harga'].toDouble(),
      gambar: json['gambar'],
      deskripsi: json['deskripsi'],
      createdAt: dateFormat.parse(json['created_at']),
      updatedAt: dateFormat.parse(json['updated_at']),
      kategoriBarang: kategoriBarangList,
    );
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");

    return {
      'id': id,
      'nama_barang': namaBarang,
      'jumlah_stok': jumlahStok,
      'harga': harga,
      'gambar': gambar,
      'deskripsi': deskripsi,
      'created_at': createdAt == null ? null : dateFormat.format(createdAt!),
      'updated_at': updatedAt == null ? null : dateFormat.format(updatedAt!),
      'kategori': kategoriBarang?.map((kbarang) => kbarang.toJson()).toList(),
    };
  }
}

class StokBarangAddReq {
  final int? barangID;
  final int? amount;
  final DateTime? expiredDate;

  StokBarangAddReq({this.barangID, this.amount, this.expiredDate});

  factory StokBarangAddReq.fromJson(Map<String, dynamic> json) {
    var dateFormat = DateFormat("dd/MM/yyyy");

    return StokBarangAddReq(
        barangID: json["barang_id"],
        amount: json["amount"],
        expiredDate: dateFormat.parse(json["expired_date"]));
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");

    return {
      "barang_id": barangID,
      "amount": amount,
      "expired_date":
          expiredDate == null ? null : dateFormat.format(expiredDate!)
    };
  }
}

class StokBarangRedReq {
  final int? barangId;
  final int? amount;
  final int? stokMasukId;

  StokBarangRedReq({this.barangId, this.amount, this.stokMasukId});

  factory StokBarangRedReq.fromJson(Map<String, dynamic> json) {
    return StokBarangRedReq(
        barangId: json["barang_id"],
        amount: json["amount"],
        stokMasukId: json["stok_masuk_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "barang_id": barangId,
      "amount": amount,
      "stok_masuk_id": stokMasukId
    };
  }
}

class StokMasukBarang {
  final int? id;
  final int? barangId;
  final int? stokMasuk;
  final DateTime? expiredDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Barang? barang;

  StokMasukBarang(
      {this.id,
      this.barangId,
      this.stokMasuk,
      this.expiredDate,
      this.createdAt,
      this.updatedAt,
      this.barang});

  factory StokMasukBarang.fromJson(Map<String, dynamic> json) {
    var dateFormat = DateFormat("dd/MM/yyyy");
    return StokMasukBarang(
      id: json["id"],
      barangId: json["barang_id"],
      stokMasuk: json["stok_masuk"],
      expiredDate: json["expired_date"] != null
          ? dateFormat.parse(json["expired_date"])
          : null,
      createdAt: json["created_at"] != null
          ? dateFormat.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? dateFormat.parse(json["updated_at"])
          : null,
      barang: json["barang"] != null ? Barang.fromJson(json["barang"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");
    return {
      "id": id,
      "barang_id": barangId,
      "stok_masuk": stokMasuk,
      "expired_date":
          expiredDate == null ? null : dateFormat.format(expiredDate!),
      "created_at": createdAt == null ? null : dateFormat.format(createdAt!),
      "updated_at": updatedAt == null ? null : dateFormat.format(updatedAt!),
      "barang": barang?.toJson(),
    };
  }
}

class StokKeluarBarang {
  final int? id;
  final int? barangId;
  final int? stokMasukId;
  final int? stokKeluar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Barang? barang;
  final StokMasukBarang? stokMasuk;

  StokKeluarBarang(
      {this.id,
      this.barangId,
      this.stokMasukId,
      this.stokKeluar,
      this.createdAt,
      this.updatedAt,
      this.barang,
      this.stokMasuk});

  factory StokKeluarBarang.fromJson(Map<String, dynamic> json) {
    var dateFormat = DateFormat("dd/MM/yyyy");
    return StokKeluarBarang(
      id: json["id"],
      barangId: json["barang_id"],
      stokKeluar: json["stok_keluar"],
      createdAt: json["created_at"] != null
          ? dateFormat.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? dateFormat.parse(json["updated_at"])
          : null,
      barang: json["barang"] != null ? Barang.fromJson(json["barang"]) : null,
      stokMasuk: json["stok_masuk"] != null
          ? StokMasukBarang.fromJson(json["stok_masuk"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    var dateFormat = DateFormat("dd/MM/yyyy");
    return {
      "id": id,
      "barang_id": barangId,
      "stok_keluar": stokKeluar,
      "created_at": createdAt == null ? null : dateFormat.format(createdAt!),
      "updated_at": updatedAt == null ? null : dateFormat.format(updatedAt!),
      "barang": barang?.toJson(),
      "stok_masuk": stokMasuk?.toJson()
    };
  }
}
