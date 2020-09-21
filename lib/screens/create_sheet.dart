import 'package:bulk_mailer/data/sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSheet extends StatelessWidget {
  static const routeName = '/create-sheet';
  @override
  Widget build(BuildContext context) {
    final sheets = Provider.of<Sheets>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Email Set'),
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text('Create New Sheet'),
            onPressed: sheets.createSheet,
          ),
        ],
      ),
    );
  }
}
