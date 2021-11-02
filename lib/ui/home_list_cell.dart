import 'package:flutter/material.dart';
import 'package:meta_wallet/util/app_icons.dart';
import 'package:meta_wallet/model/transaction_model.dart';

class HomeListCell extends StatelessWidget {
  const HomeListCell(this.model, {Key? key}) : super(key: key);

  final TransactionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration( // 用Decoration设置圆角
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColorDark,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max, // not required
          crossAxisAlignment: CrossAxisAlignment.center, // not required
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: model.dealType == "sent" ?
              Icon(AppIcons.sent, color: Theme.of(context).primaryTextTheme.headline1!.color, size: 15) :
              Icon(AppIcons.received, color: Theme.of(context).primaryTextTheme.headline1!.color, size: 15),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.amount.toString() + "  " + model.tokenName,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                Text(
                  model.dealType,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ],
            ),
            Expanded(
              child: Container(
                // color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    model.timeString,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                  Text(
                    model.shortAddress,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}