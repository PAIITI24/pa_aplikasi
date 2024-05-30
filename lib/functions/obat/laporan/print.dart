import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget PDFTemplateObat() {
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
      // Add the table here
      pw.Table.fromTextArray(
        headers: ['Item ', 'Jumlah', 'Tanggal Masuk', 'Tanggal Keluar'],
        data: [
          ['Paracetamol', '20', '01-08-2023', '05-08-2023'],
          ['Ibuprofen', '50', '02-08-2023', '10-08-2023'],
          ['Aspirin', '30', '03-08-2023', '12-08-2023'],
          ['Amoxicillin', '10', '04-08-2023', '15-08-2023'],
          ['Paracetamol', '20', '01-08-2023', '05-08-2023'],
          ['Ibuprofen', '50', '02-08-2023', '10-08-2023'],
          ['Aspirin', '30', '03-08-2023', '12-08-2023'],
          ['Amoxicillin', '10', '04-08-2023', '15-08-2023'],
          ['Paracetamol', '20', '01-08-2023', '05-08-2023'],
          ['Ibuprofen', '50', '02-08-2023', '10-08-2023'],
          ['Aspirin', '30', '03-08-2023', '12-08-2023'],
          ['Amoxicillin', '10', '04-08-2023', '15-08-2023'],
          ['Paracetamol', '20', '01-08-2023', '05-08-2023'],
          ['Ibuprofen', '50', '02-08-2023', '10-08-2023'],
          ['Aspirin', '30', '03-08-2023', '12-08-2023'],
        ],
        headerStyle: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        cellStyle: pw.TextStyle(fontSize: 10),
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
          color: PdfColors.grey300,
        ),
        border: const pw.TableBorder(
          horizontalInside: pw.BorderSide(width: 0.5, color: PdfColors.grey),
        ),
        cellHeight: 20,
      ),
    ],
  );
}

Future<void> printReport(BuildContext context) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [PDFTemplateObat()];
      },
    ),
  );

  final directory = await getDownloadsDirectory();
  final storedDirectory = await FilesystemPicker.open(
      context: context,
      rootDirectory: directory!,
      title: 'Select where to save',
      fsType: FilesystemType.folder,
      pickText: 'Simpan dokumen disini sebagai laporan_dokumen.pdf');

  if (storedDirectory != null) {
    final file = File("${storedDirectory}/laporan_dokumen.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}

pw.Widget summaryItem(String title, String info) {
  return pw.Expanded(
    child: pw.Padding(
      padding: const pw.EdgeInsets.all(20),
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
