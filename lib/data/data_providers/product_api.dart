import 'dart:developer';
import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductApi {
  static const String baseUrl = UrlBase.baseUrl;
  Future<String> getProduct(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/product?productId=$productId";
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
      throw Exception('Failed to load product');
    }
  }

  Future<String> getProducts(String searchValue, String searchField,
      int pageNum, int fetchNext, int categoryId, int statusId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/products?" +
        "searchValue=$searchValue" +
        "&searchField=$searchField" +
        "&pageNum=$pageNum" +
        "&categoryId=$categoryId" +
        "&fetchNext=$fetchNext" +
        "&statusId=$statusId";
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

  Future<String> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/all-product";
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

  Future<String> changeStatus(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/product/update-status";
    log("API: " + uri);
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: json,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<String> getProductsByProductName(String productName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/products?" +
        "searchValue=$productName" +
        "&searchField=productName" +
        "&pageNum=0" +
        "&fetchNext=0" +
        "&statusId=0";
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

  Future<String> updateProduct(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/product/update";
    log("API: " + uri);
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: json,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<String> postProduct(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('$baseUrl/admin/product/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
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
