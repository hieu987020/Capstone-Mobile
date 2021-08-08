import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class CategoryRepository {
  final CategoryApi _api = new CategoryApi();

  Future<Category> getCategory(int categoryId) async {
    final String rawBody = await _api.getCategory(categoryId);
    var jsonResponse = json.decode(rawBody);
    return Category.fromJson(jsonResponse);
  }

  Future<List<Category>> getCategories(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async {
    final String rawBody = await _api.getCategories(
        searchValue, searchField, pageNum, fetchNext, statusId);
    var jsonResponse = json.decode(rawBody);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['categories'] as List)
        .map((e) => Category.fromJsonLst(e))
        .toList();
  }

  Future<String> changeStatus(int cateId, int statusId) async {
    Map<String, dynamic> jsonChangeStatus;
    jsonChangeStatus = {
      "categoryId": cateId,
      "statusId": statusId,
    };
    var userCreateJson = jsonEncode(jsonChangeStatus);
    final String response = await _api.changeStatus(userCreateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> updateCategory(Category cate) async {
    var categoryUpdateJson = jsonEncode(cate.toJson());
    final String response = await _api.updateCategory(categoryUpdateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> postCategory(Category cate) async {
    var json = jsonEncode(cate.toJson());
    String response = await _api.postCategory(json);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }
}
