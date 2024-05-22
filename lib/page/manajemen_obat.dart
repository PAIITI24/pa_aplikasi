import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:aplikasi/page/laporan/obat.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:flutter/material.dart';

class ManajemenObat extends StatefulWidget {
  const ManajemenObat({super.key});

  @override
  State<ManajemenObat> createState() => _ManajemenObatState();
}

class _ManajemenObatState extends State<ManajemenObat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: TopBar(
        context,
        title: 'Manajemen',
      ),
      body: const BoxWithMaxWidth(
        child: ObatView(),
        maxWidth: 1000,
      ),
    );
  }

  Widget PerView(Widget child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: child,
      ),
    );
  }
}
