import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/image_repository.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateImageBloc
    extends Bloc<UserUpdateImageEvent, UserUpdateImageState> {
  UserUpdateImageBloc() : super(UserUpdateImageInitial());

  final UserRepository _userRepository = new UserRepository();
  final ImageRepository _imageRepository = new ImageRepository();

  @override
  Stream<UserUpdateImageState> mapEventToState(
      UserUpdateImageEvent event) async* {
    if (event is UserUpdateImageInitialEvent) {
      yield UserUpdateImageInitial();
    }
    if (event is UserUpdateImageSubmit) {
      yield* _updateImage(event.user, event.imageFile);
    }
  }

  Stream<UserUpdateImageState> _updateImage(User user, File imageFile) async* {
    try {
      yield UserUpdateImageLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        user = user.copyWith(
          userName: user.userName,
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
      String result = await _userRepository.updateUser(user);
      if (result == 'true') {
        yield UserUpdateImageLoaded();
      } else {
        yield UserUpdateImageError(result);
      }
    } catch (e) {
      yield UserUpdateImageError("System can not finish this action");
    }
  }
}
