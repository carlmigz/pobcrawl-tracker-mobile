import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../api/baseurl_api_class.dart';

class SignupService {
  final String baseUrl;
  final BaseUrlApiClass baseUrlApiClass;

  SignupService(this.baseUrl, this.baseUrlApiClass);

  Future<Map<String, dynamic>> postSignup(
      {required String firstName,
      required String lastName,
      required String email,
      required String pass,
      required String mobile,
      required String sex}) async {
    const String endpoint = "accounts/register";
    final Uri uri = Uri.parse(baseUrl + endpoint);

    final Map<String, String> headers = await baseUrlApiClass.getHeaders();

    final Map<String, String> body = {
      "firstName": firstName,
      "lastName": lastName,
      'emailAddress': email,
      'password': pass,
      'confirmPassword': pass,
      'phoneNo': mobile,
      'sex': sex
    };

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Signup Failed: ${response.body}');
    }
  }
}
