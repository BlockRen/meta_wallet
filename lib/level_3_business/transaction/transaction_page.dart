import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_1_core/util/event_bus.dart';
import 'package:meta_wallet/level_2_data/component/base_sheet.dart';
import 'package:meta_wallet/level_2_data/online_data/transaction_fetch.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';
import 'package:meta_wallet/level_3_business/transaction/receive_sheet.dart';
import 'package:meta_wallet/level_3_business/transaction/send_sheet.dart';
import 'package:meta_wallet/level_3_business/transaction/transaction_cell.dart';

/// 1.有状态的页面，存在State object，含状态参数；
/// 2.调用了setState，则build会重新执行，否则不会；
/// 3.build在每次setState之后都会调用，但不用太担心性能问题，flutter在这块处理很高效；

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _HomePageState();
}

class _HomePageState extends State<TransactionPage> {
  List _transactions = [];

  @override
  void initState() {
    super.initState();
    TransactionFetch().loadTransactionInfo((List transactions) {
      setState(() {
        _transactions = transactions;
      });
    });
  }

  Widget iconButton(String text, IconData icon, VoidCallback callback) {
    return MaterialButton(
      textColor: Theme.of(context).primaryTextTheme.bodyText1?.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
      onPressed: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   tooltip: 'Navigation',
        //   onPressed: () => router.openPage(context, 'trace'),
        // ),
        title: const Text("Transactions"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(_isDark ? Icons.brightness_5 : Icons.brightness_4),
        //     tooltip: 'Theme',
        //     onPressed: () {
        //       eventBus.emit(gThemeChange);
        //       _changeMainTheme();
        //     },
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.perm_identity),
        //     tooltip: 'Identity',
        //     onPressed: () => router.openPage(context, 'avatar'),
        //   )
        // ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemExtent: MagicValue.cellHeightOfList,
              itemCount: _transactions.length,
              itemBuilder: (BuildContext context, int index) {
                /// Open the detail page
                return TransactionCell(_transactions[index], () {
                  router.openPage(context, "transaction_detail", arguments: _transactions[index]);
                });
              },
            ),
            Align(
              child: Container(
                height: MagicValue.bottomTabBarHeight,
                color: Theme.of(context).bottomAppBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconButton("Receive", Icons.qr_code, () {
                      SheetBase.showAppSheet(
                          context: context,
                          widget: const ReceiveSheet(

                          ),
                          color: Theme.of(context).backgroundColor,
                          onDisposed: () {});
                    }),
                    iconButton("Send", Icons.send, () {
                      SheetBase.showAppSheet(
                          context: context,
                          widget: SendSheet("safdsaf", "118"),
                          color: Theme.of(context).backgroundColor,
                          onDisposed: () {});
                    })
                  ],
                ),
              ),
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      ),
    );
  }
}