import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCreateBloc extends Bloc<UserCreateEvent, UserCreateState> {
  UserCreateBloc() : super(UserCreateInitial());
  final UserRepository _usersRepository = new UserRepository();
  final ImageRepository _imageRepository = new ImageRepository();
  @override
  Stream<UserCreateState> mapEventToState(UserCreateEvent event) async* {
    if (event is UserCreateInitialEvent) {
      // var listCity = await _cityRepository.getCity();
      yield UserCreateInitial();
    }
    if (event is UserCreateSubmitEvent) {
      yield* _createUser(event.user, event.imageFile);
    }
  }

  Stream<UserCreateState> _createUser(User user, File imageFile) async* {
    try {
      yield UserCreateLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        user = user.copyWith(
          fullName: user.fullName,
          phone: user.phone,
          address: user.address,
          birthDate: user.birthDate,
          districtId: user.districtId,
          email: user.email,
          gender: user.gender,
          identifyCard: user.identifyCard,
          imageURL: imageResult,
        );
      }
      String result = await _usersRepository.postUser(user);
      log(user.toJson().toString());

      if (result.contains('MSG-055')) {
        yield UserCreateDuplicatedEmail('Email is existed');
      } else if (result.contains('MSG-056')) {
        yield UserCreateDuplicateIdentifyCard('IdentifyCard is existed');
      } else if (result == 'true') {
        yield UserCreateLoaded();
      } else if (result.contains('errorCodeAndMsg')) {
        yield UserCreateError(result);
      }
    } catch (e) {
      yield UserCreateError(e.toString());
    }
  }
}
