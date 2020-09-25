import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForceSpreadsheet extends StatefulWidget {
  @override
  _ForceSpreadsheetState createState() => _ForceSpreadsheetState();
}

class _ForceSpreadsheetState extends State<ForceSpreadsheet> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final sheets = Provider.of<Sheets>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _isLoading
                  ? 'Creating Spreadsheet...'
                  : 'Looks like you deleted the \nBulk Mailer spreadsheet \nfrom your Google Drive.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            if (!_isLoading)
              FlatButton(
                child: Text(
                  'Create Again',
                  style: TextStyle(color: Colors.white),
                ),
                color: kPrimaryColor,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await sheets.createSpreadsheet(true);
                },
              )
          ],
        ),
      ),
    );
  }
}
