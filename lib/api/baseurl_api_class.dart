class BaseUrlApiClass {
  String baseUrl = "https://tracker-api.pobcrawl.com/api/v1/";

  Future<Map<String, String>> getHeaders({String? token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
