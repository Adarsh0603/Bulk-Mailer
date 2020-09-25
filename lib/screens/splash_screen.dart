import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/bmlogo.png',
            scale: 4,
          ),
          SizedBox(height: 10),
          Text(
            'Bulk Mailer',
            style: TextStyle(
                color: Colors.black12,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }
}
