import 'package:bulk_mailer/data/auth.dart';
import 'package:bulk_mailer/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Sign in With Google'),
          onPressed: () async {
            await Provider.of<Auth>(context, listen: false).signInWithGoogle();
          },
        ),
      ),
    );
  }
}
