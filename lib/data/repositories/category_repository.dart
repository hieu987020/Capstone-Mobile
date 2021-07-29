import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class CategoryRepository {
  final CategoryApi _api = new CategoryApi();

  Future<Category> getCategory(String categoryId) async {
    final String rawBody = await _api.getCategory(categoryId);
    var jsonResponse = json.decode(rawBody);
    return Category.fromJson(jsonResponse);
  }

  Future<List<Category>> getCategories(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async {
    final String rawBody = await _api.getCategories(
        searchValue, searchField, pageNum, fetchNext, statusId);
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['categories'] as List)
        .map((e) => Category.fromJsonLst(e))
        .toList();
  }

  Future<String> postCategory(Category user) async {
    var json = jsonEncode(user.toJson());
    String response = await _api.postCategory(json);
    if (response.contains('true') == true &&
        response.contains('errorCodeAndMsg') == false) {
      return 'true';
    } else {
      return response;
    }
  }
}
