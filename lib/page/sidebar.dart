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
        padding: EdgeInsets.all(10),
        child: Drawer(
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.5))),
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
                  title: const Text("Profile"),
                  leading: const Icon(Icons.person_4),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Laporan"),
                  leading: const Icon(Icons.list_alt),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Manajemen Obat Data"),
                  leading: const Icon(Icons.medication),
                  onTap: () {},
                ),
              ],
            )));
  }
}
