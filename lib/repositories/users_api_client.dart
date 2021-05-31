import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:capstone/models/models.dart';

class UserApiClient {
  static const baseUrl = "http://192.168.1.253:9090";
  final http.Client httpClient;
  UserApiClient({
    this.httpClient,
  }) : assert(httpClient != null);
  Future<Users> fetchUser(String userName) async {
    final response =
        await http.get(Uri.parse('$baseUrl/admin/manager?userName=$userName'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Users.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/admin/managers?searchValue=&searchField=name&pageNum=0&fetchNext=0&statusId=0'));
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = json.decode(response.body);
      return (jsonResponse['managers'] as List)
          .map((e) => Users.fromJson(e))
          .toList();
      //return jsonResponse.map((data) => new Album.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
