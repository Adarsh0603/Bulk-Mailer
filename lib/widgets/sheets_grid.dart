import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/widgets/sheet_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Sheets>(
      builder: (BuildContext context, sheets, _) {
        return Container(
          margin: EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2),
            itemCount: sheets.userSheets.length,
            itemBuilder: (ctx, i) => SheetItem(sheets.userSheets[i]),
          ),
        );
      },
    );
  }
}
