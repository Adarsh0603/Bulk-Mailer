import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/models/usersheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetItem extends StatelessWidget {
  final UserSheet sheet;

  SheetItem(this.sheet);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await Provider.of<Sheets>(context, listen: false)
            .openSheet(sheet.sheetId);
      },
      leading: Icon(Icons.description),
      title: Text(sheet.sheetName),
    );
  }
}
