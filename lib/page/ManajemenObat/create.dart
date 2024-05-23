import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:flutter/material.dart';

class ManagementCreateObat extends StatefulWidget {
  const ManagementCreateObat({super.key});

  @override
  State<ManagementCreateObat> createState() => _ManagementCreateObatState();
}

class _ManagementCreateObatState extends State<ManagementCreateObat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Sidebar(),
        appBar: TopBar(context, title: "Add an obat"),
        body: Center(
          child: BoxWithMaxWidth(
              maxWidth: 1000,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const H1("User Profile"),
                        Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(children: [
                              const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Nama Obat',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Kategori',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Jumlah',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Deskripsi',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Simpan'),
                              ),
                            ]))
                      ],
                    )),
              )),
        ));
  }
}
