import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForceSpreadsheet extends StatelessWidget {
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
              'Looks like you deleted the \nBulk Mailer spreadsheet \nfrom your Google Drive.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            FlatButton(
              child: Text(
                'Create Again',
                style: TextStyle(color: Colors.white),
              ),
              color: kPrimaryColor,
              onPressed: () async {
                await sheets.createSpreadsheet(true);
              },
            )
          ],
        ),
      ),
    );
  }
}
