import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/models/usersheet.dart';
import 'package:bulk_mailer/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetItem extends StatelessWidget {
  final UserSheet sheet;

  SheetItem(this.sheet);

  void onSelect(BuildContext context) async {
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
          title: Text('No Recipients found'),
          content: Text(
              '"${sheet.sheetName}" contains no recipients.\nAdd recipients and try again.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () => onSelect(context),
            child: Icon(
              Icons.description,
              color: kPrimaryColor,
              size: 60,
            ),
          )),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(child: Text(sheet.sheetName)),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: kPrimaryColor,
                  ),
                  onPressed: () async {
                    await Provider.of<Sheets>(context, listen: false)
                        .openSheet(sheet.sheetId);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
