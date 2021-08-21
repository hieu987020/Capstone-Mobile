import 'dart:developer';
import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShelfApi {
  static const String baseUrl = UrlBase.baseUrl;

  Future<String> getShelf(String shelfId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri =
        "$baseUrl" + "/admin/manager/store/shelf?" + "shelfId=$shelfId";
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

  Future<String> getShelves(String storeId, String shelfName, int statusId,
      int pageNum, int fetchNext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/manager/store/shelves?" +
        "storeId=$storeId" +
        "&shelfName=$shelfName" +
        "&statusId=$statusId" +
        "&pageNum=$pageNum" +
        "&fetchNext=$fetchNext";
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

  Future<String> getShelvesByStoreId(String storeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/manager/store/shelves-by-storeid?" +
        "storeId=$storeId";
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
    String uri = "$baseUrl/admin/manager/store/shelf/update-status";
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

  Future<String> changeCamera(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = '$baseUrl/admin/manager/store/shelf/change-shelf-camera';
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

  Future<String> updateShelf(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/manager/store/shelf/update";
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

  Future<String> postShelf(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = '$baseUrl/admin/manager/store/shelf/create';
    log("API: " + uri);
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: json,
    );
    log("response");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
