# A Flutter project: Customer Feedback Through Facial Expression Analysis
State management: Bloc pattern </br>
Database: MySQL(Java backend) </br>
Cloud: Google Storage </br>
Package: http,...
### Example
[<img src="https://github.com/hieu987020/Capstone-Mobile/blob/master/raw/list_manager.jpg?raw=true" width="200">]()
[<img src="https://github.com/hieu987020/Capstone-Mobile/blob/master/raw/drawer.jpg?raw=true" width="200">]()
[<img src="https://github.com/hieu987020/Capstone-Mobile/blob/master/raw/shelf_detail.jpg?raw=true" width="200">]()
[<img src="https://github.com/hieu987020/Capstone-Mobile/blob/master/raw/stack_detail.jpg?raw=true" width="200">]()
[<img src="https://github.com/hieu987020/Capstone-Mobile/blob/master/raw/play_video.jpg?raw=true" width="200">]()
### Call update image api via http package
```dart
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

```
### Development
```
[√] Flutter (Channel stable, 2.5.3, on Microsoft Windows [Version 10.0.19043.1348], locale en-US)
[√] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[√] Chrome - develop for the web
[√] Android Studio (version 4.2)
[√] VS Code (version 1.63.0)
[√] Connected device (3 available)
```

