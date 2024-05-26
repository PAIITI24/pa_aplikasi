import "dart:convert";

import "package:aplikasi/functions/data/urls.dart";
import "package:aplikasi/functions/shared/securestorage.dart";
import "package:http/http.dart" as http;

Future<bool> CreateKategoriObat(String nama_kategori) async {
  try {
    var req = await http.post(Uri.parse("${URLAplikasi.API}/obat/kategori/"),
        headers: {
          'Authorization': await AuthKey.GetAuthKey(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode({"nama_kategori_obat": nama_kategori}));

    if (req.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
