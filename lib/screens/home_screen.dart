import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    final sheets = Provider.of<Sheets>(context, listen: false);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('BulkMailer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Create New Spreadsheet'),
              onPressed: sheets.createSpreadsheet,
            ),
          ],
        ),
      ),
    );
  }
}
