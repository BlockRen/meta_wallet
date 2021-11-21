import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:meta_wallet/level_1_core/util/magic_value.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_3_business/trace/trace_fetch.dart';
import 'trace_fetch_test.mocks.dart';

/// flutter packages pub run build_runner build
/// flutter pub run build_runner build
@GenerateMocks([HttpRequest])
@GenerateMocks([FileStorage])
void main() {

  dynamic traceData = fileStorage.readJson("trace_test", folderType: "assets");

  test("Request online", () async {

    final mockHttpRequest = MockHttpRequest();
    when(mockHttpRequest.jsonRequest(any)).thenAnswer((_) => traceData);

    dynamic jsonData = await TraceFetch().requestOnlineData(RefreshType.topRefresh, 0);
    expect(jsonData.length, 2);

    // final mockFileStorage = MockFileStorage();
    ///
    // when(mockFileStorage.requestOnlineData(RefreshType.topRefresh, 0)).thenAnswer((_) => traceData['Data']);

    // expect(mockTraceFetch.doFetchOnlineData(any), matcher);

    // mockTraceFetch.fetchOnlineData((List models, bool isOnline) {
    //   debugPrint("first test");
    //   expect(models.length, 2);
    //   expect(isOnline, true);
    // });
    //
    // mockTraceFetch.fetchOnlineData((List models, bool isOnline) {
    //   expect(models.length, 2);
    //   expect(isOnline, false);
    // });

  }, timeout: const Timeout(Duration(milliseconds: 5000)));

}