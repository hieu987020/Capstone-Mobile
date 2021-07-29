import 'package:equatable/equatable.dart';

class Store extends Equatable {
  const Store({
    this.storeId,
    this.storeName,
    this.imageUrl,
    this.managerName,
    this.managerUsername,
    this.managerId,
    this.managerImage,
    this.address,
    this.districtId,
    this.districtName,
    this.cityId,
    this.cityName,
    this.createdTime,
    this.updatedTime,
    this.reasonInactive,
    this.statusId,
    this.statusName,
  });

  final String storeId;
  final String storeName;
  final String imageUrl;
  final String managerName;
  final String managerUsername;
  final String managerId;
  final String managerImage;
  final String address;
  final int districtId;
  final String districtName;
  final int cityId;
  final String cityName;
  final String createdTime;
  final String updatedTime;
  final String reasonInactive;
  final int statusId;
  final String statusName;

  @override
  List<Object> get props {
    return [
      storeId,
      storeName,
      imageUrl,
      managerName,
      managerUsername,
      managerId,
      managerImage,
      address,
      districtId,
      districtName,
      cityId,
      cityName,
      createdTime,
      updatedTime,
      reasonInactive,
      statusId,
      statusName,
    ];
  }

  @override
  bool get stringify => true;

  factory Store.fromJsonLst(Map<String, dynamic> json) => Store(
        storeId: json["storeId"],
        storeName: json["storeName"],
        imageUrl: json["imageUrl"],
        managerUsername: json["managerUsername"],
        managerId: json["managerUserId"],
        address: json["address"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        districtId: json["districtId"],
        districtName: json["districtName"],
        updatedTime: json["updatedTime"],
        reasonInactive: json["reasonInactive"],
        statusId: json["statusId"],
        statusName: json["status"],
      );

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeId: json["storeId"],
        storeName: json["storeName"],
        imageUrl: json["imageUrl"],
        managerName: json["managerName"],
        managerUsername: json["managerUsername"],
        managerId: json["managerId"],
        managerImage: json["managerImage"],
        address: json["address"],
        districtId: json["districtId"],
        districtName: json["districtName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        createdTime: json["createdTime"],
        updatedTime: json["updatedTime"],
        reasonInactive: json["reasonInactive"],
        statusId: json["statusId"],
        statusName: json["statusName"],
      );

  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "storeName": storeName,
        "imageUrl": imageUrl,
        "address": address,
        "districtId": districtId,
      };
  Store copyWith({
    String storeId,
    String storeName,
    String imageUrl,
    String managerName,
    String managerUsername,
    String managerId,
    String managerImage,
    String address,
    int districtId,
    String districtName,
    int cityId,
    String cityName,
    String createdTime,
    String updatedTime,
    String reasonInactive,
    String analyzedTime,
    int statusId,
    String statusName,
  }) {
    return Store(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      imageUrl: imageUrl ?? this.imageUrl,
      managerName: managerName ?? this.managerName,
      managerUsername: managerUsername ?? this.managerUsername,
      managerId: managerId ?? this.managerId,
      managerImage: managerImage ?? this.managerImage,
      address: address ?? this.address,
      districtId: districtId ?? this.districtId,
      districtName: districtName ?? this.districtName,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      reasonInactive: reasonInactive ?? this.reasonInactive,
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
    );
  }
}
