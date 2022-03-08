import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiService {
  static String baseUrl = 'http://back-system.wenze-rdc.com';

  ///
  ///@param url: add url to endpoint
  ///@param method[post, get]
  ///@param body[Map<String, dynamic> body] to pass from endpoint
  ///@param headers[http Headers]
  ///
  static Future request(
      {String url, String method, Map<String, dynamic> body, headers}) async {
    var client = http.Client();
    http.Response response;
    switch (method) {
      case "post":
        response = await client.post(
          Uri.parse('${ApiService.baseUrl}/$url'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Connection": "Keep-Alive",
          },
          body: jsonEncode(body),
        );
        break;
      case "get":
        response = await client.get(
          Uri.parse('${ApiService.baseUrl}/$url'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Connection": "Keep-Alive",
          },
        );
        break;
      default:
        response = await client.get(
          Uri.parse('${ApiService.baseUrl}/$url'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Connection": "Keep-Alive",
          },
        );
    }
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
