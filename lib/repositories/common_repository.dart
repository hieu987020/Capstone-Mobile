import 'package:capstone/repositories/repositories.dart';
import 'package:http/http.dart' as http;

class CommonRepository {
  final UserRepository usersRepository = UserRepository(
    userApiClient: UserApiClient(httpClient: http.Client()),
  );
}
