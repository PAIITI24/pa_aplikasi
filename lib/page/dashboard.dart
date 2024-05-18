import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:fl_chart/fl_chart.dart';
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
        length: 3,
        child: Scaffold(
          appBar: TopBar(context,
              title: 'Dashboard',
              tabBar: const TabBar(
                tabs: [
                  Tab(text: 'Obat'),
                  Tab(text: 'Produk'),
                  Tab(text: 'Transaksi'),
                ],
              )),
          body: TabBarView(
            children: [
              Container(
                child: PerView(const ObatView()),
              ),
              Container(
                child: PerView(Text('Obat')),
              ),
              Container(
                child: PerView(Text('Obat')),
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

class ObatView extends StatefulWidget {
  const ObatView({super.key});

  @override
  State<ObatView> createState() => _ObatViewState();
}

class _ObatViewState extends State<ObatView> {
  @override
  Widget build(BuildContext context) {
    print("Building ObatView"); // Debugging print statement
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const H1('Data Stok Obat'),
        const SizedBox(height: 50),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              height: 500,
              child: PieChart(PieChartData(
                pieTouchData: PieTouchData(),
                borderData: FlBorderData(show: true),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showSectionChartOne(),
              )));
        }),
        const SizedBox(height: 50),
      ],
    );
  }

  List<PieChartSectionData> showSectionChartOne() {
    return [
      PieChartSectionData(
          color: Colors.green.shade100,
          value: 30,
          title: 'obat 1',
          radius: 250, // Reduced radius for better rendering
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade200, // Different shades for clarity
          value: 40,
          title: 'obat 3',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade300,
          value: 20,
          title: 'obat 2',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade400,
          value: 10,
          title: 'obat 5',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ];
  }
}
