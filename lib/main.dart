import 'package:bulk_mailer/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BulkMailer());
}

class BulkMailer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BulkMailer',
      home: HomeScreen(),
    );
  }
}
