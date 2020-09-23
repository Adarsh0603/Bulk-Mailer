import 'dart:convert';

import 'package:bulk_mailer/models/usersheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Sheets with ChangeNotifier {
  GoogleSignInAccount _user;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List<UserSheet> _userSheets = [];

  List<UserSheet> get userSheets => _userSheets;

  void update(GoogleSignInAccount user) async {
    _user = user;
    notifyListeners();
  }

  Future<bool> checkNewUserInFirebase() async {

    var response = await _fireStore.collection('users').doc(_user.id).get();
    var userData = response.data();
    if (userData == null) {
      return false;
    }
    if (userData.containsKey('isInit')) {
      return userData['isInit'] == true ? true : false;
    }
    return false;
  }

  Future<void> createSpreadsheet() async {
    const url = 'https://sheets.googleapis.com/v4/spreadsheets';
    var userExists = await checkNewUserInFirebase();
    if (userExists) return;
    var response = await http.post(url,
        body: jsonEncode({
          "properties": {
            "title": "Bulk Mailer",
          },
          "sheets": [
            {
              "properties": {"sheetId": 0, "title": 'Default'}
            }
          ],
        }),
        headers: await _user.authHeaders);
    print(jsonDecode(response.body));
    _fireStore.collection('users').doc(_user.id).set({'isInit': true});
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
                  "title": "mailSheet1",
                  "gridProperties": {"rowCount": 500, "columnCount": 2},
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
        'https://docs.google.com/spreadsheets/d/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk/edit#gid=193003849';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> addData() async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk/values/mailSheet1!A1:B1?valueInputOption=RAW';

    var response = await http.put(url,
        body: jsonEncode({
          "range": "mailSheet1!A1:B1",
          "majorDimension": "ROWS",
          "values": [
            ["Name", "Email"],
          ],
        }),
        headers: await _user.authHeaders);

    print(response.body);
    url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk:batchUpdate';
    response = await http.post(url,
        body: jsonEncode({
          "requests": [
            {
              "updateSheetProperties": {
                "properties": {
                  "sheetId": 193003849,
                  "gridProperties": {"frozenRowCount": 1}
                },
                "fields": "gridProperties.frozenRowCount"
              }
            }
          ]
        }),
        headers: await _user.authHeaders);
  }

  Future<void> getData() async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk/values/mailSheet1!B:B';
    var response = await http.get(url, headers: await _user.authHeaders);
    print(jsonDecode(response.body));
  }

  Future<void> getSheets() async {
    const url =
        'https://sheets.googleapis.com/v4/spreadsheets/1jEGeCbNjCq5BeHAGLucmLErbhlbnA30A0TD8qNfJnrk';
    var response = await http.get(url, headers: await _user.authHeaders);
    var sheetsResponse = await jsonDecode(response.body)['sheets'] as List;
    print(sheetsResponse);
    List<UserSheet> sheetList = [];
    sheetsResponse.forEach((sheet) {
      sheetList.add(UserSheet(
          sheet['properties']['sheetId'], sheet['properties']['title']));
    });
    _userSheets = sheetList;
    notifyListeners();
  }
}
