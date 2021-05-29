import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class Users extends Equatable {
  final String userId;
  final String imageUrl;
  final String username;
  // final String password;
  final String fullname;
  // final int gender;
  // final DateTime date;
  // final String identifyCard;
  // final String phone;
  // final String email;
  // final String address;
  // final DateTime createdTime;
  // final DateTime updatedTime;
  // final String reasonInactive;
  // final int roleId;
  // final int districtId;
  final String statusId;
  final String storeId;

  const Users({
    required this.userId,
    required this.imageUrl,
    required this.username,
    // required this.password,
    required this.fullname,
    // required this.gender,
    // required this.date,
    // required this.identifyCard,
    // required this.phone,
    // required this.email,
    // required this.address,
    // required this.createdTime,
    // required this.updatedTime,
    // required this.reasonInactive,
    // required this.roleId,
    // required this.districtId,
    required this.statusId,
    required this.storeId,
  });

  @override
  List<Object> get props => [
        userId,
        imageUrl,
        username,
        // password,
        fullname,
        // gender,
        // date,
        // identifyCard,
        // phone,
        // email,
        // address,
        // createdTime,
        // updatedTime,
        // reasonInactive,
        // roleId,
        // districtId,
        statusId,
      ];
  static Users fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['userId'],
      username: json['userName'],
      fullname: json['managerName'],
      storeId: json['storeId'],
      statusId: json['status'],
      imageUrl: json['imageURL'],
    );
  }
}

Future<Users> fetchUsers() async {
  final response = await http.get(
      Uri.parse('http://192.168.1.253:9090/admin/manager?userName=luanlm10'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Users.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
