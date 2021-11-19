import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_ui/component/trace_cell.dart';
import 'package:meta_wallet/level_2_ui/model/coin_model.dart';
import 'package:meta_wallet/level_3_business/Trace/trace_fetch.dart';

class TracePage extends StatefulWidget {
  const TracePage({Key? key}) : super(key: key);

  @override
  State<TracePage> createState() => _TracePageState();
}

class _TracePageState extends State<TracePage> {

  List coinModels = [];

  @override
  void initState() {
    super.initState();
    //
    TraceFetch().fetchData((List models) {
      setState(() {
        coinModels = models;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trace"),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemExtent: MagicValue.cellHeightOfList,
          itemCount: coinModels.length,
          itemBuilder: (BuildContext context, int index) {
            CoinModel model = coinModels[index];
            return TraceCell(model, () {
              // router.openPage(context, "transaction", arguments: model);
            });
          },
        ),
    );
  }

}