import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';

enum FileType {
  rive,
  image,
  tile
}

typedef DownloadProgress = void Function(double progress);

class HttpRequest<T> {

  /// CLIENT
  static Dio _dioClient() {
    Dio dio = Dio();
    /// The web only support BrowserHttpClientAdapter and not support DefaultHttpClientAdapter
    if(!kIsWeb) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    return dio;
  }

  static Dio get _dio => _dioClient();

  Future<T?> jsonRequest(String urlString) async {
    try {
      var response = await _dio.get(urlString, options: Options(sendTimeout: 5000));
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (exception) {
      debugPrint(exception.toString());
    }
    return null;
  }

  Future<void> downloadFile(String urlString, String fileName, {
    type = FileType.rive,
    DownloadProgress? onProgress
  }) async {
    // if (await Permission.storage.request().isGranted) {
      String filePath = "";
      switch (type) {
        case FileType.rive:
          filePath = await fileStorage.storagePath("rive") + fileName + ".riv";
          break;
        case FileType.image:
          break;
        case FileType.tile:
          break;
        default:
          filePath = await fileStorage.storagePath("rive") + fileName + ".riv";
          break;
      }
      try {
        await _dio.download(urlString, filePath,
            deleteOnError: true,
            onReceiveProgress: (receivedBytes, totalBytes) {
              if (onProgress != null) {
                onProgress(receivedBytes / totalBytes);
              }
            });
      } catch(exception) {
        debugPrint(exception.toString());
      }
    }
  // }
}