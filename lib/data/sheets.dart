import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Sheets with ChangeNotifier {
  GoogleSignInAccount _user;

  void update(GoogleSignInAccount user) async {
    _user = user;
    notifyListeners();
  }

  Future<void> createSpreadsheet() async {
    const url = 'https://sheets.googleapis.com/v4/spreadsheets';
    var response = await http.post(url,
        body: jsonEncode({
          "properties": {
            "title": "Made With Flutter",
          }
        }),
        headers: await _user.authHeaders);
    print(jsonDecode(response.body));
  }

  Future<void> createSheet() async {
    const url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk:batchUpdate';
    var response = await http.post(url,
        body: jsonEncode({
          "requests": [
            {
              "addSheet": {
                "properties": {
                  "title": "one more",
                  "gridProperties": {"rowCount": 20, "columnCount": 2},
                },
              }
            }
          ]
        }),
        headers: await _user.authHeaders);
    print(jsonDecode(response.body));
  }

  Future<void> openSheet() async {
    var url =
        'https://docs.google.com/spreadsheets/d/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk/edit#gid=1665636340';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> addData() async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk/values/Sheet1!A1:B1?valueInputOption=RAW';

    var response = await http.put(url,
        body: jsonEncode({
          "range": "Sheet1!A1:B1",
          "majorDimension": "ROWS",
          "values": [
            ["Name", "Email"],
          ],
        }),
        headers: await _user.authHeaders);
    print(response.body);
  }

  Future<void> getData() async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk/values/Sheet1!A1:D5';

    var response = await http.get(url, headers: await _user.authHeaders);
    print(jsonDecode(response.body));
  }
}
