import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Profile Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [ProfileMenu()],
      ),
      body: BlocListener<UserUpdateInsideBloc, UserUpdateInsideState>(
          listener: (context, state) {
            if (state is UserUpdateInsideLoading) {
              loadingCommon(context);
            } else if (state is UserUpdateInsideError) {
              _userUpdateInsideError(context, state);
            } else if (state is UserUpdateInsideLoaded) {
              _userUpdateInsideLoaded(context, state);
            }
          },
          child: MyScrollView(
            listWidget: [
              ProfileHeader(),
              ProfileInformation(size: size),
              ProfileFooterWidget(size: size),
            ],
          )),
    );
  }
}

_userUpdateInsideLoaded(BuildContext context, UserUpdateInsideLoaded state) {
  String userName;
  var userDetailState = BlocProvider.of<UserDetailBloc>(context).state;
  if (userDetailState is UserDetailLoaded) {
    userName = userDetailState.user.userName;
  }
  BlocProvider.of<UserDetailBloc>(context).add(UserDetailFetchEvent(userName));
  Navigator.pop(context);
}

_userUpdateInsideError(BuildContext context, UserUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('App Message'),
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

_userRemoveStoreDialog(BuildContext context, User user) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove Store'),
        content: Text('Are you sure to remove this store?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<UserUpdateInsideBloc>(context)
                  .add(UserMapStoreEvent(user.storeId, user.userId, 2));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_userResetPasswordDialog(BuildContext context, User user) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset Password'),
        content: Text('Are you sure to reset password for this manager?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<UserUpdateInsideBloc>(context)
                  .add(UserResetPassword(user.userName, user.email));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Update Information':
          BlocProvider.of<UserUpdateBloc>(context)
              .add(UserUpdateInitialEvent());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenManagerUpdateInformation()));
          break;
        case 'Change Password':
          // User user;
          // var state = BlocProvider.of<UserDetailBloc>(context).state;
          // if (state is UserDetailLoaded) {
          //   user = state.user;
          // }
          // _userResetPasswordDialog(context, user);
          break;
        case 'Change Avatar':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenManagerUpdateImage()));
          break;
      }
    }

    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoaded) {
          return PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Update Information',
                'Change Avatar',
                'Change Password',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          );
        }
        return PopupMenuButton<String>(
          onSelected: _handleClick,
          itemBuilder: (BuildContext context) {
            return {''}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      },
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return LoadingContainer();
        } else if (state is UserDetailLoaded) {
          User user = state.user;
          return DetailHeaderContainer(
            imageURL: user.imageURL,
            title: user.fullName,
            status: user.status,
          );
        } else if (state is UserDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class ProfileInformation extends StatelessWidget {
  final Size size;
  ProfileInformation({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return LoadingContainer();
        } else if (state is UserDetailLoaded) {
          User user = state.user;
          String gender = "Male";
          if (user.gender == GenderIntBase.Male) {
            gender = GenderStringBase.Male;
          } else {
            gender = GenderStringBase.Female;
          }
          return Container(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailFieldContainer(
                  // prefixIcon: 'assets/icons/fullname.png',
                  fieldName: 'User Name',
                  fieldValue: user.userName,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Gender',
                  fieldValue: gender,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'BirthDate',
                  fieldValue: user.birthDate,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Identify',
                  fieldValue: user.identifyCard,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Phone',
                  fieldValue: user.phone,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Email',
                  fieldValue: user.email,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'City',
                  fieldValue: user.cityName,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'District',
                  fieldValue: user.districtName,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Address',
                  fieldValue: user.address,
                ),
                (user.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailDivider(size: size),
                (user.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailFieldContainer(
                        fieldName: 'Reason Inactive',
                        fieldValue: user.reasonInactive,
                      ),
                DetailDivider(size: size),
              ],
            ),
          );
        } else if (state is UserDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class ProfileFooterWidget extends StatelessWidget {
  final Size size;

  ProfileFooterWidget({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailBloc, StoreDetailState>(
      builder: (context, state) {
        if (state is StoreDetailLoading) {
          return LoadingContainer();
        } else if (state is StoreDetailLoaded) {
          Store store = state.store;
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: ObjectListInkWell(
                imageURL: store.imageUrl,
                title: store.storeName,
                sub: store.address,
                status: store.statusName,
                onTap: () {}),
          );
        } else if (state is UserDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}
