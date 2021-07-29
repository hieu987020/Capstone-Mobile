import 'package:equatable/equatable.dart';

class Camera extends Equatable {
  final String cameraId;
  final String cameraName;
  final String imageUrl;
  final String macAddress;
  final String ipAddress;
  final String rtspString;
  final int typeDetect;
  final String updatedTime;
  final String createdTime;
  final int statusId;
  final String statusName;
  final String reasonInactive;

  final String stackId;
  final int position;
  final String shelfId;
  final String shelfName;
  final String addedCameraTime;
  final String storeId;
  final String storeName;
  final String storeImage;

  const Camera({
    this.cameraId,
    this.cameraName,
    this.imageUrl,
    this.macAddress,
    this.ipAddress,
    this.rtspString,
    this.typeDetect,
    this.updatedTime,
    this.createdTime,
    this.statusId,
    this.statusName,
    this.reasonInactive,
    this.stackId,
    this.position,
    this.shelfId,
    this.shelfName,
    this.addedCameraTime,
    this.storeId,
    this.storeName,
    this.storeImage,
  });

  factory Camera.fromJsonShelf(Map<String, dynamic> json) {
    return Camera(
      cameraId: json['cameraId'],
      cameraName: json['cameraName'],
      imageUrl: json['imageURL'],
      macAddress: json['macAddress'],
      ipAddress: json['ipAddress'],
      rtspString: json['rtspString'],
      updatedTime: json['updatedTime'],
      createdTime: json['createdTime'],
    );
  }

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      cameraId: json['cameraId'],
      cameraName: json['cameraName'],
      imageUrl: json['imageUrl'],
      macAddress: json['macAddress'],
      ipAddress: json['ipAddress'],
      rtspString: json['rtspString'],
      typeDetect: json['typeDetect'],
      updatedTime: json['updatedTime'],
      createdTime: json['createdTime'],
      statusId: json['statusId'],
      statusName: json['statusName'],
      reasonInactive: json['reasonInactive'],
      stackId: json['stackId'],
      position: json['position'],
      shelfId: json['shelfId'],
      shelfName: json['shelfName'],
      addedCameraTime: json['addedCameraTime'],
      storeId: json['storeId'],
      storeName: json['storeName'],
      storeImage: json['storeImage'],
    );
  }

  factory Camera.fromJsonLst(Map<String, dynamic> json) {
    return Camera(
      cameraId: json['cameraId'] as String,
      cameraName: json['cameraName'] as String,
      imageUrl: json['imageURL'] as String,
      macAddress: json['macAddress'] as String,
      ipAddress: json['ipAddress'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      updatedTime: json['updatedTime'] as String,
      statusId: json['statusId'] as int,
      statusName: json['statusName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cameraId': cameraId,
      'cameraName': cameraName,
      'imageUrl': imageUrl,
      'macAddress': macAddress,
      'ipAddress': ipAddress,
      'rtspString': rtspString,
      'typeDetect': typeDetect,
    };
  }

  @override
  List<Object> get props {
    return [
      cameraId,
      cameraName,
      imageUrl,
      macAddress,
      ipAddress,
      rtspString,
      typeDetect,
      updatedTime,
      createdTime,
      statusId,
      statusName,
      reasonInactive,
      stackId,
      position,
      shelfId,
      shelfName,
      addedCameraTime,
      storeId,
      storeName,
      storeImage,
    ];
  }

  Camera copyWith({
    String cameraId,
    String cameraName,
    String imageUrl,
    String macAddress,
    String ipAddress,
    String rtspString,
    int typeDetect,
    String updatedTime,
    String createdTime,
    int statusId,
    String statusName,
    String reasonInactive,
    String stackId,
    int position,
    String shelfId,
    String shelfName,
    String addedCameraTime,
    String storeId,
    String storeName,
    String storeImage,
  }) {
    return Camera(
      cameraId: cameraId ?? this.cameraId,
      cameraName: cameraName ?? this.cameraName,
      imageUrl: imageUrl ?? this.imageUrl,
      macAddress: macAddress ?? this.macAddress,
      ipAddress: ipAddress ?? this.ipAddress,
      rtspString: rtspString ?? this.rtspString,
      typeDetect: typeDetect ?? this.typeDetect,
      updatedTime: updatedTime ?? this.updatedTime,
      createdTime: createdTime ?? this.createdTime,
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
      reasonInactive: reasonInactive ?? this.reasonInactive,
      stackId: stackId ?? this.stackId,
      position: position ?? this.position,
      shelfId: shelfId ?? this.shelfId,
      shelfName: shelfName ?? this.shelfName,
      addedCameraTime: addedCameraTime ?? this.addedCameraTime,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeImage: storeImage ?? this.storeImage,
    );
  }
}
