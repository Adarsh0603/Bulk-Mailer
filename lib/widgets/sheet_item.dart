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
            builder: (ctx) => LoadingDialog('Getting Email addresses...'));
        bool result = await Provider.of<Sheets>(context, listen: false)
            .getSheetEmails(sheet.sheetName);
        Navigator.of(context, rootNavigator: true).pop();
        if (result == true)
          await Provider.of<Sheets>(context, listen: false).sendEmail();
        else
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('No Email Addresses'),
              content: Text(
                  '${sheet.sheetName} contains no email addresses.\nAdd email addresses and try again.'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
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
