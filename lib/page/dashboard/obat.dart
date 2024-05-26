import 'package:aplikasi/page/component/titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 20),
        const H2('Grafik'),
        const SizedBox(height: 20),
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
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
        const Divider(),
        const SizedBox(height: 20),
        const H2('Detail Data'),
        const SizedBox(height: 20),
        TableStokObat()
      ],
    );
  }

  List<PieChartSectionData> showSectionChartOne() {
    return [
      PieChartSectionData(
          color: Colors.green.shade100,
          value: 30,
          title: 'kategori 1\n[30 obat]',
          radius: 250, // Reduced radius for better rendering
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade200, // Different shades for clarity
          value: 40,
          title: 'kategori 2\n[40 obat]',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade300,
          value: 20,
          title: 'kategori 3\n[20 obat]',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade400,
          value: 10,
          title: 'kategori 4\n[10 obat]',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ];
  }

  Widget TableStokObat() {
    return DataTable(
      columns: const [
        DataColumn(
            label: Text(
          'Nama Obat',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
        DataColumn(
            label: Text(
          'Stok',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
        DataColumn(
            label: Text(
          'Harga',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('Obat 1')),
          DataCell(Text('100')),
          DataCell(Text('Rp 10.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 2')),
          DataCell(Text('200')),
          DataCell(Text('Rp 20.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 3')),
          DataCell(Text('300')),
          DataCell(Text('Rp 30.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 4')),
          DataCell(Text('400')),
          DataCell(Text('Rp 40.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Obat 5')),
          DataCell(Text('500')),
          DataCell(Text('Rp 50.000')),
        ]),
      ],
    );
  }
}
