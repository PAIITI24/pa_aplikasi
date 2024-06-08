import 'package:aplikasi/functions/data/models/laporan.dart';
import 'package:aplikasi/functions/data/models/obat.dart';
import 'package:aplikasi/functions/laporan/obat.dart';
import 'package:aplikasi/functions/obat/laporan/printObat.dart';
import 'package:aplikasi/functions/obat/list.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/laporan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum Mode { all, masukonly, keluaronly }

class ObatView extends StatefulWidget {
  const ObatView({super.key});

  @override
  State<ObatView> createState() => _ObatViewState();
}

class _ObatViewState extends State<ObatView> {
  var mode = Mode.all;
  bool orderByExpiredDate = false;

  @override
  Widget build(BuildContext context) {
    print("Building ObatView"); // Debugging print statement
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const H1('Obat'),
            IconButton(
                onPressed: () {
                  printReportObat(context);
                },
                icon: const Icon(Icons.print))
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 30),
        const H2('Selayang Pandang'),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FutureBuilder(
              future: ListObat(),
              builder: (BuildContext ctx, AsyncSnapshot<List<Obat>?> snpsht) {
                if (snpsht.connectionState == ConnectionState.done &&
                    snpsht.data != null) {
                  int jumlahStokSkrg = 0;
                  snpsht.data!.forEach(
                      (x) => {jumlahStokSkrg = jumlahStokSkrg + x.jumlahStok!});
                  return summaryItem("Total Stok", "${jumlahStokSkrg}");
                } else {
                  return summaryItem("title", "info");
                }
              }),
          FutureBuilder(
              future: fetchLaporanMasukStokObat(),
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<StokMasukObat>?> snpsht) {
                if (snpsht.connectionState == ConnectionState.done &&
                    snpsht.data != null) {
                  int jumlahStokSkrg = 0;
                  snpsht.data!.forEach(
                      (x) => jumlahStokSkrg = jumlahStokSkrg + x.stokMasuk!);
                  return summaryItem("Stok Masuk", "$jumlahStokSkrg");
                } else {
                  return summaryItem("title", "info");
                }
              }),
          FutureBuilder(
              future: fetchLaporanKeluarStokObat(),
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<StokKeluarObat>?> snpsht) {
                if (snpsht.connectionState == ConnectionState.done &&
                    snpsht.data != null) {
                  int jumlahStokSkrg = 0;
                  snpsht.data!.forEach(
                      (x) => jumlahStokSkrg = jumlahStokSkrg + x.stokKeluar!);
                  return summaryItem("Stok Keluar", "$jumlahStokSkrg");
                } else {
                  return summaryItem("title", "info");
                }
              }),
        ]),
        // const SizedBox(height: 40),
        // TableStokObatMasuk(),
        const SizedBox(height: 40),
        NearlyExpired(),
        const SizedBox(height: 40),
        TableDaftarStok(),
      ],
    );
  }

  Widget summaryItem(String title, String info) {
    return Expanded(
        child: Card(
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              H3(title),
              Text(
                info,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
              )
            ],
          )),
    ));
  }

  Future<List<LaporanDataObat>?> packingLaporanObat() async {
    List<StokKeluarObat>? dataKeluarObat = await fetchLaporanKeluarStokObat();
    List<StokMasukObat>? dataMasukObat = await fetchLaporanMasukStokObat();

    if (dataKeluarObat != null && dataMasukObat != null) {
      if (mode == Mode.all) {
        List<LaporanDataObat> packedDataKeluarObat = dataKeluarObat.map((data) {
          return LaporanDataObat.fromStokKeluarObat(data);
        }).toList();

        List<LaporanDataObat> packedDataMasukObat = dataMasukObat.map((data) {
          return LaporanDataObat.fromStokMasukObat(data);
        }).toList();

        List<LaporanDataObat> finaldata = List.from(packedDataKeluarObat)
          ..addAll(packedDataMasukObat);

        return finaldata;
      } else if (mode == Mode.keluaronly) {
        List<LaporanDataObat> finaldata = dataKeluarObat.map((data) {
          return LaporanDataObat.fromStokKeluarObat(data);
        }).toList();

        return finaldata;
      } else if (mode == Mode.masukonly) {
        List<LaporanDataObat> finaldata = dataMasukObat.map((data) {
          return LaporanDataObat.fromStokMasukObat(data);
        }).toList();

        if (orderByExpiredDate) {
          finaldata.sort((x, y) => x.expiredDate!.compareTo(y.expiredDate!));
        }

        return finaldata;
      }

      return null;
    } else {
      return null;
    }
  }

  Widget TableDaftarStok() {
    return FutureBuilder(
        future: packingLaporanObat(),
        builder:
            (BuildContext ctx, AsyncSnapshot<List<LaporanDataObat>?> snpsht) {
          switch (snpsht.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(child: CircularProgressIndicator());
              }

            case ConnectionState.done:
              {
                if (snpsht.data != null) {
                  DateFormat df = DateFormat("dd MMMM yyyy");

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const H2('Keluar Masuk Stok'),
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FilterChip(
                                  label: Text("Tampilkan semua"),
                                  selected: this.mode == Mode.all,
                                  onSelected: (val) => setState(() {
                                        this.mode = Mode.all;
                                        this.orderByExpiredDate = false;
                                      })),
                              FilterChip(
                                  label: Text("hanya obat masuk"),
                                  selected: this.mode == Mode.masukonly,
                                  onSelected: (val) => setState(
                                      () => this.mode = Mode.masukonly)),
                              FilterChip(
                                  label: Text("Hanya obat keluar"),
                                  selected: this.mode == Mode.keluaronly,
                                  onSelected: (val) => setState(() {
                                        this.mode = Mode.keluaronly;
                                        this.orderByExpiredDate = false;
                                      })),
                              FilterChip(
                                  label:
                                      Text("Urut berdasarkan tanggal expired"),
                                  selected: this.orderByExpiredDate,
                                  onSelected: (val) => setState(() {
                                        this.orderByExpiredDate =
                                            !this.orderByExpiredDate;
                                        this.mode = Mode.masukonly;
                                      })),
                            ]),
                        const SizedBox(height: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snpsht.data!.where((x) {
                              switch (mode) {
                                case Mode.all:
                                  return true;
                                case Mode.keluaronly:
                                  return x.status == Jenis.Keluar;
                                case Mode.masukonly:
                                  return x.status == Jenis.Masuk;
                              }
                            }).map((x) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                constraints: BoxConstraints(maxWidth: 550),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              H3(x.obat!.namaObat!),
                                              if (x.expiredDate != null)
                                                Text(
                                                    "kadaluarsa di ${df.format(x.expiredDate!)}, ${DateTime.now().difference(x.expiredDate!).inDays.abs()} hari lagi")
                                            ]),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "tercatat pada ${df.format(x.createdAt!)} "),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                statusLabel(x.status!),
                                                const SizedBox(width: 10),
                                                H4("${x.jumlah} buah"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList())
                      ]);
                } else {
                  return const Center(
                    child: Text("Mohon periksa koneksi internet anda"),
                  );
                }
              }

            default:
              {
                return const Center(
                  child: Text(
                      "Tolong perbarui halaman ini dengan membuka halaman lain dan membuka halaman ini kembali"),
                );
              }
          }
        });
  }

  Future<List<LaporanDataObat>?> fetchedNerarlyExpired() async {
    List<StokMasukObat>? dataMasukObat = await fetchLaporanMasukStokObat();

    if (dataMasukObat == null) {
      return null;
    }

    List<LaporanDataObat> finaldata = dataMasukObat.map((data) {
      return LaporanDataObat.fromStokMasukObat(data);
    }).toList();

    DateTime now = DateTime.now();
    DateTime sevenDaysLater = now.add(const Duration(days: 7));

    finaldata.sort((x, y) => x.expiredDate!.compareTo(y.expiredDate!));

    // Filter the data for items expiring within the next 7 days
    List<LaporanDataObat> nearlyExpired = finaldata.where((x) {
      bool isAfterNow = x.expiredDate!.isAfter(now);
      bool isBeforeSevenDaysLater = x.expiredDate!.isBefore(sevenDaysLater);
      return isAfterNow && isBeforeSevenDaysLater;
    }).toList();

    return nearlyExpired;
  }

  Widget NearlyExpired() {
    return FutureBuilder(
        future: fetchedNerarlyExpired(),
        builder:
            (BuildContext ctx, AsyncSnapshot<List<LaporanDataObat>?> snpsht) {
          switch (snpsht.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(child: CircularProgressIndicator());
              }

            case ConnectionState.done:
              {
                if (snpsht.data != null) {
                  DateFormat df = DateFormat("dd MMMM yyyy");

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const H2('Akan Kadaluarsa'),
                        const Text(
                            'Berikut merupakan daftar stok obat yang akan kadaluarsa dalam seminggu'),
                        const SizedBox(height: 15),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snpsht.data!.map((x) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                constraints: BoxConstraints(maxWidth: 550),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 300),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                H3(x.obat!.namaObat!),
                                                if (x.status == Jenis.Masuk)
                                                  Text(
                                                      "kadaluarsa di ${df.format(x.expiredDate!)}, ${DateTime.now().difference(x.expiredDate!).inDays.abs()} hari lagi")
                                              ]),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "tercatat pada ${df.format(x.createdAt!)}",
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                statusLabel(x.status!),
                                                const SizedBox(width: 10),
                                                H4("${x.jumlah} buah"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList())
                      ]);
                } else {
                  return const Center(
                    child: Text("Mohon periksa koneksi internet anda"),
                  );
                }
              }

            default:
              {
                return const Center(
                  child: Text(
                      "Tolong perbarui halaman ini dengan membuka halaman lain dan membuka halaman ini kembali"),
                );
              }
          }
        });
  }

  Widget statusLabel(Jenis jenis) {
    switch (jenis) {
      case Jenis.Masuk:
        return H4("masuk", color: Colors.green.shade500);
      case Jenis.Keluar:
        return H4("keluar", color: Colors.red.shade500);
    }
  }
}
