import 'package:flutter/material.dart';
import 'package:meta_wallet/ui/component/home_list_cell.dart';
import 'package:meta_wallet/network/http_request.dart';
import 'package:meta_wallet/model/transaction_model.dart';
import 'package:meta_wallet/util/event_bus.dart';

/// 1.有状态的页面，存在State object，含状态参数；
/// 2.调用了setState，则build会重新执行，否则不会；
/// 3.build在每次setState之后都会调用，但不用太担心性能问题，flutter在这块处理很高效；

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

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