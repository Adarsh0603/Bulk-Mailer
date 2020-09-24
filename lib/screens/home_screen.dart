import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/widgets/force_spreadsheet.dart';
import 'package:bulk_mailer/widgets/loading_dialog.dart';
import 'package:bulk_mailer/widgets/nav_drawer.dart';
import 'package:bulk_mailer/widgets/sheet_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    final sheets = Provider.of<Sheets>(context, listen: false);
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Select Mail Sheet'),
          actions: [
            IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => LoadingDialog('Example'));
              },
            )
          ],
        ),
        body: Consumer<Sheets>(
          builder: (ctx, sheets, _) => sheets.gridRefresh
              ? FutureBuilder(
                  future: sheets.getSheets(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return snapshot.data == true
                          ? SheetGrid()
                          : ForceSpreadsheet();
                    return Center(child: CircularProgressIndicator());
                  })
              : SheetGrid(),
        ));
  }
}

class SheetGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Sheets>(
      builder: (BuildContext context, sheets, _) {
        return Container(
          margin: EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1, crossAxisSpacing: 10, crossAxisCount: 2),
            itemCount: sheets.userSheets.length,
            itemBuilder: (ctx, i) => SheetItem(sheets.userSheets[i]),
          ),
        );
      },
    );
  }
}
