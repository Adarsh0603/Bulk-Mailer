import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSheet extends StatefulWidget {
  static const routeName = '/create-sheet';

  @override
  _CreateSheetState createState() => _CreateSheetState();
}

class _CreateSheetState extends State<CreateSheet> {
  String sheetName = 'newSheet';

  void createNewSheet() async {
    final sheets = Provider.of<Sheets>(context, listen: false);

    await sheets.createSheet(sheetName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Email Set'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: kSheetNameInputDecoration,
              onChanged: (value) {
                setState(() {
                  sheetName = value;
                });
              },
            ),
            RaisedButton(
              child: Text('Create New Sheet'),
              onPressed: createNewSheet,
            ),
          ],
        ),
      ),
    );
  }
}
