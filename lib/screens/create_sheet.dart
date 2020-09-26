import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/screens/no_network_screen.dart';
import 'package:bulk_mailer/widgets/loading_dialog.dart';
import 'package:bulk_mailer/widgets/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSheet extends StatefulWidget {
  static const routeName = '/create-sheet';

  @override
  _CreateSheetState createState() => _CreateSheetState();
}

class _CreateSheetState extends State<CreateSheet> {
  String sheetName = '';

  Future<void> createNewSheet(BuildContext ctx) async {
    final sheets = Provider.of<Sheets>(context, listen: false);

    if (sheetName.trim().length == 0) {
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text('Please enter sheet name!', style: kSnackBarTextStyle),
      ));
      return;
    }
    FocusScope.of(context).unfocus();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => LoadingDialog('Creating Sheet...'));

    bool result = await sheets.createSheet(sheetName);

    if (result) {
      sheets.forceRefresh();
      Navigator.of(context).pop();
    }
    Navigator.of(context, rootNavigator: true).pop();
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text('Sheet with this name already exists',
          style: kSnackBarTextStyle),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      offlineChild: NoNetwork(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Mail Sheet'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.done),
                onPressed: () async {
                  await createNewSheet(context);
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: kSheetNameInputDecoration,
                onChanged: (value) {
                  setState(() {
                    sheetName = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
