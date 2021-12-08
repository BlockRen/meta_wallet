import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_data/model/coin_model.dart';

class TraceCell extends StatelessWidget {
  const TraceCell(this.model, this.onTapFunction, {Key? key}) : super(key: key);

  final CoinModel model;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration( // 用Decoration设置圆角
            borderRadius: BorderRadius.circular(MagicValue.cardBorderRadius),
            color: Theme.of(context).primaryColorDark,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max, // not required
            crossAxisAlignment: CrossAxisAlignment.center, // not required
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image(
                  image: NetworkImage(model.icon),
                  width: 25,
                  height: 25,
                )
              ),
              Container(
                width: 80,
                padding: const EdgeInsets.only(left: 0, right: 20),
                child: Text(
                  model.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.hourVolume,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                  Text(
                    model.dayVolume,
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
                      model.price,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                    Text(
                      model.dayChange,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          onTapFunction();
        },
      ),
    );
  }
}