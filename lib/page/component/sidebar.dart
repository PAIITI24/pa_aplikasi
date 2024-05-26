import 'package:aplikasi/page/create_user.dart';
import 'package:aplikasi/page/dashboard.dart';
import 'package:aplikasi/page/laporan.dart';
import 'package:aplikasi/page/manajemen_barang.dart';
import 'package:aplikasi/page/manajemen_obat.dart';
import 'package:aplikasi/page/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Drawer(
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ListView(
              children: [
                DrawerHeader(
                    decoration:
                        BoxDecoration(color: Colors.lightGreen.shade100),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: SvgPicture.asset('assets/group.svg'),
                          ),
                          Text(
                            'Inventori Apotek Duma',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen.shade900,
                                fontSize: 18),
                          )
                        ])),
                ListTile(
                  title: const Text("Beranda"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Dashboard()));
                  },
                ),
                ListTile(
                  title: const Text("Profil"),
                  leading: const Icon(Icons.person_4),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ProfileView()));
                  },
                ),
                ListTile(
                  title: const Text("Laporan"),
                  leading: const Icon(Icons.list_alt),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Laporan()));
                  },
                ),
                ListTile(
                  title: const Text("Manajemen Obat"),
                  leading: const Icon(Icons.medication),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ManajemenObat()));
                  },
                ),
                ListTile(
                  title: const Text("Manajemen Barang"),
                  leading: const Icon(Icons.add_box),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ManagementBarang()));
                  },
                ),
                ListTile(
                  title: const Text("Membuat Akun Staff"),
                  leading: const Icon(Icons.person_add),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CreateStaffAccountView()));
                  },
                ),
              ],
            )));
  }
}
