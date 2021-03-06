import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/auth.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/screens/create_sheet.dart';
import 'package:bulk_mailer/screens/help_screen.dart';
import 'package:bulk_mailer/screens/home_screen.dart';
import 'package:bulk_mailer/screens/no_network_screen.dart';
import 'package:bulk_mailer/screens/splash_screen.dart';
import 'package:bulk_mailer/screens/wrapper.dart';
import 'package:bulk_mailer/widgets/network_sensitive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BulkMailer());
}

class BulkMailer extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Sheets>(
          create: (BuildContext context) => Sheets(),
          update: (_, auth, sheets) => sheets..update(auth.googleUser),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bulk Mailer',
        theme:
            ThemeData(primaryColor: kPrimaryColor, accentColor: kPrimaryColor),
        home: NetworkSensitive(
          offlineChild: NoNetwork(),
          child: FutureBuilder(
            future: _initialization,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : Wrapper(),
          ),
        ),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          CreateSheet.routeName: (ctx) => CreateSheet(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
        },
      ),
    );
  }
}
