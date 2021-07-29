import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class StoreRepository {
  final StoreApi _api = new StoreApi();

  Future<Store> getStore(String userName) async {
    final String rawBody = await _api.getStore(userName);
    var jsonResponse = json.decode(rawBody);
    return Store.fromJson(jsonResponse);
  }

  Future<List<Store>> getStores(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async {
    final String rawBody = await _api.getStores(
        searchValue, searchField, pageNum, fetchNext, statusId);
    var jsonResponse = json.decode(rawBody);
    if (jsonResponse
        .toString()
        .contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['stores'] as List)
        .map((e) => Store.fromJsonLst(e))
        .toList();
  }

  Future<List<Store>> getStoresByStoreName(String storeName) async {
    final String rawBody = await _api.getStoresByStoreName(storeName);
    var jsonResponse = json.decode(rawBody);
    if (jsonResponse
        .toString()
        .contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    return (jsonResponse['stores'] as List)
        .map((e) => Store.fromJsonLst(e))
        .toList();
  }

  Future<String> changeManager(
      String userId, String storeId, int active) async {
    Map<String, dynamic> jsonMapStore = {
      "storeId": storeId,
      "userId": userId,
      "active": active,
    };
    print('json trong map store repository\n');
    print(jsonMapStore.toString());
    var jsonUpt = jsonEncode(jsonMapStore);
    final String response = await _api.changeManager(jsonUpt);
    print('response map store trong repository ne\n');
    print(response);
    if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return response;
    }
    return 'true';
  }

  Future<String> updateStore(Store store) async {
    var storeCreateJson = jsonEncode(store.toJson());
    final String response = await _api.updateStore(storeCreateJson);
    if (response.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return response;
    }
    return 'true';
  }

  Future<String> postStore(Store user) async {
    var json = jsonEncode(user.toJson());
    String response = await _api.postStore(json);
    if (response.contains('true') == true &&
        response.contains('errorCodeAndMsg') == false) {
      return 'true';
    } else {
      return response;
    }
  }
}
