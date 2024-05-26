import 'dart:convert';
import 'package:aplikasi/functions/data/models/login_res.dart';
import 'package:aplikasi/functions/data/urls.dart';
import 'package:aplikasi/functions/shared/securestorage.dart';
import 'package:http/http.dart' as http;

Future<bool> Login(String email, String password) async {
  final url = Uri.parse('${URLAplikasi.API}/auth/login');
  final response = await http.post(
    url,
    body: jsonEncode({'email': email, 'password': password}),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final loginRes = LoginRes.fromJson(jsonDecode(response.body));
    // store the data
    await AuthKey.Set(loginRes.token!);
    await OtherKeys.Set("role", loginRes.user!.role.toString());

    return true;
  } else {
    print("${response.statusCode} - ${response.body}");
    return false;
  }
}
