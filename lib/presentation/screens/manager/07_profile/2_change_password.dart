import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Change Password'),
      body: BlocListener<UserUpdateBloc, UserUpdateState>(
        listener: (context, state) {
          if (state is UserUpdateLoaded) {
            _userUpdateLoaded(context);
          } else if (state is UserUpdateError) {
            _userUpdateError(context, state);
          } else if (state is UserUpdateLoading) {
            loadingCommon(context);
          }
        },
        child: MyScrollView(listWidget: [ChangePasswordForm()]),
      ),
    );
  }
}

_userUpdateLoaded(BuildContext context) {
  String userName;
  var userDetailState = BlocProvider.of<UserDetailBloc>(context).state;
  if (userDetailState is UserDetailLoaded) {
    userName = userDetailState.user.userName;
  }
  BlocProvider.of<UserDetailBloc>(context).add(UserDetailFetchEvent(userName));
  Navigator.pop(context);
  Navigator.pop(context);
}

_userUpdateError(BuildContext context, UserUpdateError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

class ChangePasswordForm extends StatefulWidget {
  @override
  ChangePasswordFormState createState() {
    return ChangePasswordFormState();
  }
}

class ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _old = TextEditingController();
    final TextEditingController _new = TextEditingController();
    final TextEditingController _retype = TextEditingController();
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ManagerTextField(
                  hintText: "Old password",
                  controller: _old,
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "New password",
                  controller: _new,
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Retype password",
                  controller: _retype,
                ),
                SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Update",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      var state =
                          BlocProvider.of<UserDetailBloc>(context).state;
                      String userName;
                      if (state is UserDetailLoaded) {
                        userName = state.user.userName;
                      }
                      BlocProvider.of<UserUpdateBloc>(context).add(
                          UserChangePassword(
                              userName: userName,
                              oldPassword: _old.text,
                              newPassword: _new.text,
                              retypePassword: _retype.text));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
