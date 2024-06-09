import 'package:aplikasi/functions/data/models/barang.dart';
import 'package:aplikasi/functions/data/models/obat.dart';
import 'package:aplikasi/functions/data/urls.dart';
import 'package:aplikasi/functions/shared/securestorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> tambahStokBarang(
    int barangId, int quantity, DateTime TanggalExpired) async {
  var url = Uri.parse("${URLAplikasi.API}/barang/stok/add");

  try {
    /**
       final int? barangID;
      final int? amount;
      final DateTime? expiredDate;
     */
    var paylaod = jsonEncode(StokBarangAddReq(
        barangID: barangId, amount: quantity, expiredDate: TanggalExpired));
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await AuthKey().Get(),
      },
      body: paylaod,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}

Future<int> kurangiStokBarang(
    int barangId, int stokMasukId, int quantity) async {
  var url = Uri.parse("${URLAplikasi.API}/barang/stok/reduce");
  try {
    var payload = jsonEncode(StokBarangRedReq(
        barangId: barangId, amount: quantity, stokMasukId: stokMasukId));
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await AuthKey().Get(),
      },
      body: payload,
    );

    if (response.statusCode == 200) {
      return 1;
    } else if (response.statusCode == 400) {
      return 3;
    } else {
      return 2;
    }
  } catch (_) {
    return 2;
  }
}

Future<List<StokMasukBarang>?> fetchLaporanMasukStokBarangPerId(int id) async {
  try {
    var fetchData = await http.get(
        Uri.parse("${URLAplikasi.API}/barang/stok/add/history/${id}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': await AuthKey().Get()
        });

    if (fetchData.statusCode == 200) {
      List<dynamic> data = jsonDecode(fetchData.body);
      List<StokMasukBarang> compiledData =
          data.map((x) => StokMasukBarang.fromJson(x)).toList();

      return compiledData;
    } else {
      return null;
    }
  } catch (e) {
    print("Exception $e");
    return null;
  }
}

Future<List<StokKeluarBarang>?> fetchLaporanKeluarStokBarangPerId(
    int id) async {
  try {
    var fetchData = await http.get(
      Uri.parse("${URLAplikasi.API}/barang/stok/reduce/history/${id}"),
      headers: {
        'Accept': 'application/json',
        'Authorization': await AuthKey().Get()
      },
    );

    if (fetchData.statusCode == 200) {
      List<dynamic> data = jsonDecode(fetchData.body);
      return data.map((x) => StokKeluarBarang.fromJson(x)).toList();
    } else {
      print("Error: ${fetchData.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
