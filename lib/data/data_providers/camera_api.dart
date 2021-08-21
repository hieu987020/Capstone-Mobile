import 'dart:developer';
import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CameraApi {
  static const String baseUrl = UrlBase.baseUrl;
  Future<String> getCamera(String cameraId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    String uri = "$baseUrl/admin/camera?cameraId=$cameraId";
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
      throw Exception('Failed to load camera');
    }
  }

  Future<String> getCameras(String storeId, String cameraName, int statusId,
      int pageNum, int fetchNext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/cameras?" +
        "storeId=$storeId" +
        "&cameraName=$cameraName" +
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

  Future<String> getAvailableCameras(
      String cameraName, int pageNum, int fetchNext, int typeDetect) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl" +
        "/admin/available-camera-lst?" +
        "cameraName=$cameraName" +
        "&pageNum=$pageNum" +
        "&fetchNext=$fetchNext" +
        "&typeDetect=$typeDetect";
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
    String uri = "$baseUrl/admin/camera/update-status";
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

  Future<String> updateCamera(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/camera/update";
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

  Future<String> postCamera(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uri = "$baseUrl/admin/camera/create";
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
