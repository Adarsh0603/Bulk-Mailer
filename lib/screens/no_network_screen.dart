import 'package:flutter/material.dart';

class NoNetwork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bulk Mailer'),
      ),
      body: Center(
        child: Text('No Internet Connection'),
      ),
    );
  }
}
