import 'dart:convert';
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
    http.Response response;
    switch (method) {
      case "post":
        response = await http.post(
          Uri.parse('${ApiService.baseUrl}/$url'),
          headers: headers,
          body: jsonEncode(body),
        );
        break;
      case "get":
        response = await http.get(
          Uri.parse('${ApiService.baseUrl}/$url'),
          headers: headers,
        );
        break;
      default:
        response = await http.get(
          Uri.parse('${ApiService.baseUrl}/$url'),
          headers: headers,
        );
    }
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
