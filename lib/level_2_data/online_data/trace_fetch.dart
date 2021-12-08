import 'package:meta_wallet/level_1_core/network/fetch_base.dart';
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_data/model/coin_model.dart';

class TraceFetch extends FetchBase {
  TraceFetch();

  // coin model format
  List marketCoinList = [];

  @override
  Future<Object?> requestOnlineData(RefreshType refreshType, int pageIndex) async {
    ///
    String urlString = MagicValue.marketDataInfoUrl + "&limit=50" + "&page=" + pageIndex.toString();
    dynamic response = await HttpRequest().jsonRequest(urlString);
    if (response == null) {
      return null;
    }
    List rawMarketListData = [];
    if (response['Response'] != 'Error') {
      rawMarketListData = response['Data'];
    }
    return rawMarketListData;
  }

  /// Filter the original data and convert to models
  List _convertData(Object data) {
    List jsonData = data as List;
    for (Map coin in jsonData) {
      if (!coin.containsKey("CoinInfo") || !coin.containsKey("DISPLAY")) {
        continue;
      }
      CoinModel coinModel = CoinModel(coin);
      marketCoinList.add(coinModel);
    }
    return marketCoinList;
  }

  /// this can be used for quick show list when the page open.
  Future<void> doFetchFileData(Function onLoadFinish, {String? fileName}) async {
    Object? data = await fetchFileData(fileName ?? gStoreTrace);
    if (data == null) {
      onLoadFinish(null);
      return;
    }
    marketCoinList= [];
    marketCoinList = _convertData(data);
    /// Get the return value with callback
    onLoadFinish(marketCoinList);
  }

  /// Fetch market list and convert to coin-model list.
  /// This method will read file in one minute rather then online.
  Future<void> doFetchOnlineData(Function onLoadFinish, {
    String? fileName,
    RefreshType refreshType = RefreshType.topRefresh
  }) async {
    /// call super
    fetchOnlineData((Object? data, bool isOnline) {
      /// The data can be null.
      if (data == null) {
        onLoadFinish(null, isOnline);
        return;
      }
      /// Clear the list if refresh type is top refresh
      if (refreshType == RefreshType.topRefresh) {
        marketCoinList = [];
      }
      marketCoinList = _convertData(data);
      onLoadFinish(marketCoinList, isOnline);
    }, fileName: (fileName ?? gStoreTrace), refreshType: refreshType);
  }
}