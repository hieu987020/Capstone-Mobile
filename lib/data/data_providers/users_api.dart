import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  static const String baseUrl = UrlBase.baseUrl;
  Future<String> getUser(String userName) async {
    final response =
        await http.get(Uri.parse('$baseUrl/admin/manager?userName=$userName'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<String> getUsers() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/admin/managers?searchValue=&searchField=userName&pageNum=0&fetchNext=0&statusId=0'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<String> getUsersActive() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/admin/managers?searchValue=&searchField=userName&pageNum=0&fetchNext=0&statusId=1'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<String> getUsersPending() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/admin/managers?searchValue=&searchField=userName&pageNum=0&fetchNext=0&statusId=3'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<String> getUsersInactive() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/admin/managers?searchValue=&searchField=userName&pageNum=0&fetchNext=0&statusId=2'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
