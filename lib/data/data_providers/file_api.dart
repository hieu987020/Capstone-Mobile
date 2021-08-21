import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImageApi {
  static const String baseUrl = UrlBase.baseUrl;

  Future<String> postImage(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var stream = new http.ByteStream((imageFile.openRead()));
    stream.cast();
    var length = await imageFile.length();
    var uri = Uri.parse(
      "$baseUrl/file/upload-image",
    );
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile(
      'file',
      stream,
      length,
      filename: imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(multipartFile);
    request.headers.addAll(headers);
    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
