import 'dart:convert';

import 'package:aplikasi/functions/data/models/user.dart';
import 'package:aplikasi/functions/data/urls.dart';
import 'package:aplikasi/functions/shared/securestorage.dart';
import 'package:http/http.dart' as http;

Future<User?> GetAkuntStaffInfo(int id) async {
  var req = await http.get(Uri.parse("${URLAplikasi.API}/user/details/${id}"),
      headers: {
        'Authorization': await AuthKey.Get(),
        'Content-Type': 'application/json'
      });

  if (req.statusCode == 200) {
    User parsed = User.fromJson(jsonDecode(req.body));
    return parsed;
  } else {
    return null;
  }
}
