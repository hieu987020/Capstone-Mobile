import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScreenManagerCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCreateBloc>(context).add(UserCreateInitialEvent());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Create Manager'),
      body: BlocListener<UserCreateBloc, UserCreateState>(
        listener: (context, state) {
          if (state is UserCreateLoaded) {
            _userCreateLoaded(context, state);
          } else if (state is UserCreateError) {
            _userCreateError(context, state);
          } else if (state is UserCreateLoading) {
            loadingCommon(context);
          } else if (state is UserCreateDuplicateIdentifyCard) {
            Navigator.of(context).pop();
          } else if (state is UserCreateDuplicatedEmail) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(
          listWidget: [ManagerCreateForm()],
        ),
      ),
    );
  }
}

_userCreateLoaded(BuildContext context, UserCreateLoaded state) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScreenManager()),
  );
  BlocProvider.of<UserBloc>(context).add(UserFetchEvent(
    searchValue: "",
    searchField: "",
    fetchNext: 0,
    pageNum: 0,
    statusId: StatusIntBase.All,
  ));
  BlocProvider.of<UserCreateBloc>(context).add(UserCreateInitialEvent());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Create Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_userCreateError(BuildContext context, UserCreateError state) {
  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Error'),
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

class ManagerCreateForm extends StatefulWidget {
  @override
  ManagerCreateFormState createState() {
    return ManagerCreateFormState();
  }
}

class ManagerCreateFormState extends State<ManagerCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _identifyCard = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _birthDate = TextEditingController();
  final _gender = TextEditingController(text: "Male");
  final _address = TextEditingController();
  final _districtId = TextEditingController();

  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Avatar :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: getImage,
                      child: _image == null
                          ? Container(
                              height: 36,
                              width: 100,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor:
                                      kPrimaryColor.withOpacity(0.6),
                                ),
                                onPressed: getImage,
                                child: Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.3),
                                ),
                                child: Container(
                                  height: 80,
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Fullname",
                  controller: _fullName,
                  // prefixIcon: Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: Image.asset(
                  //     'assets/icons/fullname.png',
                  //     color: kPrimaryColor,
                  //     height: 25,
                  //   ),
                  // ),
                ),
                GenderRatio(_gender, 'Male'),
                ManagerTextField(
                  hintText: "Identify Card",
                  controller: _identifyCard,
                  // prefixIcon: Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: Image.asset(
                  //     'assets/icons/id_card.png',
                  //     color: kPrimaryColor,
                  //     height: 25,
                  //   ),
                  // ),
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Phone",
                  controller: _phone,
                  // prefixIcon: Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: Image.asset(
                  //     'assets/icons/phone.png',
                  //     color: kPrimaryColor,
                  //     height: 25,
                  //   ),
                  // ),
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Email",
                  controller: _email,
                  // prefixIcon: Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: Image.asset(
                  //     'assets/icons/email.png',
                  //     color: kPrimaryColor,
                  //     height: 25,
                  //   ),
                  // ),
                ),
                SizedBox(height: 15.0),
                DateTextField(
                  hintText: "Date of birth",
                  controller: _birthDate,
                  // prefixIcon: Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: Image.asset(
                  //     'assets/icons/date.png',
                  //     color: kPrimaryColor,
                  //     height: 25,
                  //   ),
                  // ),
                ),
                SizedBox(height: 15.0),
                ManagerTextField(
                  hintText: "Address",
                  controller: _address,
                  // prefixIcon: Container(
                  //   margin: EdgeInsets.only(right: 10),
                  //   child: Image.asset(
                  //     'assets/icons/address.png',
                  //     color: kPrimaryColor,
                  //     height: 25,
                  //   ),
                  // ),
                ),
                SizedBox(height: 15.0),
                StaticDropDown(
                  controller: _districtId,
                  defaultCity: "Ho Chi Minh",
                  defaultDistrict: "District 1",
                ),
                SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Create",
                  onPressed: () {
                    int genderInt = 0;
                    if (_formKey.currentState.validate()) {
                      if (_gender.text == GenderStringBase.Female) {
                        genderInt = GenderIntBase.Female;
                      } else if (_gender.text == GenderStringBase.Male) {
                        genderInt = GenderIntBase.Male;
                      }
                      User _user = new User(
                        fullName: _fullName.text,
                        identifyCard: _identifyCard.text,
                        phone: _phone.text,
                        email: _email.text,
                        birthDate: _birthDate.text,
                        gender: genderInt,
                        imageURL: "",
                        address: _address.text,
                        districtId: int.parse(_districtId.text),
                      );
                      BlocProvider.of<UserCreateBloc>(context)
                          .add(UserCreateSubmitEvent(_user, _image));
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('tao thay roi ' + pickedFile.path.toString());
      } else {
        print('No image selected.');
      }
    });
  }
}
