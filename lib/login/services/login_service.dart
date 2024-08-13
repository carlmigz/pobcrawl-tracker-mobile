import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../api/baseurl_api_class.dart';

class LoginService {
  final String baseUrl;
  final BaseUrlApiClass baseUrlApiClass;

  LoginService(this.baseUrl, this.baseUrlApiClass);

  Future<Map<String, dynamic>> postLogin({
    required String email,
    required String pass,
  }) async {
    const String endpoint = "accounts/login";
    final Uri uri = Uri.parse(baseUrl + endpoint);

    final Map<String, String> headers = await baseUrlApiClass.getHeaders();

    final Map<String, String> body = {
      'emailAddress': email,
      'password': pass,
    };

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 400 ||
        response.statusCode == 500) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Signup Failed: ${response.statusCode}');
    }
  }
}
