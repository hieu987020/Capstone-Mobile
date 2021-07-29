import 'dart:convert';

import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/login.dart';

class LoginRepository {
  final LoginApi _loginApi = new LoginApi();

  Future<LoginModel> login(LoginModel loginModel) async {
    var jsonLogin = jsonEncode(loginModel.toJson());
    final String rawBody = await _loginApi.login(jsonLogin);

    if (rawBody.contains('errorCodeAndMsg') == false) {
      var jsonResponse = json.decode(rawBody);
      return LoginModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
