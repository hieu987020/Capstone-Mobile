import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class StackModel extends Equatable {
  const StackModel({
    this.stackId,
    this.position,
    this.createTime,
    this.updatedTime,
    this.reasonInactive,
    this.shelfId,
    this.shelfName,
    this.camera,
    this.product,
    this.statusId,
    this.statusName,
  });

  @override
  List<Object> get props => [
        stackId,
        position,
        createTime,
        updatedTime,
        reasonInactive,
        shelfId,
        shelfName,
        camera,
        product,
        statusId,
        statusName,
      ];

  final String stackId;
  final int position;
  final String createTime;
  final String updatedTime;
  final String reasonInactive;
  final String shelfId;
  final String shelfName;
  final Camera camera;
  final Product product;
  final int statusId;
  final String statusName;

  Map<String, dynamic> toJson() {
    return {
      'stackId': stackId,
      'position': position,
      'createTime': createTime,
      'updatedTime': updatedTime,
      'reasonInactive': reasonInactive,
      'shelfId': shelfId,
      'shelfName': shelfName,
      'camera': camera,
      'product': product,
      'statusId': statusId,
      'statusName': statusName,
    };
  }

  factory StackModel.fromJson(Map<String, dynamic> json) {
    return StackModel(
      stackId: json['stackId'],
      position: json['position'],
      createTime: json['createTime'],
      updatedTime: json['updatedTime'],
      reasonInactive: json['reasonInactive'],
      shelfId: json['shelfId'],
      shelfName: json['shelfName'],
      camera: json["camera"] == null ? null : Camera.fromJson(json["camera"]),
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
      statusId: json['statusId'],
      statusName: json['statusName'],
    );
  }

  StackModel copyWith({
    String stackId,
    int position,
    String createTime,
    String updatedTime,
    String reasonInactive,
    String shelfId,
    String shelfName,
    String camera,
    String product,
    int statusId,
    String statusName,
  }) {
    return StackModel(
      stackId: stackId ?? this.stackId,
      position: position ?? this.position,
      createTime: createTime ?? this.createTime,
      updatedTime: updatedTime ?? this.updatedTime,
      reasonInactive: reasonInactive ?? this.reasonInactive,
      shelfId: shelfId ?? this.shelfId,
      shelfName: shelfName ?? this.shelfName,
      camera: camera ?? this.camera,
      product: product ?? this.product,
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
    );
  }
}
