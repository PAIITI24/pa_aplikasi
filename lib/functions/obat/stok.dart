import 'package:aplikasi/functions/data/models/obat.dart';
import 'package:aplikasi/functions/data/urls.dart';
import 'package:aplikasi/functions/shared/securestorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> tambahStokObat(
    int obatId, int quantity, DateTime TanggalExpired) async {
  var url = Uri.parse("${URLAplikasi.API}/obat/stok/add");

  try {
    var paylaod = jsonEncode(StokObatAddReq(
        obatId: obatId, amount: quantity, expiredDate: TanggalExpired));
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

Future<int> kurangiStokObat(int obatId, int stokMasukId, int quantity) async {
  var url = Uri.parse("${URLAplikasi.API}/obat/stok/reduce");
  try {
    var payload = jsonEncode(StokObatRedReq(
        obatId: obatId, amount: quantity, stokMasukId: stokMasukId));
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await AuthKey().Get(),
      },
      body: payload,
    );

    /**
     * {
        'obatId': obatId,
        'quantity': quantity.toString(),
      }
     */

    /**
     * 1 = OK
     * 2 = Error
     * 3 = Error : what requested > available
     */

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

Future<List<StokMasukObat>?> fetchLaporanMasukStokObatPerId(int id) async {
  try {
    var fetchData = await http.get(
        Uri.parse("${URLAplikasi.API}/obat/stok/add/history/${id}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': await AuthKey().Get()
        });

    if (fetchData.statusCode == 200) {
      List<dynamic> data = jsonDecode(fetchData.body);
      List<StokMasukObat> compiledData =
          data.map((x) => StokMasukObat.fromJson(x)).toList();

      return compiledData;
    } else {
      return null;
    }
  } catch (e) {
    print("Exception $e");
    return null;
  }
}

Future<List<StokKeluarObat>?> fetchLaporanKeluarStokObatPerId(int id) async {
  try {
    var fetchData = await http.get(
      Uri.parse("${URLAplikasi.API}/obat/stok/reduce/history/${id}"),
      headers: {
        'Accept': 'application/json',
        'Authorization': await AuthKey().Get()
      },
    );

    if (fetchData.statusCode == 200) {
      List<dynamic> data = jsonDecode(fetchData.body);
      return data.map((x) => StokKeluarObat.fromJson(x)).toList();
    } else {
      print("Error: ${fetchData.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
