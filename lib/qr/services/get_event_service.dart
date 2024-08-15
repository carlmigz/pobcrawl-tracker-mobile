import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../api/baseurl_api_class.dart';

class GetEventService {
  final String baseUrl;
  final BaseUrlApiClass baseUrlApiClass;

  GetEventService(this.baseUrl, this.baseUrlApiClass);

  Future<Map<String, dynamic>> getEvent({
    required String eventId,
  }) async {
    final Uri uri = Uri.parse('${baseUrl}events/$eventId/list');

    final Map<String, String> headers = await baseUrlApiClass.getHeaders();

    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }
}
