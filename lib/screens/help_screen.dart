import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bulk Mailer uses Google Sheets to get email addresses and send bulk mails.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'NOTE:\nThe email addresses needs to be in \'B\' column of the sheet.\nDo not change the position of email column.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Spacer(),
              Text(
                'Install Google Sheets to \nedit the mail sheets in mobile',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              RaisedButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  const url =
                      'https://play.google.com/store/apps/details?id=com.google.android.apps.docs.editors.sheets&hl=en_IN';

                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Image.asset(
                  'images/sheets.png',
                  scale: 5,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
