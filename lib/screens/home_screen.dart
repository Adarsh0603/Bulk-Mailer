import 'package:bulk_mailer/data/sheets.dart';
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
  Future _initSheets;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final sheets = Provider.of<Sheets>(context, listen: false);
    _initSheets = Future.delayed(Duration.zero).then((_) async {
//      await sheets.getSheets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Select Mail Sheet'),
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () {
              showDialog(
                  context: context, builder: (ctx) => LoadingDialog('Example'));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _initSheets,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Consumer<Sheets>(
                    builder: (BuildContext context, sheets, _) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2),
                          itemCount: sheets.userSheets.length,
                          itemBuilder: (ctx, i) =>
                              SheetItem(sheets.userSheets[i]),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
