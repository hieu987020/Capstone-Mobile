import 'package:capstone/repositories/repositories.dart';
import 'package:capstone/models/models.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({this.userApiClient}) : assert(userApiClient != null);

  Future<Users> getUser(String userName) async {
    return userApiClient.fetchUser(userName);
  }

  Future<List<Users>> getUsers() async {
    return userApiClient.fetchUsers();
  }
}
