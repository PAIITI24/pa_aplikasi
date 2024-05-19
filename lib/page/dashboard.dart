import 'package:aplikasi/page/component/topbar.dart';
import 'package:aplikasi/page/dashboard/obat.dart';
import 'package:aplikasi/page/dashboard/produk.dart';
import 'package:aplikasi/page/sidebar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const Sidebar(),
          appBar: TopBar(context,
              title: 'Dashboard',
              tabBar: const TabBar(
                tabs: [
                  Tab(text: 'Obat'),
                  Tab(text: 'Produk'),
                ],
              )),
          body: TabBarView(
            children: [
              Container(
                child: PerView(const ObatView()),
              ),
              Container(
                child: PerView(const ProdukView()),
              ),
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
