import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:aplikasi/page/create_user.dart';
import 'package:flutter/material.dart';

class ManajemenAkunStaff extends StatefulWidget {
  const ManajemenAkunStaff({super.key});

  @override
  State<ManajemenAkunStaff> createState() => _ManajemenAkunStaffState();
}

class _ManajemenAkunStaffState extends State<ManajemenAkunStaff> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const Sidebar(),
          appBar: TopBar(context,
              title: 'Manajemen Obat',
              tabBar: const TabBar(
                tabs: [
                  Tab(text: 'Daftar Akun Staff'),
                  Tab(text: 'Tambah Akun Staff'),
                ],
              )),
          body: const TabBarView(
            children: [
              BoxWithMaxWidth(maxWidth: 1000, child: Center(child: Text("Placeholder"),)),
              BoxWithMaxWidth(
                  maxWidth: 1000,
                  child: BuatAkunStaffView())
            ],
          ),
        ));
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
