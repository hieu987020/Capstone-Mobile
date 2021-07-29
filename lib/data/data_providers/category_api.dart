import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryApi {
  static const String baseUrl = UrlBase.baseUrl;
  Future<String> getCategory(String category) async {
    final response =
        await http.get(Uri.parse('$baseUrl/admin/?userName=$category'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<String> getCategories(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/categories?" +
        "searchValue=$searchValue" +
        "&searchField=$searchField" +
        "&pageNum=$pageNum" +
        "&fetchNext=$fetchNext" +
        "&statusId=$statusId";

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

  Future<String> postCategory(String json) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/category/create'),
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
