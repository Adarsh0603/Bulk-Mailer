import 'package:bulk_mailer/data/auth.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/screens/create_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Bulk Mailer'),
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
          ),
          ListTile(
            title: Text('Create Mail Sheet'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreateSheet.routeName);
            },
          ),
          ListTile(
            title: Text('Get Sheets'),
            onTap: () async {
//              Navigator.pop(context);
              bool result =
                  await Provider.of<Sheets>(context, listen: false).getSheets();
              if (!result) {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          content: Text('remake'),
                          actions: [
                            FlatButton(
                              child: Text('Create'),
                              onPressed: () async {
                                await Provider.of<Sheets>(context,
                                        listen: false)
                                    .createSpreadsheet(true);
//                                Navigator.of(context).pop();
                                await Provider.of<Sheets>(context,
                                        listen: false)
                                    .getSheets();
                              },
                            )
                          ],
                        ));
              }
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () async {
              Navigator.pop(context);

              await Provider.of<Auth>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
