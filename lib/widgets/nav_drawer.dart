import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/auth.dart';
import 'package:bulk_mailer/screens/help_screen.dart';
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Bulk Mailer', style: kAppTitleStyle),
                    Text(
                      'v1.0',
                      style: kDrawerTextStyle1.copyWith(color: Colors.white54),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  'Google Account',
                  style: kDrawerTextStyle1,
                ),
                Divider(color: Colors.white),
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
                            style: kDrawerTextStyleFaded,
                          ),
                          Text(
                            googleUser.email,
                            style: kDrawerTextStyle1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help'),
            onTap: () async {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(HelpScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
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
