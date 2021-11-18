import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_ui/component/home_list_cell.dart';
import 'package:meta_wallet/level_2_ui/model/transaction_model.dart';

class TracePage extends StatefulWidget {
  const TracePage({Key? key}) : super(key: key);

  @override
  State<TracePage> createState() => _TracePageState();
}

class _TracePageState extends State<TracePage> {

  final List _tempMarketListData = [];

  Future<void> _pullData(int pageIndex) async {
    String urlString = MagicValue.marketDataInfoUrl + "&limit=100" + "&page=" + pageIndex.toString();
    var response = await http.get(Uri.parse(urlString), headers: {"Accept": "application/json"});
    List rawMarketListData = const JsonDecoder().convert(response.body)["Data"];
    _tempMarketListData.addAll(rawMarketListData);
  }

  @override
  void initState() {
    super.initState();

    _pullData(1);
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
          itemCount: _tempMarketListData.length,
          itemBuilder: (BuildContext context, int index) {
            TransactionModel model = TransactionModel(_tempMarketListData[index]);
            return HomeListCell(model, () {
              // router.openPage(context, "transaction", arguments: model);
            });
          },
        ),
    );
  }

}