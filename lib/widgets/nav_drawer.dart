import 'package:bulk_mailer/screens/create_sheet.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
