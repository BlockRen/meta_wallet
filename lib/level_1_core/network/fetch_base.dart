import 'package:flutter/foundation.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';

/// Base logic for fetch.
/// First, the fetchData function need to return the local file data,
/// Second, do an online request to update the data and save to local file,
/// Third, if last online request is less then a minute, then do not do second step.
abstract class FetchBase {
  FetchBase();

  // the fetched data
  Object? dataFetched;

  // indicate the last loaded data page index
  int _pageIndex = 0;
  // update the data after several seconds to avoid frequently refresh.
  static const int _updateScope = 3000;
  // record the last update time
  static int _lastUpdateTime = DateTime.now().millisecondsSinceEpoch - _updateScope;

  /// read local file and return the file data. Usually used for top refresh.
  /// no need to override in a general way.
  Future<Object?> fetchFileData(String fileName) async {
    dataFetched = null;
    bool fileExist = await fileStorage.exists(fileName);
    if (fileExist) {
      dataFetched = await fileStorage.readJson(fileName);
    }
    return dataFetched;
  }

  /// Save to local file.
  /// No need to override in a general way.
  Future<void> saveOnlineData(String fileName, Object data) async {
    fileStorage.writeJson(data, fileName);
  }

  /// Fetch online data.
  /// This method should be override. It will be called automatically in 'fetchData'.
  /// You only need to consider the request implement, no need to consider the page index logic.
  Future<Object?> requestOnlineData(RefreshType refreshType, int pageIndex);

  /// Fetch the data from online.
  /// This method could be override or call it directly.
  /// You only need to consider the super callback data processing.
  /// onLoadFinish(data, isOnline), the second param is a bool to indicate online.
  @mustCallSuper
  Future<void> fetchOnlineData(Function onLoadFinish, {
    required String fileName,
    RefreshType refreshType = RefreshType.topRefresh,
    bool shouldSaveData = true
  }) async {
    /// load data from online when the time scope more then '_updateScope'.
    /// and update data to local file.
    if ((_lastUpdateTime - DateTime.now().millisecondsSinceEpoch).abs() < _updateScope &&
        refreshType == RefreshType.topRefresh) {
      /// load file data first.
      Object? fileData = await fetchFileData(fileName);
      if (fileData != null) {
        onLoadFinish(fileData, false);
        return;
      }
    }
    int pageIndex = 0;
    if (refreshType == RefreshType.topRefresh) {
      pageIndex = 0;
    } else if (refreshType == RefreshType.bottomRefresh) {
      pageIndex = _pageIndex + 1;
    }
    Object? onlineData = await requestOnlineData(refreshType, pageIndex);
    if (onlineData != null) {
      _pageIndex = pageIndex;
    }
    /// reset time
    _lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
    /// call back the data
    onLoadFinish(onlineData, true);
    /// only need to save top refresh online data
    if (shouldSaveData && refreshType == RefreshType.topRefresh && onlineData != null) {
      saveOnlineData(fileName, onlineData);
    }
  }
}