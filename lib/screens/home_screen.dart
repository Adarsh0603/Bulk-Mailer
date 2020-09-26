import 'package:bulk_mailer/constants.dart';
import 'package:bulk_mailer/data/sheets.dart';
import 'package:bulk_mailer/screens/create_sheet.dart';
import 'package:bulk_mailer/widgets/force_spreadsheet.dart';
import 'package:bulk_mailer/widgets/nav_drawer.dart';
import 'package:bulk_mailer/widgets/sheets_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = false;

  Future<void> refresh() async {
    Provider.of<Sheets>(context, listen: false).forceRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Select Mail Sheet'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (Provider.of<Sheets>(context, listen: false)
                          .userSheets
                          .length !=
                      0) {
                    Navigator.pushNamed(context, CreateSheet.routeName);
                  } else
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: kPrimaryColor,
                        content: Text(
                          'No Spreadsheet Found',
                          style: kDrawerTextStyle1,
                        )));
                },
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Consumer<Sheets>(
            builder: (ctx, sheets, _) => sheets.gridRefresh
                ? FutureBuilder(
                    future: sheets.getSheets(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data == true) {
                            return SheetGrid();
                          } else {
                            return ForceSpreadsheet();
                          }
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    })
                : SheetGrid(),
          ),
        ));
  }
}
