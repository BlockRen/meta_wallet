import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_data/model/coin_model.dart';
import 'package:meta_wallet/level_2_data/online_data/trace_fetch.dart';
import 'package:meta_wallet/level_3_business/trace/trace_cell.dart';

class TracePage extends StatefulWidget {
  const TracePage({Key? key}) : super(key: key);

  @override
  State<TracePage> createState() => _TracePageState();
}

class _TracePageState extends State<TracePage> {

  List _coinModels = [];
  final TraceFetch _traceFetch = TraceFetch();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    /// top refresh first in init.
    _traceFetch.doFetchFileData((List? models) {
      if (models == null) {
        _onRefresh();
        return;
      }
      if (mounted) {
        setState(() => _coinModels = models);
      }
    });
  }

  void _onRefresh() {
    _traceFetch.doFetchOnlineData((List? models, bool isOnline) {
      if (models == null) {
        _refreshController.refreshFailed();
        return;
      }
      // avoid call state after page closed. Because the fetch may call back async after page close.
      if (mounted) {
        setState(() => _coinModels = models);
      }
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() {
    _traceFetch.doFetchOnlineData((List? models, bool isOnline) {
      if (models == null) {
        _refreshController.loadNoData();
        return;
      }
      if (mounted) {
        setState(() => _coinModels = models);
      }
      _refreshController.loadComplete();
    }, refreshType: RefreshType.bottomRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trace"),
        ),
        body: SmartRefresher (
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          footer: const ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            shrinkWrap: true,
            itemExtent: MagicValue.cellHeightOfList,
            itemCount: _coinModels.length,
            itemBuilder: (BuildContext context, int index) {
              CoinModel model = _coinModels[index];
              return TraceCell(model, () {
                // router.openPage(context, "transaction", arguments: model);
              });
            },
          ),
        )
    );
  }
}