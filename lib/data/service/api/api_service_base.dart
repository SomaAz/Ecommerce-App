import 'package:http/http.dart' as http;

class ApiService {
  static const _headers = {"Accept": "application/json"};
  static const apiBaseUrl = "host:8012/";

  ApiService._();

  static Future<http.Response> get(
    String route,
  ) async {
    return await http.get(
      Uri.parse("$apiBaseUrl/$route"),
      headers: _headers,
    );
  }

  static Future<http.Response> post(
    String route, {
    Map? body,
  }) async {
    return await http.post(
      Uri.parse("$apiBaseUrl/$route"),
      body: body,
      headers: _headers,
    );
  }
}
