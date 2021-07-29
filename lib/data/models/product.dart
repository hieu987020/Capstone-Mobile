import 'package:equatable/equatable.dart';

import 'package:capstone/data/models/models.dart';

class Product extends Equatable {
  final String productId;
  final String productName;
  final String imageUrl;
  final String description;
  final String createdTime;
  final String updatedTime;
  final String reasonInactive;
  final int statusId;
  final String statusName;
  final List<Category> categories;

  const Product({
    this.productId,
    this.productName,
    this.imageUrl,
    this.description,
    this.createdTime,
    this.updatedTime,
    this.reasonInactive,
    this.statusId,
    this.statusName,
    this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      createdTime: json['createdTime'] as String,
      updatedTime: json['updatedTime'] as String,
      reasonInactive: json['reasonInactive'] as String,
      statusId: json['statusId'] as int,
      statusName: json['statusName'] as String,
      categories: (json['categories'] as List<dynamic>)
          ?.map((e) =>
              e == null ? null : Category.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

  factory Product.fromJsonLst(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      createdTime: json['createdTime'] as String,
      updatedTime: json['updatedTime'] as String,
      reasonInactive: json['reasonInactive'] as String,
      statusId: json['statusId'] as int,
      statusName: json['statusName'] as String,
      categories: (json['categories'] as List<dynamic>)
          ?.map((e) =>
              e == null ? null : Category.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'imageUrl': imageUrl,
      'description': description,
      'statusName': statusName,
      'categories': categories?.map((e) => e?.toJson())?.toList(),
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      productId,
      productName,
      imageUrl,
      description,
      createdTime,
      updatedTime,
      reasonInactive,
      statusId,
      statusName,
      categories,
    ];
  }

  Product copyWith({
    String productId,
    String productName,
    String imageUrl,
    String description,
    String createdTime,
    String updatedTime,
    String reasonInactive,
    int statusId,
    String statusName,
    List<Category> categories,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      reasonInactive: reasonInactive ?? this.reasonInactive,
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
      categories: categories ?? this.categories,
    );
  }
}
