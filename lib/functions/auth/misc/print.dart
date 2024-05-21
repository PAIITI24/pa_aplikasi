import 'dart:io';
import 'dart:ui';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget PDFTemplate() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      pw.Text('Laporan Obat per Agustus'),
      pw.SizedBox(height: 10),
      pw.Text('Selayang Pandang', style: const pw.TextStyle(fontSize: 18)),
      pw.SizedBox(height: 10),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
        children: [
          summaryItem("Sisa Obat", "45"),
          summaryItem("Jumlah Obat Masuk", "100"),
          summaryItem("Jumlah Obat Keluar", "12"),
        ],
      ),
      pw.SizedBox(height: 40),
      pw.Text('Tabel Data', style: const pw.TextStyle(fontSize: 18)),
      pw.SizedBox(height: 10),
    ],
  );
}

Future<void> printReport(BuildContext context) async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(build: (pw.Context context) {
    return PDFTemplate();
  }));

  final directory = await getApplicationDocumentsDirectory();
  final storedDirectory = await FilesystemPicker.open(
      context: context,
      rootDirectory: directory,
      title: 'Select where to save',
      fsType: FilesystemType.folder,
      pickText: 'Pick where the folder');

  if (storedDirectory != null) {
    final file = File("$storedDirectory/laporan_dokumen.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}

pw.Widget summaryItem(String title, String info) {
  return pw.Expanded(
    child: pw.Padding(
      padding: pw.EdgeInsets.all(20),
      child: pw.Column(
        children: [
          pw.Text(title,
              style: const pw.TextStyle(fontSize: 18),
              textAlign: pw.TextAlign.center),
          pw.Text(info,
              style:
                  pw.TextStyle(fontSize: 48, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    ),
  );
}
