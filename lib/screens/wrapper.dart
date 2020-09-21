import 'package:bulk_mailer/data/auth.dart';
import 'package:bulk_mailer/screens/auth_screen.dart';
import 'package:bulk_mailer/screens/home_screen.dart';
import 'package:bulk_mailer/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final auth = Provider.of<Auth>(context, listen: false);
    auth.autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return AuthScreen();
          }
          return HomeScreen();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
