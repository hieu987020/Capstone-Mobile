import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.userId,
    this.fullName,
    this.userName,
    this.password,
    this.roleId,
    this.imageURL,
    this.gender,
    this.birthDate,
    this.identifyCard,
    this.phone,
    this.email,
    this.storeId,
    this.storeName,
    this.address,
    this.cityId,
    this.cityName,
    this.districtName,
    this.districtId,
    this.createdTime,
    this.updatedTime,
    this.reasonInactive,
    this.status,
    this.statusId,
    this.userNameRegexp,
    this.affectedRecords,
    this.timeZone,
    this.newPassword,
  });

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
  final int cityId;
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

  @override
  List<Object> get props => [
        userId,
        fullName,
        userName,
        password,
        roleId,
        imageURL,
        gender,
        birthDate,
        identifyCard,
        phone,
        email,
        storeId,
        storeName,
        address,
        cityName,
        districtName,
        districtId,
        createdTime,
        updatedTime,
        reasonInactive,
        status,
        statusId,
        userNameRegexp,
        affectedRecords,
        timeZone,
        newPassword
      ];

  @override
  bool get stringify => true;

  factory User.fromJson(Map<String, dynamic> json) {
    var users = User(
      userId: json["userId"],
      fullName: json["fullName"],
      userName: json["userName"],
      imageURL: json["imageURL"],
      gender: json["gender"],
      birthDate: json["birthDate"],
      identifyCard: json["identifyCard"],
      phone: json["phone"],
      email: json["email"],
      storeId: json["storeId"],
      storeName: json["storeName"],
      address: json["address"],
      cityId: json["cityId"],
      cityName: json["cityName"],
      districtId: json["districtId"],
      districtName: json["districtName"],
      createdTime: json["createdTime"],
      updatedTime: json["updatedTime"],
      reasonInactive: json["reasonInactive"],
      status: json["status"],
    );
    return users;
  }

  factory User.fromJsonLst(Map<String, dynamic> json) {
    var usersLst = User(
      fullName: json['managerName'],
      userId: json['userId'],
      userName: json['userName'],
      storeId: json['storeId'],
      storeName: json['storeName'],
      updatedTime: json['updatedTime'],
      status: json['status'],
      imageURL: json['imageURL'],
    );
    return usersLst;
  }
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'fullName': fullName,
        'identifyCard': identifyCard,
        'phone': phone,
        'email': email,
        'birthDate': birthDate,
        'gender': gender,
        'imageURL': imageURL,
        'address': address,
        'districtId': districtId,
      };

  User copyWith({
    String userId,
    String fullName,
    String userName,
    String password,
    int roleId,
    String imageURL,
    int gender,
    String birthDate,
    String identifyCard,
    String phone,
    String email,
    String storeId,
    String storeName,
    String address,
    String cityId,
    String cityName,
    String districtName,
    int districtId,
    String createdTime,
    String updatedTime,
    String reasonInactive,
    String status,
    int statusId,
    String userNameRegexp,
    int affectedRecords,
    String timeZone,
    String newPassword,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      roleId: roleId ?? this.roleId,
      imageURL: imageURL ?? this.imageURL,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      identifyCard: identifyCard ?? this.identifyCard,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      address: address ?? this.address,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      districtName: districtName ?? this.districtName,
      districtId: districtId ?? this.districtId,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      reasonInactive: reasonInactive ?? this.reasonInactive,
      status: status ?? this.status,
      statusId: statusId ?? this.statusId,
      userNameRegexp: userNameRegexp ?? this.userNameRegexp,
      affectedRecords: affectedRecords ?? this.affectedRecords,
      timeZone: timeZone ?? this.timeZone,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
