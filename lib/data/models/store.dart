import 'package:capstone/data/models/video.dart';
import 'package:equatable/equatable.dart';

import 'package:capstone/data/models/shelf.dart';

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
    this.shelves,
    this.videos,
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
  final List<Shelf> shelves;
  final List<Video> videos;
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
      shelves,
      videos,
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

  factory Store.fromJsonCountingVideo(Map<String, dynamic> json) => Store(
        storeId: json["storeId"],
        storeName: json["storeName"],
        shelves: (json['shelves'] as List<dynamic>)
            ?.map((e) => e == null
                ? null
                : Shelf.fromJsonVideo(e as Map<String, dynamic>))
            ?.toList(),
      );
  factory Store.fromJsonEmotionVideo(Map<String, dynamic> json) => Store(
        storeId: json["storeId"],
        storeName: json["storeName"],
        videos: (json['videos'] as List<dynamic>)
            ?.map((e) =>
                e == null ? null : Video.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );
  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "storeName": storeName,
        "imageUrl": imageUrl,
        "address": address,
        "districtId": districtId,
      };
  Store copyWith(
      {String storeId,
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
      List<Shelf> shelves,
      List<Video> videos}) {
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
      shelves: shelves ?? this.shelves,
      videos: videos ?? this.videos,
    );
  }
}
