import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    this.categoryId,
    this.categoryName,
    this.statusId,
    this.statusName,
  });

  final int categoryId;
  final String categoryName;
  final int statusId;
  final String statusName;

  @override
  List<Object> get props => [categoryId, categoryName, statusId, statusName];

  @override
  bool get stringify => true;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        statusId: json["statusId"],
        statusName: json["statusName"],
      );
  factory Category.fromJsonLst(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        statusId: json["statusId"],
        statusName: json["statusName"],
      );
  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "statusId": statusId,
        "statusName": statusName,
      };

  Category copyWith({
    int categoryId,
    String categoryName,
    int statusId,
    String statusName,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
    );
  }
}
