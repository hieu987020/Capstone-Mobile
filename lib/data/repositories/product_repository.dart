import 'dart:convert';
import 'dart:developer';

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
      int pageNum, int fetchNext, int statusId) async {
    final String rawBody = await _api.getProducts(
        searchValue, searchField, pageNum, fetchNext, statusId);
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
      String userName, int statusId, String reasonInactive) async {
    Map<String, dynamic> jsonChangeStatus;
    if (reasonInactive == null) {
      jsonChangeStatus = {
        "userName": userName,
        "statusId": statusId,
      };
    } else {
      jsonChangeStatus = {
        "userName": userName,
        "statusId": statusId,
        "reasonInactive": reasonInactive,
      };
    }
    var userCreateJson = jsonEncode(jsonChangeStatus);
    final String response = await _api.changeStatus(userCreateJson);
    if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return response;
    }
    return 'true';
  }

  Future<String> updateProduct(Product product) async {
    var productUpdateJson = jsonEncode(product.toJson());
    final String response = await _api.updateProduct(productUpdateJson);
    if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return response;
    }
    return 'true';
  }

  Future<String> postProduct(Product product) async {
    Map<String, dynamic> productCreate = {
      "imageUrl": product.imageUrl,
      "description": product.description,
      "categories": [2],
      "productName": product.productName,
    };
    var json = jsonEncode(productCreate);
    log(json.toString());
    String response = await _api.postProduct(json);
    if (response.contains('true') == true &&
        response.contains('errorCodeAndMsg') == false) {
      return 'true';
    } else {
      return response;
    }
  }
}
