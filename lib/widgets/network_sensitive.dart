import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final Widget offlineChild;

  NetworkSensitive({this.child, this.offlineChild});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data == ConnectivityResult.none)
            return offlineChild;
          else {
            return child;
          }
        });
  }
}
