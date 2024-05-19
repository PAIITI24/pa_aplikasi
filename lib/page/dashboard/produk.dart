import 'package:aplikasi/page/component/titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProdukView extends StatefulWidget {
  const ProdukView({super.key});

  @override
  State<ProdukView> createState() => _ProdukViewState();
}

class _ProdukViewState extends State<ProdukView> {
  @override
  Widget build(BuildContext context) {
    print("Building ProdukView"); // Debugging print statement
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const H1('Data Stok Produk'),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 20),
        const H2('Grafik'),
        const SizedBox(height: 20),
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
        const Divider(),
        const SizedBox(height: 20),
        const H2('Detail Data'),
        const SizedBox(height: 20),
        TableStokProduk()
      ],
    );
  }

  List<PieChartSectionData> showSectionChartOne() {
    return [
      PieChartSectionData(
          color: Colors.green.shade100,
          value: 30,
          title: 'kategori 1\n[30 Produk]',
          radius: 250, // Reduced radius for better rendering
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade200, // Different shades for clarity
          value: 40,
          title: 'kategori 2\n[40 Produk]',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade300,
          value: 20,
          title: 'kategori 3\n[20 Produk]',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      PieChartSectionData(
          color: Colors.green.shade400,
          value: 10,
          title: 'kategori 4\n[10 Produk]',
          radius: 250,
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ];
  }

  Widget TableStokProduk() {
    return DataTable(
      columns: const [
        DataColumn(
            label: Text(
          'Nama Produk',
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
          DataCell(Text('Produk 1')),
          DataCell(Text('100')),
          DataCell(Text('Rp 10.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Produk 2')),
          DataCell(Text('200')),
          DataCell(Text('Rp 20.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Produk 3')),
          DataCell(Text('300')),
          DataCell(Text('Rp 30.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Produk 4')),
          DataCell(Text('400')),
          DataCell(Text('Rp 40.000')),
        ]),
        DataRow(cells: [
          DataCell(Text('Produk 5')),
          DataCell(Text('500')),
          DataCell(Text('Rp 50.000')),
        ]),
      ],
    );
  }
}
