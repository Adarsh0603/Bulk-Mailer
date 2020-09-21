import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Sheets with ChangeNotifier {
  GoogleSignInAccount _user;

  void update(GoogleSignInAccount user) async {
    _user = user;
    notifyListeners();
  }

  Future<void> createSheet() async {
    const url = 'https://sheets.googleapis.com/v4/spreadsheets';
    var response = await http.post(url,
        body: jsonEncode({
          'properties': {'title': 'Made with Flutter App'}
        }),
        headers: await _user.authHeaders);
    print(jsonDecode(response.body));
  }
}
