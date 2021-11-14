import 'dart:convert';
import 'dart:io';

class HttpRequest {
  late HttpClient httpClient;

  HttpRequest() {
    httpClient = HttpClient();
  }

  Future<List> doRequest(String urlString) async {
    List list = [];
    try {
      Uri uri = Uri.parse(urlString);
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        String jsonString = await response.transform(utf8.decoder).join();
        list = jsonDecode(jsonString);
      } else {
      }
    } catch (exception) {
      //print(exception);
    }
    return list;
  }
}