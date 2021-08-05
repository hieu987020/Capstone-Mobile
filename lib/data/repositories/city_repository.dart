import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class CityRepository {
  final CityApi _api = new CityApi();

  Future<List<City>> getCity() async {
    final String rawBody = await _api.getCity();
    if (rawBody.contains(ErrorCodeAndMessage.errorCodeAndMessage)) {
      return null;
    }
    var jsonResponse = json.decode(rawBody);
    return (jsonResponse as List).map((e) => City.fromJson(e)).toList();
  }
}
