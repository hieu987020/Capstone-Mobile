import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerUpdateImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Change Avatar'),
      body: BlocListener<UserUpdateImageBloc, UserUpdateImageState>(
        listener: (context, state) {
          if (state is UserUpdateImageLoading) {
            loadingCommon(context);
          } else if (state is UserUpdateImageError) {
            _userUpdateImageError(context, state);
          } else if (state is UserUpdateImageLoaded) {
            _userUpdateImageLoaded(context, state);
          }
        },
        child: UpdateImage(
          model: 'user',
        ),
      ),
    );
  }
}

_userUpdateImageError(BuildContext context, UserUpdateImageError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

_userUpdateImageLoaded(BuildContext context, UserUpdateImageLoaded state) {
  String userName;
  var userDetailState = BlocProvider.of<UserDetailBloc>(context).state;
  if (userDetailState is UserDetailLoaded) {
    userName = userDetailState.user.userName;
  }
  BlocProvider.of<UserDetailBloc>(context).add(UserDetailFetchEvent(userName));
  Navigator.pop(context);
  Navigator.pop(context);
}
