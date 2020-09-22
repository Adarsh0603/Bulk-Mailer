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
            title: Text('Create New Email Set'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CreateSheet.routeName);
            },
          ),
          ListTile(
            title: Text('Open Sheet'),
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<Sheets>(context, listen: false).openSheet();
            },
          ),
          ListTile(
            title: Text('Add Data'),
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<Sheets>(context, listen: false).addData();
            },
          ),
          ListTile(
            title: Text('Get Data'),
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<Sheets>(context, listen: false).getData();
            },
          ),
          ListTile(
            title: Text('Get Sheets'),
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<Sheets>(context, listen: false).getSheets();
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
