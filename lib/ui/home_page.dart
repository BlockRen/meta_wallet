import 'package:flutter/material.dart';
import 'package:meta_wallet/ui/home_list_cell.dart';
import 'package:meta_wallet/network/http_request.dart';
import 'package:meta_wallet/model/transaction_model.dart';
import 'package:meta_wallet/util/event_bus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _transactions = [];
  bool _isDark = false;

  Future<void> _loadTransactionInfo() async {
    HttpRequest request = HttpRequest();
    List transactions = await request.doRequest("http://www.aaronview.cn/other/demo_list_data.json");
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _transactions = transactions;
    });
  }

  void _changeMainTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTransactionInfo();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Navigation',
          onPressed: () => debugPrint('Navigation button is pressed'),
        ),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isDark ? Icons.brightness_5 : Icons.brightness_4),
            tooltip: 'Theme',
            onPressed: () {
              bus.emit(bThemeChange);
              _changeMainTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            tooltip: 'More',
            onPressed: () => debugPrint('More button is pressed'),
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.builder(
          shrinkWrap: true,
          itemExtent: 70,
          itemCount: _transactions.length,
          itemBuilder: (BuildContext context, int index) {
            TransactionModel model = TransactionModel(_transactions[index]);
            return HomeListCell(model);
          },
        ),
      ),
    );
  }
}