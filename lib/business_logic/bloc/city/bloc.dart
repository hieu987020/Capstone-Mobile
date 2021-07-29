import 'dart:developer';

import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityFetchInitial());
  final CityRepository cityRepository = new CityRepository();

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    if (event is CityFetchEvent) {
      yield* _getCities();
    }
  }

  Stream<CityState> _getCities() async* {
    try {
      yield CityLoading();
      var cities = await cityRepository.getCity();
      log("list city ne " + cities.length.toString());
      yield CityLoaded(cities);
    } catch (e) {
      yield CityError();
    }
  }
}
