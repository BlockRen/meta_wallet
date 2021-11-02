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
        children: <Widget>[
          Icon(AppIcons.received, color: Theme.of(context).textTheme.bodyText1?.color, size: 20),
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
          const Text(
            "address",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}