import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class HttpRequest<T> {
  HttpRequest();

  Future<T?> jsonRequest(String urlString) async {
    try {
      var response = await Dio().get(urlString, options: Options(sendTimeout: 5000));
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (exception) {
      debugPrint(exception.toString());
    }
    return null;
  }
}