import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

class Shelf extends Equatable {
  final String shelfId;
  final String shelfName;
  final String description;
  final int numberOfStack;
  final String createdTime;
  final String updatedTime;
  final String reasonInactive;
  final int statusId;
  final String statusName;
  final List<Camera> camera;
  Shelf({
    this.shelfId,
    this.shelfName,
    this.description,
    this.numberOfStack,
    this.createdTime,
    this.updatedTime,
    this.reasonInactive,
    this.statusId,
    this.statusName,
    this.camera,
  });

  @override
  List<Object> get props => [
        shelfId,
        shelfName,
        description,
        numberOfStack,
        createdTime,
        updatedTime,
        reasonInactive,
        statusId,
        statusName,
        camera,
      ];

  Map<String, dynamic> toJson() {
    return {
      'shelfId': shelfId,
      'shelfName': shelfName,
      'description': description,
      'numberOfStack': numberOfStack,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'reasonInactive': reasonInactive,
      'statusId': statusId,
      'statusName': statusName,
    };
  }

  factory Shelf.fromJsonLst(Map<String, dynamic> json) {
    return Shelf(
      shelfId: json['shelfId'],
      shelfName: json['shelfName'],
      description: json['description'],
      numberOfStack: json['numberOfStack'],
      updatedTime: json['updatedTime'],
      statusName: json['statusName'],
    );
  }
  factory Shelf.fromJson(Map<String, dynamic> json) {
    return Shelf(
      shelfId: json['shelfId'],
      shelfName: json['shelfName'],
      description: json['description'],
      numberOfStack: json['numberOfStack'],
      createdTime: json['createdTime'],
      updatedTime: json['updatedTime'],
      reasonInactive: json['reasonInactive'],
      statusName: json['statusName'],
      camera: (json['cameras'] as List<dynamic>)
          ?.map((e) => e == null
              ? null
              : Camera.fromJsonShelf(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Shelf copyWith({
    String shelfId,
    String shelfName,
    String description,
    int numberOfStack,
    String createdTime,
    String updatedTime,
    String reasonInactive,
    int statusId,
    String statusName,
    Camera camera,
  }) {
    return Shelf(
      shelfId: shelfId ?? this.shelfId,
      shelfName: shelfName ?? this.shelfName,
      description: description ?? this.description,
      numberOfStack: numberOfStack ?? this.numberOfStack,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      reasonInactive: reasonInactive ?? this.reasonInactive,
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
      camera: camera ?? this.camera,
    );
  }
}
