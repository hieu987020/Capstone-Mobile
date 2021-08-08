import 'dart:convert';
import 'dart:io';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';

class ImageRepository {
  final ImageApi _api = new ImageApi();

  Future<String> postImage(File image) async {
    final String rawBody = await _api.postImage(image);
    var jsonResponse = json.decode(rawBody);
    return ImageURL.fromJson(jsonResponse).filePath;
  }
}
