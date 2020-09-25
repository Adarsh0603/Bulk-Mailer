import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/auth.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/screens/create_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final googleUser = Provider.of<Auth>(context, listen: false).googleUser;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
                      child: GoogleUserCircleAvatar(
                        identity: googleUser,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            googleUser.displayName,
                            style: kDrawerTextStyle1,
                          ),
                          Text(
                            googleUser.email,
                            style: kDrawerTextStyle1.copyWith(
                                color: Colors.white70),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Spacer(),
                Text('Bulk Mailer', style: kAppTitleStyle),
              ],
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
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
