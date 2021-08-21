import 'dart:developer';
import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CityApi {
  static const String baseUrl = UrlBase.baseUrl;

  Future<String> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" + "/city/city-district-lst";
    log("API: " + uri);
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
