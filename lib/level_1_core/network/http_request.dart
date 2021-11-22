import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class HttpRequest<T> {
  final Dio _dio = Dio();

  HttpRequest() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
      client.badCertificateCallback=(cert, host, port){
        return true;
      };
    };
  }

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
}