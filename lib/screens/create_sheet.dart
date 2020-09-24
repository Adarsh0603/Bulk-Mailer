import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSheet extends StatefulWidget {
  static const routeName = '/create-sheet';

  @override
  _CreateSheetState createState() => _CreateSheetState();
}

class _CreateSheetState extends State<CreateSheet> {
  String sheetName = 'newSheet';

  Future<void> createNewSheet(BuildContext ctx) async {
    final sheets = Provider.of<Sheets>(context, listen: false);

    FocusScope.of(context).unfocus();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => LoadingDialog('Creating Sheet...'));

    bool result = await sheets.createSheet(sheetName);
    Navigator.of(context, rootNavigator: true).pop();
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
          result
              ? '$sheetName created successfully'
              : 'Sheet with this name already exists',
          style: kSnackBarTextStyle),
    ));
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
            Builder(
              builder: (BuildContext context) => RaisedButton(
                child: Text('Create New Sheet'),
                onPressed: () async {
                  await createNewSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
