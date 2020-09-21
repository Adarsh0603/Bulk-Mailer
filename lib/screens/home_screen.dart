import 'package:bulk_mailer/data/sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sheets = Provider.of<Sheets>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('BulkMailer'),
      ),
      body: Center(
          child: RaisedButton(
        child: Text('Create New Spreadsheet'),
        onPressed: sheets.createSheet,
      )),
    );
  }
}
