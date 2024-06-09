import 'package:aplikasi/functions/data/models/laporan.dart';
import 'package:aplikasi/functions/data/models/obat.dart';
import 'package:aplikasi/functions/laporan/obat.dart';
import 'package:aplikasi/functions/obat/laporan/print.dart';
import 'package:aplikasi/functions/obat/list.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';
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
        tableDaftarStok(),
        const SizedBox(height: 40),
        hasExpired(),
        const SizedBox(height: 40),
        hasEmpty()
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

  Widget tableDaftarStok() {
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
                                  label: const Text("Tampilkan semua"),
                                  selected: mode == Mode.all,
                                  onSelected: (val) => setState(() {
                                        mode = Mode.all;
                                        orderByExpiredDate = false;
                                      })),
                              FilterChip(
                                  label: const Text("hanya stok masuk"),
                                  selected: mode == Mode.masukonly,
                                  onSelected: (val) =>
                                      setState(() => mode = Mode.masukonly)),
                              FilterChip(
                                  label: const Text("Hanya stok keluar"),
                                  selected: mode == Mode.keluaronly,
                                  onSelected: (val) => setState(() {
                                        mode = Mode.keluaronly;
                                        orderByExpiredDate = false;
                                      })),
                              FilterChip(
                                  label: const Text(
                                      "Urut berdasarkan tanggal expired"),
                                  selected: orderByExpiredDate,
                                  onSelected: (val) => setState(() {
                                        orderByExpiredDate =
                                            !orderByExpiredDate;
                                        mode = Mode.masukonly;
                                      })),
                            ]),
                        const SizedBox(height: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snpsht.data!.where((x) {
                              if (x.expiredDate != null) {
                                switch (mode) {
                                  case Mode.all:
                                    return true &&
                                        x.expiredDate!.isAfter(DateTime.now());
                                  case Mode.keluaronly:
                                    return x.status == Jenis.Keluar &&
                                        x.expiredDate!.isAfter(DateTime.now());
                                  case Mode.masukonly:
                                    return x.status == Jenis.Masuk &&
                                        x.expiredDate!.isAfter(DateTime.now());
                                }
                              } else {
                                switch (mode) {
                                  case Mode.all:
                                    return true;
                                  case Mode.keluaronly:
                                    return x.status == Jenis.Keluar;
                                  case Mode.masukonly:
                                    return x.status == Jenis.Masuk;
                                }
                              }
                            }).map((x) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                constraints:
                                    const BoxConstraints(maxWidth: 550),
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
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "kadaluarsa di ${df.format(x.expiredDate!)}"),
                                                      Text(
                                                          "${DateTime.now().difference(x.expiredDate!).inDays.abs()} hari lagi")
                                                    ])
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
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "kadaluarsa di ${df.format(x.expiredDate!)}"),
                                                        Text(
                                                            "${DateTime.now().difference(x.expiredDate!).inDays.abs()} hari lagi")
                                                      ])
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

  Future<List<LaporanDataObat>?> fetchedHasyExpired() async {
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
      return x.expiredDate!.isBefore(now);
    }).toList();

    return nearlyExpired;
  }

  Widget hasExpired() {
    return FutureBuilder(
        future: fetchedHasyExpired(),
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
                        const H2('Sudah Kadaluarsa'),
                        const Text('Berikut telah melewati tanggal kadaluarsa'),
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
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "kadaluarsa di ${df.format(x.expiredDate!)}"),
                                                        Text(
                                                            "${DateTime.now().difference(x.expiredDate!).inDays.abs()} hari lagi")
                                                      ])
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
                                                statusLabel(x.status!,
                                                    sudahexpired: true),
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

  Future<List<LaporanDataObat>?> fetchedHasEmpty() async {
    List<StokMasukObat>? dataMasukObat = await fetchLaporanMasukStokObat();

    if (dataMasukObat == null) {
      return null;
    }

    List<LaporanDataObat> finaldata = dataMasukObat.map((data) {
      return LaporanDataObat.fromStokMasukObat(data);
    }).toList();

    // Filter the data for items expiring within the next 7 days
    List<LaporanDataObat> hasEmpty = finaldata.where((x) {
      return x.jumlah == 0;
    }).toList();

    return hasEmpty;
  }

  Widget hasEmpty() {
    return FutureBuilder(
        future: fetchedHasEmpty(),
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
                        const H2('Sudah Habis Stok'),
                        const Text('Berikut telah habis stok'),
                        const SizedBox(height: 15),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snpsht.data!.where((x) {
                              return (x.status == Jenis.Masuk &&
                                  x.jumlah! <= 0);
                            }).map((x) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                constraints: BoxConstraints(maxWidth: 600),
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
                                                const Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Telah habis"),
                                                    ])
                                              ]),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "tercatat pada ${df.format(x.createdAt!)}",
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

  Widget statusLabel(Jenis jenis, {bool sudahexpired = false}) {
    switch (jenis) {
      case Jenis.Masuk:
        return H4("stok masuk",
            color: (!sudahexpired) ? Colors.green.shade500 : Colors.grey);
      case Jenis.Keluar:
        return H4("stok keluar",
            color: (!sudahexpired) ? Colors.red.shade500 : Colors.grey);
    }
  }
}
