import 'dart:convert';

import 'package:bulk_mailer/models/usersheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Sheets with ChangeNotifier {
  GoogleSignInAccount _user;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  String _spreadsheetId = '';

  List<UserSheet> _userSheets = [];
  List<UserSheet> get userSheets => _userSheets;

  bool _gridRefresh = true;
  bool get gridRefresh => _gridRefresh;

  List<String> _emailList = [];
  List<String> get emailList => _emailList;

  ///PROVIDER FUNCTIONS
  void update(GoogleSignInAccount user) async {
    _user = user;
    notifyListeners();
    await userUpdateOperations();
  }

  Future<void> userUpdateOperations() async {
    if (_user != null) {
      await createSpreadsheet();
    }
    if (_user == null) {
      _userSheets = [];
      _spreadsheetId = '';
      notifyListeners();
    }
  }

  //*********************************SHEET API CALLS**********************

  ///CREATES A NEW SPREADSHEET(BULK MAILER)
  Future<void> createSpreadsheet([bool forceCreate = false]) async {
    const url = 'https://sheets.googleapis.com/v4/spreadsheets';
    var userExists = await checkNewUserInFirebase();
    if (userExists && !forceCreate) return;
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
    var sheetResponse = jsonDecode(response.body);
    print('New Spreadsheet created with id: ${sheetResponse['spreadsheetId']}');
    await _users
        .doc(_user.id)
        .set({'isInit': true, 'spreadsheetId': sheetResponse['spreadsheetId']});
    await addInitialData(UserSheet(0, 'Default'));
    _gridRefresh = true;
    notifyListeners();
  }

  ///CREATES NEW SHEET WITH NAME ENTERED BY USER
  Future<bool> createSheet(String title) async {
    await getSpreadsheetId();
    String url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId:batchUpdate';
    var response = await http.post(url,
        body: jsonEncode({
          "requests": [
            {
              "addSheet": {
                "properties": {
                  "title": title,
                  "gridProperties": {"rowCount": 500},
                },
              }
            }
          ]
        }),
        headers: await _user.authHeaders);
    var newSheetMetaData = await jsonDecode(response.body) as Map;
    print(newSheetMetaData);
    if (newSheetMetaData.containsKey('error')) {
      return false;
    }
    var sheetId = await newSheetMetaData['replies'][0]['addSheet']['properties']
        ['sheetId'];
    await addInitialData(UserSheet(sheetId, title));
    _gridRefresh = true;
    notifyListeners();
    return true;
  }

  ///OPENS SELECTED SHEET FOR EDITING
  Future<void> openSheet(int sheetId) async {
    var url =
        'https://docs.google.com/spreadsheets/d/$_spreadsheetId/edit#gid=$sheetId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///FOR EDITING INITIAL SHEET DATA(EG.HEADER)
  Future<void> addInitialData(UserSheet sheet) async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/${sheet.sheetName}!A1:B1?valueInputOption=RAW';

    await http.put(url,
        body: jsonEncode({
          "range": "${sheet.sheetName}!A1:B1",
          "majorDimension": "ROWS",
          "values": [
            ["Name", "Email"],
          ],
        }),
        headers: await _user.authHeaders);

    url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId:batchUpdate';
    await http.post(url,
        body: jsonEncode({
          "requests": [
            {
              "updateSheetProperties": {
                "properties": {
                  "sheetId": sheet.sheetId,
                  "gridProperties": {"frozenRowCount": 1}
                },
                "fields": "gridProperties.frozenRowCount"
              }
            },
            {
              "addProtectedRange": {
                "protectedRange": {
                  "range": {
                    "sheetId": sheet.sheetId,
                    "startRowIndex": 0,
                    "endRowIndex": 1,
                    "startColumnIndex": 1,
                    "endColumnIndex": 2,
                  },
                  "description":
                      "The Email Addresses needs to be in the B Column.",
                  "warningOnly": true,
                }
              }
            }
          ]
        }),
        headers: await _user.authHeaders);
  }

  ///TO FETCH EMAILS FROM SELECTED SHEET
  Future<bool> getSheetEmails(String sheetName) async {
    var url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/$sheetName!B2:B';
    var response = await http.get(url, headers: await _user.authHeaders);
    var responseData = jsonDecode(response.body)['values'] as List;
    if (responseData == null) {
      return false;
    }
    List<String> fetchedEmailList = [];

    responseData.forEach((e) {
      if (e.length != 0) {
        if (e[0].toString().contains('@'))
          fetchedEmailList.add(e[0].toString());
      }
    });
    _emailList = fetchedEmailList;
    print(_emailList);
    notifyListeners();

    return true;
  }

  ///GET ALL USER SHEETS FROM BULK MAILER
  Future<bool> getSheets() async {
    await getSpreadsheetId();
    String url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId';
    var response = await http.get(url, headers: await _user.authHeaders);
    var responseData = await jsonDecode(response.body) as Map;
    print(responseData);
    if (responseData.containsKey('error')) {
      return false;
    }
    var sheetsResponse = await responseData['sheets'] as List;
    print(sheetsResponse);
    List<UserSheet> sheetList = [];
    sheetsResponse.forEach((sheet) {
      sheetList.add(UserSheet(
          sheet['properties']['sheetId'], sheet['properties']['title']));
    });
    _userSheets = sheetList;
    _gridRefresh = false;
    notifyListeners();
    return true;
  }

  ///MAILING
  Future<void> sendEmail() async {
    final Email email = Email(
      body: '',
      subject: 'Email subject',
      recipients: _emailList,
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  //*******************************FIREBASE**************************

  /// RETURNS TRUE IF USER ALREADY EXISTS IN FIREBASE DATABASE ON RE-SIGN-IN
  Future<bool> checkNewUserInFirebase() async {
    var response = await _users.doc(_user.id).get();
    var userData = response.data();
    if (userData == null) {
      return false;
    }
    if (userData.containsKey('isInit')) {
      return userData['isInit'] == true ? true : false;
    }
    return false;
  }

  ///FETCH SPREADSHEET-ID FROM FIREBASE
  Future<void> getSpreadsheetId() async {
    final userDataResponse = await _users.doc(_user.id).get();
    final userData = userDataResponse.data();
    _spreadsheetId = userData['spreadsheetId'];
  }

  ///REFRESH SHEETS GRID AND RUNS getSheets FUNCTION.
  void forceRefresh() {
    _gridRefresh = true;
    notifyListeners();
  }
}
