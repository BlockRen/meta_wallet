import 'dart:io';
import 'dart:math' as math;
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_ui/model/coin_model.dart';

class TraceFetch {
  TraceFetch();

  // original data format
  List marketListData = [];
  // coin model format
  List marketCoinList = [];

  // return the coin model list
  List get coinList => marketCoinList;

  static const int updateScope = 60000; // one minute

  static int lastUpdateTime = DateTime.now().millisecondsSinceEpoch - updateScope;

  // fetch one page list
  Future<void> _fetchData(int pageIndex) async {
    String urlString = MagicValue.marketDataInfoUrl + "&limit=100" + "&page=" + pageIndex.toString();
    var response = await HttpRequest().jsonRequest(urlString);
    List rawMarketListData = [];
    if (response['Response'] != 'Error') {
      rawMarketListData = response['Data'];
    }
    marketListData.addAll(rawMarketListData);
  }

  Future<void> _batchFetchData() async {
    int pages = 1;
    // batch fetch
    List<Future> futures = [];
    for (int i = 0; i < pages; i++) {
      futures.add(_fetchData(i));
    }
    await Future.wait(futures);
  }

  /// batch fetch 5 pages market list and convert to coin-model list
  /// 存入本地文件，短时间内从本地读取，每隔n分钟再请求一次
  Future<void> fetchData(Function onLoadFinish) async {
    marketListData = [];
    marketCoinList = [];
    bool fileExist = await fileStorage.exists(gStoreTrace);
    if (fileExist &&
        (lastUpdateTime - DateTime.now().millisecondsSinceEpoch).abs() < updateScope) {
      List jsonObject = await fileStorage.readJson(gStoreTrace) as List;
      marketListData.addAll(jsonObject);
    } else {
      await _batchFetchData();
      /// save to local file.
      fileStorage.writeJson(marketListData, gStoreTrace);
      // reset time
      lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
    }

    // Filter out lack of financial data
    for (Map coin in marketListData) {
      if (!coin.containsKey("CoinInfo") || !coin.containsKey("DISPLAY")) {
        continue;
      }
      CoinModel coinModel = CoinModel(coin);
      marketCoinList.add(coinModel);
    }
    onLoadFinish(marketCoinList);
  }
}