import 'package:http/http.dart' as http;

class HTTP {
  static String get baseUrl => "https://dummyjson.com";

  static Future<http.Response> get(String endpoint) async {
    String url = "$baseUrl/$endpoint";
    final response = await http.get(Uri.parse(url));
    return response;
  }
}
