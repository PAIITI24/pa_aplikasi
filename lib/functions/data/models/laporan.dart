import 'package:aplikasi/functions/data/models/barang.dart';
import 'package:aplikasi/functions/data/models/obat.dart';

enum Jenis { Keluar, Masuk }

class LaporanDataObat {
  final int? id;
  final int? jumlah;
  final Jenis? status;
  final DateTime? expiredDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Obat? obat;

  LaporanDataObat({
    this.jumlah,
    this.status,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.obat,
    this.id,
  });

  factory LaporanDataObat.fromStokMasukObat(StokMasukObat smo) {
    return LaporanDataObat(
        jumlah: smo.stokMasuk,
        status: Jenis.Masuk,
        expiredDate: smo.expiredDate,
        createdAt: smo.createdAt,
        updatedAt: smo.updatedAt,
        obat: smo.obat,
        id: smo.id);
  }

  factory LaporanDataObat.fromStokKeluarObat(StokKeluarObat smo) {
    return LaporanDataObat(
        jumlah: smo.stokKeluar,
        status: Jenis.Keluar,
        createdAt: smo.createdAt,
        updatedAt: smo.updatedAt,
        obat: smo.obat,
        id: smo.id);
  }
}

class LaporanDataBarang {
  final int? id;
  final int? jumlah;
  final Jenis? status;
  final DateTime? expiredDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Barang? barang;

  LaporanDataBarang({
    this.jumlah,
    this.status,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.barang,
    this.id,
  });

  factory LaporanDataBarang.fromStokMasukBarang(StokMasukBarang smo) {
    return LaporanDataBarang(
        jumlah: smo.stokMasuk,
        status: Jenis.Masuk,
        expiredDate: smo.expiredDate,
        createdAt: smo.createdAt,
        updatedAt: smo.updatedAt,
        barang: smo.barang,
        id: smo.id);
  }

  factory LaporanDataBarang.fromStokKeluarBarang(StokKeluarBarang smo) {
    return LaporanDataBarang(
        jumlah: smo.stokKeluar,
        status: Jenis.Keluar,
        createdAt: smo.createdAt,
        updatedAt: smo.updatedAt,
        barang: smo.barang,
        id: smo.id);
  }
}
