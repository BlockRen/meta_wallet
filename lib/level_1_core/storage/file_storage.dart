import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  // Singleton
  FileStorage._internal();
  static final FileStorage _singleton = FileStorage._internal();

  Directory? _directory;

  // Factory Construct
  factory FileStorage() =>_singleton;

  Future<File> _getJsonFile(String fileName, String folderType) async {
    switch (folderType) {
      case "doc":
        _directory ??= await getApplicationSupportDirectory();
        break;
      default:
        _directory = Directory("assets");
    }
    File jsonFile = File(_directory!.path + "/" + fileName + ".json");
    return jsonFile;
  }

  Future<bool> writeJson(Object jsonData, String fileName, {String folderType = "doc"}) async {
    try {
      File jsonFile = await _getJsonFile(fileName, folderType);
      jsonFile.writeAsStringSync(json.encode(jsonData));
    } on Exception catch (_, e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<Object?> readJson(String fileName, {String folderType = "doc"}) async {
    try {
      File jsonFile = await _getJsonFile(fileName, folderType);
      String jsonString = jsonFile.readAsStringSync();
      Object jsonObject = jsonDecode(jsonString);
      return jsonObject;
    } on Exception catch (_, e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> exists(String fileName, {String folderType = "doc"}) async {
    File jsonFile = await _getJsonFile(fileName, folderType);
    return await jsonFile.exists();
  }
}

var fileStorage = FileStorage();

// File Name
const String gStoreTransaction = "store_transaction";
const String gStoreTrace = "store_trace";