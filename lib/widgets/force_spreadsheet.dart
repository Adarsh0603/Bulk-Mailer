import 'package:bulk_mailer/data/sheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForceSpreadsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sheets = Provider.of<Sheets>(context, listen: false);
    return Center(
      child: Column(
        children: [
          FlatButton(
            child: Text('Create'),
            onPressed: () async {
              await sheets.createSpreadsheet(true);
            },
          )
        ],
      ),
    );
  }
}
