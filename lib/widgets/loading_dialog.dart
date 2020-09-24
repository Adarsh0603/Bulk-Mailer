import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String loadingText;

  LoadingDialog(this.loadingText);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text(loadingText),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
