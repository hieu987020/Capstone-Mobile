import 'package:equatable/equatable.dart';

class District extends Equatable {
  final String districtId;
  final String districtName;

  District({
    this.districtId,
    this.districtName,
  });

  @override
  List<Object> get props => [districtId, districtName];
}

class City extends Equatable {
  final String cityId;
  final String cityName;
  final List<District> listDistrict;

  City({
    this.cityId,
    this.cityName,
    this.listDistrict,
  });

  @override
  List<Object> get props => [cityId, cityName];

  @override
  bool get stringify => true;

  factory City.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> listDistrictJson = json["districts"];
    List<District> listDistrict = List<District>.empty(growable: true);

    listDistrictJson.forEach((key, value) {
      listDistrict.add(new District(districtId: key, districtName: value));
    });
    var city = City(
      cityId: json["cityId"],
      cityName: json["cityName"],
      listDistrict: listDistrict,
    );
    return city;
  }

  City copyWith({
    String cityId,
    String cityName,
    List<District> listDistrict,
  }) {
    return City(
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      listDistrict: listDistrict ?? this.listDistrict,
    );
  }
}
