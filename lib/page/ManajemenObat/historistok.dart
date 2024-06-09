import 'package:aplikasi/functions/data/models/laporan.dart';
import 'package:aplikasi/functions/data/models/obat.dart';
import 'package:aplikasi/functions/obat/stok.dart';
import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Mode { all, masukonly, keluaronly }

class DaftarStokObatView extends StatefulWidget {
  final int id;
  const DaftarStokObatView(this.id, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DaftarStokObatView> createState() => _DaftarStokObatViewState(id);
}

class _DaftarStokObatViewState extends State<DaftarStokObatView> {
  final int id;
  _DaftarStokObatViewState(this.id);

  var mode = Mode.all;
  bool orderByExpiredDate = false;

  @override
  Widget build(BuildContext context) {
    print("Building ObatView"); // Debugging print statement
    return Scaffold(
        appBar: TopBar(context, title: "Daftar Stok Obat"),
        drawer: const Sidebar(),
        body: SingleChildScrollView(
            child: BoxWithMaxWidth(
                maxWidth: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tableDaftarStok(),
                    const SizedBox(height: 30),
                    hasExpired(),
                    const SizedBox(height: 30),
                    hasEmpty()
                  ],
                ))));
  }

  Future<List<LaporanDataObat>?> packingLaporanObat() async {
    List<StokKeluarObat>? dataKeluarObat =
        await fetchLaporanKeluarStokObatPerId(this.id);
    List<StokMasukObat>? dataMasukObat =
        await fetchLaporanMasukStokObatPerId(this.id);

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

  Widget reducePopDialog(int barangId, int StokMasukId) {
    final jumlahStokController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: const Text(
        'Kurangi Stok',
      ),
      content: TextField(
        controller: jumlahStokController,
        decoration: const InputDecoration(
          labelText: 'masukkan jumlah disini',
          border: OutlineInputBorder(),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () async {
            if (jumlahStokController.text.trim().isNotEmpty) {
              if (await kurangiStokObat(barangId, StokMasukId,
                      int.parse(jumlahStokController.text)) ==
                  3) {
                showDialog(
                    context: context,
                    builder: (c) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        title: const Text("Gagal"),
                        content: const Text("Melebihi dari yang tersedia"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"))
                        ],
                      );
                    });
              }
              setState(() {});
              Navigator.of(context).pop();
            } else {
              showDialog(
                  context: context,
                  builder: (c) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      title: const Text("Gagal"),
                      content: const Text("Jumlah tidak dapat kosong"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"))
                      ],
                    );
                  });
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('OK', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
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
                                  label: const Text("hanya obat masuk"),
                                  selected: mode == Mode.masukonly,
                                  onSelected: (val) =>
                                      setState(() => mode = Mode.masukonly)),
                              FilterChip(
                                  label: const Text("Hanya obat keluar"),
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
                        const SizedBox(height: 20),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snpsht.data!.where((x) {
                              if (x.status == Jenis.Masuk) {
                                switch (mode) {
                                  case Mode.all:
                                    return true &&
                                        x.expiredDate!
                                            .isAfter(DateTime.now()) &&
                                        x.jumlah! > 0;
                                  case Mode.keluaronly:
                                    return x.status == Jenis.Keluar &&
                                        x.expiredDate!
                                            .isAfter(DateTime.now()) &&
                                        x.jumlah! > 0;
                                  case Mode.masukonly:
                                    return x.status == Jenis.Masuk &&
                                        x.expiredDate!
                                            .isAfter(DateTime.now()) &&
                                        x.jumlah! > 0;
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
                                constraints: BoxConstraints(maxWidth: 600),
                                child: Card(
                                    child: Row(
                                  children: [
                                    Container(
                                        width: 525,
                                        child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        H3(x.obat!.namaObat!),
                                                        if (x.expiredDate !=
                                                            null)
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
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                            "tercatat pada ${df.format(x.createdAt!)} "),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(children: [
                                                          statusLabel(
                                                              x.status!),
                                                          const SizedBox(
                                                              width: 10),
                                                          H4("${x.jumlah}"),
                                                        ])
                                                      ])
                                                ]))),
                                    if (x.status == Jenis.Masuk)
                                      Expanded(
                                        child: Container(
                                          height: 100,
                                          child: Center(
                                              child: IconButton(
                                            icon: const Icon(
                                                Icons.remove_circle_rounded),
                                            color: Colors.red.shade600,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return reducePopDialog(
                                                        this.id, x.id!);
                                                  });
                                            },
                                          )),
                                        ),
                                      )
                                  ],
                                )),
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

  Future<List<LaporanDataObat>?> fetchedHasExpired() async {
    List<StokMasukObat>? dataMasukObat =
        await fetchLaporanMasukStokObatPerId(id);

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
    List<LaporanDataObat> hasExpired = finaldata.where((x) {
      return x.expiredDate!.isBefore(now);
    }).toList();

    return hasExpired;
  }

  Widget hasExpired() {
    return FutureBuilder(
        future: fetchedHasExpired(),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                constraints:
                                    const BoxConstraints(maxWidth: 600),
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
                                                        Text("Sudah Kadaluarsa")
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
    List<StokMasukObat>? dataMasukObat =
        await fetchLaporanMasukStokObatPerId(id);

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
        return H4("masuk",
            color: (!sudahexpired) ? Colors.green.shade500 : Colors.grey);
      case Jenis.Keluar:
        return H4("keluar",
            color: (!sudahexpired) ? Colors.red.shade500 : Colors.grey);
    }
  }
}

class ReduceCurrentlyStok extends StatelessWidget {
  const ReduceCurrentlyStok({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
