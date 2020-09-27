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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bulk Mailer uses Google Sheets to get email addresses and send bulk mails.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Mail Sheets are stored in Bulk Mailer Spreadsheet in Google Drive of the signed in user.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'You can delete, edit or rename the sheets directly from Google Sheets.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Newly created sheets can take some time to load in Google Sheets. Wait for few seconds before opening new sheets for editing.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'You can also edit the mail sheets on PC.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'The bulk mail limit depends on your mail service provider\'s limit.',
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () async {
                  const url =
                      'https://support.google.com/a/answer/166852?hl=en';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  'Gmail Limits',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'NOTE:\nThe email addresses needs to be in \'B\' column of the sheet.\nDo not change the position of email column.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  'Use Desktop mode in browser \nor install Google Sheets to \nedit the mail sheets in mobile',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: RaisedButton(
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
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
