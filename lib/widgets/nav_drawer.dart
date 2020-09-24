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
              if (Provider.of<Sheets>(context, listen: false)
                      .userSheets
                      .length !=
                  0) {
                Navigator.pushNamed(context, CreateSheet.routeName);
              } else
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('No Spreadsheet Found')));
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
