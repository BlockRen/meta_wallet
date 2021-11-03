import 'package:flutter/material.dart';
import 'package:meta_wallet/model/transaction_model.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionModel model = ModalRoute.of(context)!.settings.arguments as TransactionModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration( // 用Decoration设置圆角
          border: Border.all(color: Theme.of(context).highlightColor, width: 0.5),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(color: Color(0x66000000),
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
              spreadRadius: 1.0),
            BoxShadow(color: Color(0x11000000),
              offset: Offset(-2.0, 0.0),
              blurRadius: 2.0,
              spreadRadius: 1.0),
          ],
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.dealType == "sent" ? "接收者" : "发送者"),
                  Text(model.address),
                ],
              ),
            ),
            Divider(height: 10.0, thickness: 0.8, indent: 10.0, color: Theme.of(context).dividerColor),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Token"),
                  Text(model.amount.toString() + "  " + model.tokenName),
                ],
              ),
            ),
            Divider(height: 10.0, thickness: 0.8, indent: 10.0, color: Theme.of(context).dividerColor),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("网络费用"),
                  Text("0"),
                ],
              ),
            ),
            Divider(height: 10.0, thickness: 0.8, indent: 10.0, color: Theme.of(context).dividerColor),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("时间"),
                  Text(model.timeString),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}