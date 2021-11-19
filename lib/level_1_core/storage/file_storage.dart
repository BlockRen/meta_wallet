import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  // Singleton
  FileStorage._internal();
  static final FileStorage _singleton = FileStorage._internal();

  Directory? _docDirectory;

  // Factory Construct
  factory FileStorage() =>_singleton;

  Future<File> _getJsonFile(String fileName) async {
    _docDirectory ??= await getApplicationDocumentsDirectory();
    File jsonFile = File(_docDirectory!.path + "/" + fileName + ".json");
    return jsonFile;
  }

  Future<bool> writeJson(Object jsonData, String fileName) async {
    try {
      File jsonFile = await _getJsonFile(fileName);
      jsonFile.writeAsStringSync(json.encode(jsonData));
    } on Exception catch (_, e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<Object?> readJson(String fileName) async {
    try {
      File jsonFile = await _getJsonFile(fileName);
      String jsonString = jsonFile.readAsStringSync();
      Object jsonObject = jsonDecode(jsonString);
      return jsonObject;
    } on Exception catch (_, e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> exists(String fileName) async {
    File jsonFile = await _getJsonFile(fileName);
    return await jsonFile.exists();
  }
}

var fileStorage = FileStorage();

// File Name
String gStoreTrace = "store_trace";