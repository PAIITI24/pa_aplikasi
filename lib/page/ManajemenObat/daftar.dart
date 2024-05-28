import 'package:aplikasi/functions/data/models/obat.dart';
import 'package:aplikasi/functions/obat/list.dart';
import 'package:aplikasi/page/ManajemenObat/create.dart';
import 'package:aplikasi/page/ManajemenObat/edit.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagementListObat extends StatefulWidget {
  const ManagementListObat({super.key});

  @override
  State<ManagementListObat> createState() => _ManagementListObatState();
}

class _ManagementListObatState extends State<ManagementListObat> {
  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red.shade50, // Light red background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.red, width: 2),
          ),
          title: const Text('Confirm Deletion',
              style: TextStyle(color: Colors.red)),
          content: const Text(
            'Are you sure you want to delete this item?',
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Red background
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ListObat(),
        builder: (BuildContext ctx, AsyncSnapshot<List<Obat>?> snp) {
          switch (snp.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                if (snp.data == null) {
                  return const Center(
                      child: Text("Mohon periksa koneksi internet anda"));
                } else {
                  return _body(snp.data!);
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

  Widget _body(List<Obat> dataObat) {
    int totalStok = dataObat
        .map((x) => x.jumlahStok!)
        .reduce((value, element) => value + element);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const H1('Daftar Obat'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const ManagementCreateObat()))
                  .then((msg) {
                if (msg == "reload pls") {
                  setState(() {});
                }
              });
            },
            child: const Text('Tambah Obat'),
          ),
        ]),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          summaryItem("Jumlah Jenis Obat", "${dataObat.length}"),
          summaryItem("Jumlah Obat", "$totalStok"),
        ]),
        const SizedBox(height: 40),
        const H2('Tabel Data'),
        const SizedBox(height: 10),
        TableStokObat(dataObat)
      ],
    );
  }

  Widget summaryItem(String title, String info) {
    return Expanded(
        child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  Widget TableStokObat(List<Obat> dataObat) {
    var sW = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: List.generate(dataObat.length, (i) {
            return Card(
                margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            width: sW * 0.15,
                            height: sW * 0.25,
                            child: Image.network(
                              dataObat[i].gambar!,
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                H2(dataObat[i].namaObat!),
                                Row(
                                    children: List.generate(
                                        dataObat[i].kategoriObat!.length, (ii) {
                                  return Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Badge(
                                        label: Text(dataObat[i]
                                            .kategoriObat![ii]
                                            .namaKategoriObat!),
                                        backgroundColor: Colors.blue.shade400,
                                      ));
                                })),
                                info("Jumlah Stok",
                                    "${dataObat[i].jumlahStok!}"),
                                info("Bentuk Sediaan",
                                    "${dataObat[i].bentukSediaan!}"),
                                info("Dosis", "${dataObat[i].dosisObat!}"),
                                info(
                                    "Harga", "Rp ${dataObat[i].hargaSediaan!}"),
                                SizedBox(height: 20),
                                Actions(context, i)
                              ],
                            ))
                      ],
                    )));
          }),
        ));
  }

  Widget info(String ttl, String info) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ttl,
          ),
          Text(info,
              softWrap: true,
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold))
        ],
      ),
    ));
  }

  Widget Actions(BuildContext context, int index) {
    return Row(children: [
      ElevatedButton(
        onPressed: () {
          _showDeleteConfirmationDialog(index);
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.red[900])),
        child: Text("Delete", style: TextStyle(color: Colors.red.shade50)),
      ),
      SizedBox(width: 10),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.amber[900])),
        child: Text("Edit", style: TextStyle(color: Colors.black)),
      )
    ]);
  }
}
