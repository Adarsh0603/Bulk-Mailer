import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/models/usersheet.dart';
import 'package:bulk_mailer/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetItem extends StatelessWidget {
  final UserSheet sheet;

  SheetItem(this.sheet);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => LoadingDialog());
        await Provider.of<Sheets>(context, listen: false)
            .getSheetEmails(sheet.sheetName);
        Navigator.of(context, rootNavigator: true).pop();
        await Provider.of<Sheets>(context, listen: false).sendEmail();
      },
      leading: Icon(Icons.description),
      title: Text(sheet.sheetName),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          await Provider.of<Sheets>(context, listen: false)
              .openSheet(sheet.sheetId);
        },
      ),
    );
  }
}
