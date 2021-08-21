import 'dart:developer';
import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StackApi {
  static const String baseUrl = UrlBase.baseUrl;

  Future<String> getStack(String stackId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri =
        "$baseUrl" + "/admin/manager/store/shelf/stack?" + "stackId=$stackId";
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

  Future<String> getStacks(String shelfId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/manager/store/shelf/stacks-by-shelf?" +
        "shelfId=$shelfId";
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
    String uri = "$baseUrl/admin/manager/store/shelf/stack/update-status";
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

  Future<String> changeProduct(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = '$baseUrl/admin/manager/store/shelf/stack/update-product';
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

  Future<String> changeCamera(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = '$baseUrl/admin/manager/store/shelf/stack/update-camera';
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
}
