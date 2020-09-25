import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bulk Mailer',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false)
                    .signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
