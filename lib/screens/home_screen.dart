import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BulkMailer'),
      ),
      body: Center(child: Text('Starting now....')),
    );
  }
}
