import 'package:aplikasi/functions/data/models/obat.dart';

enum Jenis { Keluar, Masuk }

class LaporanDataObat {
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
  });

  factory LaporanDataObat.fromStokMasukObat(StokMasukObat smo) {
    return LaporanDataObat(
      jumlah: smo.stokMasuk,
      status: Jenis.Masuk,
      expiredDate: smo.expiredDate,
      createdAt: smo.createdAt,
      updatedAt: smo.updatedAt,
      obat: smo.obat,
    );
  }

  factory LaporanDataObat.fromStokKeluarObat(StokKeluarObat smo) {
    return LaporanDataObat(
        jumlah: smo.stokKeluar,
        status: Jenis.Keluar,
        createdAt: smo.createdAt,
        updatedAt: smo.updatedAt,
        obat: smo.obat);
  }
}
