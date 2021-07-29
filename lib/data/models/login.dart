import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String token;
  final String userId;
  final String userName;
  final String passWord;
  final String fullName;
  final int statusId;
  final String statusName;
  final int roleId;
  final String roleName;
  final String storeId;
  final String storeName;
  final String imageURL;

  LoginModel({
    this.token,
    this.userId,
    this.userName,
    this.passWord,
    this.fullName,
    this.statusId,
    this.statusName,
    this.roleId,
    this.roleName,
    this.storeId,
    this.storeName,
    this.imageURL,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      userId: json['userId'],
      userName: json['userName'],
      fullName: json['fullName'],
      statusId: json['statusId'],
      statusName: json['statusName'],
      roleId: json['roleId'],
      roleName: json['roleName'],
      storeId: json['storeId'],
      storeName: json['storeName'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.userName;
    data['password'] = this.passWord;
    return data;
  }

  Map<String, dynamic> toJsonFull() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['username'] = this.userName;
    data['password'] = this.passWord;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['imageURL'] = this.imageURL;
    return data;
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        this.token,
        this.userId,
        this.userName,
        this.passWord,
        this.fullName,
        this.statusId,
        this.statusName,
        this.roleId,
        this.roleName,
        this.storeId,
        this.storeName,
        this.imageURL,
      ];
}
