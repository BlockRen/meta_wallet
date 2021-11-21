import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_2_ui/model/transaction_model.dart';

class TransactionFetch {
  TransactionFetch();

  // update the data after one minute
  static const int _updateScope = 60000;
  // record the last update time
  static int _lastUpdateTime = DateTime.now().millisecondsSinceEpoch - _updateScope;

  Future<void> loadTransactionInfo(Function onLoadFinish) async {
    // Json data
    List _transactionData = [];
    // model
    List _transactionModels = [];

    bool fileExist = await fileStorage.exists(gStoreTransaction);
    if (fileExist &&
        (_lastUpdateTime - DateTime.now().millisecondsSinceEpoch).abs() < _updateScope) {
      List jsonObject = await fileStorage.readJson(gStoreTransaction) as List;
      _transactionData.addAll(jsonObject);
    } else {
      _transactionData = await HttpRequest().jsonRequest(MagicValue.transactionInfoUrl) ?? [];
      /// save to local file.
      fileStorage.writeJson(_transactionData, gStoreTransaction);
      // reset time
      _lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
    }

    // Filter out lack of financial data
    for (Map data in _transactionData) {
      TransactionModel model = TransactionModel(data);
      _transactionModels.add(model);
    }
    onLoadFinish(_transactionModels);
  }
}