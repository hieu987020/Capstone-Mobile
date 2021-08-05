import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Update Manager'),
      body: BlocListener<UserUpdateBloc, UserUpdateState>(
        listener: (context, state) {
          if (state is UserUpdateLoaded) {
            _userUpdateLoaded(context);
          } else if (state is UserUpdateError) {
            _userUpdateError(context, state);
          } else if (state is UserUpdateLoading) {
            loadingCommon(context);
          } else if (state is UserUpdateDuplicatedEmail) {
            Navigator.of(context).pop();
          } else if (state is UserUpdateDuplicateIdentifyCard) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(listWidget: [ManagerUpdateForm()]),
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

class ManagerUpdateForm extends StatefulWidget {
  @override
  ManagerUpdateFormState createState() {
    return ManagerUpdateFormState();
  }
}

class ManagerUpdateFormState extends State<ManagerUpdateForm> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<UserDetailBloc>(context).state;
    User user;
    if (state is UserDetailLoaded) {
      user = state.user;
    }
    var defaultGender = "";
    if (user.gender == 0) {
      defaultGender = 'Male';
    } else if (user.gender == 1) {
      defaultGender = 'Female';
    }
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _fullName =
        TextEditingController(text: user.fullName);
    final TextEditingController _identifyCard =
        TextEditingController(text: user.identifyCard);
    final TextEditingController _phone =
        TextEditingController(text: user.phone);
    final TextEditingController _email =
        TextEditingController(text: user.email);
    final TextEditingController _birthDate =
        TextEditingController(text: user.birthDate);
    final TextEditingController _gender =
        TextEditingController(text: defaultGender);
    final TextEditingController _address =
        TextEditingController(text: user.address);
    final TextEditingController _districtId =
        TextEditingController(text: user.districtId.toString());
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
                  hintText: "Fullname",
                  controller: _fullName,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/fullname.png',
                      color: kPrimaryColor,
                      height: 25,
                    ),
                  ),
                ),
                GenderRatio(_gender, defaultGender),
                ManagerTextField(
                  hintText: "Identify Card",
                  controller: _identifyCard,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/id_card.png',
                      color: kPrimaryColor,
                      height: 25,
                    ),
                  ),
                ),
                BlocBuilder<UserCreateBloc, UserCreateState>(
                  builder: (context, state) {
                    if (state is UserCreateDuplicateIdentifyCard) {
                      return DuplicateField(state.message);
                    }
                    return Text("");
                  },
                ),
                ManagerTextField(
                  hintText: "Phone",
                  controller: _phone,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/phone.png',
                      color: kPrimaryColor,
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Email",
                  controller: _email,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/email.png',
                      color: kPrimaryColor,
                      height: 25,
                    ),
                  ),
                ),
                BlocBuilder<UserCreateBloc, UserCreateState>(
                  builder: (context, state) {
                    if (state is UserCreateDuplicatedEmail) {
                      return DuplicateField(state.message);
                    }
                    return Text("");
                  },
                ),
                DateTextField(
                  hintText: "Date of birth",
                  controller: _birthDate,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/date.png',
                      color: kPrimaryColor,
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Address",
                  controller: _address,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/address.png',
                      color: kPrimaryColor,
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                StaticDropDown(
                  controller: _districtId,
                  defaultCity: user.cityName,
                  defaultDistrict: user.districtName,
                ),
                SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Save",
                  onPressed: () {
                    int genderInt = 0;
                    if (_formKey.currentState.validate()) {
                      if (_gender.text == GenderStringBase.Female) {
                        genderInt = GenderIntBase.Female;
                      } else if (_gender.text == GenderStringBase.Male) {
                        genderInt = GenderIntBase.Male;
                      }
                      User _user = new User(
                        userName: user.userName,
                        fullName: _fullName.text,
                        identifyCard: _identifyCard.text,
                        phone: _phone.text,
                        email: _email.text,
                        birthDate: _birthDate.text + " 0:0:0",
                        gender: genderInt,
                        imageURL: user.imageURL,
                        address: _address.text,
                        districtId: int.parse(_districtId.text),
                      );
                      UserUpdateBloc userCreateBloc =
                          BlocProvider.of<UserUpdateBloc>(context);
                      userCreateBloc.add(UserUpdateSubmit(_user));
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
