import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class ProductRepository {
  final ProductApi _api = new ProductApi();

  Future<Product> getProduct(String productId) async {
    final String rawBody = await _api.getProduct(productId);
    var jsonResponse = json.decode(rawBody);
    return Product.fromJson(jsonResponse);
  }

  Future<List<Product>> getProducts(String searchValue, String searchField,
      int pageNum, int fetchNext, int categoryId, int statusId) async {
    final String rawBody = await _api.getProducts(
        searchValue, searchField, pageNum, fetchNext, categoryId, statusId);
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['products'] as List)
        .map((e) => Product.fromJsonLst(e))
        .toList();
  }

  Future<List<Product>> getAll() async {
    final String rawBody = await _api.getAll();
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse['products'] as List)
        .map((e) => Product.fromJsonLst(e))
        .toList();
  }

  Future<List<Product>> getProductsByProductName(String productName) async {
    final String rawBody = await _api.getProductsByProductName(productName);
    var jsonResponse = json.decode(rawBody);
    if (jsonResponse
        .toString()
        .contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['products'] as List)
        .map((e) => Product.fromJsonLst(e))
        .toList();
  }

  Future<String> changeStatus(
      String productId, int statusId, String reasonInactive) async {
    Map<String, dynamic> jsonChangeStatus;
    if (reasonInactive == null) {
      jsonChangeStatus = {
        "productId": productId,
        "statusId": statusId,
      };
    } else {
      jsonChangeStatus = {
        "productId": productId,
        "statusId": statusId,
        "reasonInactive": reasonInactive,
      };
    }
    var userCreateJson = jsonEncode(jsonChangeStatus);
    final String response = await _api.changeStatus(userCreateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> updateProduct(Product product) async {
    var productUpdateJson = jsonEncode(product.toJson());
    final String response = await _api.updateProduct(productUpdateJson);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }

  Future<String> postProduct(Product product) async {
    Map<String, dynamic> productCreate = {
      "imageUrl": product.imageUrl,
      "description": product.description,
      "categories": [5],
      "productName": product.productName,
    };
    var json = jsonEncode(productCreate);
    String response = await _api.postProduct(json);
    if (response.contains("MSG")) {
      return parseJsonToMessage(response);
    }
    return response;
  }
}
