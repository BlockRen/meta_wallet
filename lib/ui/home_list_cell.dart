import 'package:flutter/material.dart';
import 'package:meta_wallet/util/app_icons.dart';
import 'package:meta_wallet/model/transaction_model.dart';

class HomeListCell extends StatelessWidget {
  const HomeListCell(this.model, {Key? key}) : super(key: key);

  final TransactionModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max, // not required
        crossAxisAlignment: CrossAxisAlignment.center, // not required
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: model.dealType == "sent" ?
            const Icon(AppIcons.sent, color: Colors.orange, size: 20) :
            const Icon(AppIcons.received, color: Colors.green, size: 20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.amount.toString() + "  " + model.tokenName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              Text(
                model.dealType,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                ),
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
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                Text(
                  model.shortAddress,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}