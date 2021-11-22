import 'package:meta_wallet/level_1_core/network/fetch_base.dart';
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_ui/model/transaction_model.dart';

class TransactionFetch extends FetchBase {
  TransactionFetch();

  @override
  Future<Object> requestOnlineData(RefreshType refreshType, int pageIndex) async {
    List transactionData = await HttpRequest().jsonRequest(MagicValue.transactionInfoUrl) ?? [];
    return transactionData;
  }

  /// covert online data to model.
  List _convertData(Object? onlineData) {
    if (onlineData == null) {
      return [];
    }
    // model
    List transactionModels = [];
    List iterableOnlineData = onlineData as List;
    // Filter out lack of financial data
    for (Map data in iterableOnlineData) {
      TransactionModel model = TransactionModel(data);
      transactionModels.add(model);
    }
    return transactionModels;
  }

  Future<void> loadTransactionInfo(Function onLoadFinish) async {
    /// first show list with local file data to accelerate the show.
    Object? data = await fetchFileData(gStoreTransaction);
    if (data != null) {
      onLoadFinish(_convertData(data));
    }
    /// call super method to fetch data online.
    fetchOnlineData((Object? data, bool isOnline) {
      onLoadFinish(_convertData(data));
    }, fileName: gStoreTransaction);
  }
}