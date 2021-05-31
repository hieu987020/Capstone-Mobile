//import 'package:equatable/equatable.dart';

class Users {
  final String userId;
  final String fullName;
  final String userName;
  final String password;
  final int roleId;
  final String imageURL;
  final int gender;
  final String birthDate;
  final String identifyCard;
  final String phone;
  final String email;
  final String storeId;
  final String storeName;
  final String address;
  final String cityName;
  final String districtName;
  final int districtId;
  final String createdTime;
  final String updatedTime;
  final String reasonInactive;
  final String status;
  final int statusId;
  final String userNameRegexp;
  final int affectedRecords;
  final String timeZone;
  final String newPassword;
  Users({
    this.storeName,
    this.fullName,
    this.userName,
    this.imageURL,
    this.birthDate,
    this.cityName,
    this.districtName,
    this.statusId,
    this.userNameRegexp,
    this.affectedRecords,
    this.timeZone,
    this.newPassword,
    this.userId,
    this.password,
    this.gender,
    this.identifyCard,
    this.phone,
    this.email,
    this.address,
    this.createdTime,
    this.updatedTime,
    this.reasonInactive,
    this.roleId,
    this.districtId,
    this.status,
    this.storeId,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    var users = Users(
      fullName: json['managerName'],
      userId: json['userId'],
      userName: json['userName'],
      storeName: json['storeName'],
      updatedTime: json['updatedTime'],
      status: json['status'],
      imageURL: json['imageURL'],
    );
    return users;
  }
}
