import 'package:capstone/data/data_providers/const_common.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static const String baseUrl = UrlBase.baseUrl;
  Future<String> login(String json) async {
    String uri = "$baseUrl/login";

    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
