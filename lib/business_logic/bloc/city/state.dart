import 'package:capstone/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CityState extends Equatable {}

class CityFetchInitial extends CityState {
  @override
  List<Object> get props => [];
}

class CityLoading extends CityState {
  @override
  List<Object> get props => [];
}

class CityLoaded extends CityState {
  CityLoaded(this.cities);

  final List<City> cities;
  @override
  List<Object> get props => [];
}

class CityError extends CityState {
  @override
  List<Object> get props => [];
}
