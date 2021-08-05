import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Manager Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [ManagerMenu()],
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
              ManagerDetailHeader(),
              ManagerDetailInformation(size: size),
              ManagerDetailFooterWidget(size: size),
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
        title: Text('Error Notification'),
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

_userChangeStatusDialog(BuildContext context, int statusId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change to Pending'),
        content: Text('The status will change to Pending, are you sure?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String userName;
              var state = BlocProvider.of<UserDetailBloc>(context).state;
              if (state is UserDetailLoaded) {
                userName = state.user.userName;
              }
              BlocProvider.of<UserUpdateInsideBloc>(context)
                  .add(UserChangeStatus(userName, statusId, null));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
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

class ManagerMenu extends StatelessWidget {
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

        case 'Change Avatar':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenManagerUpdateImage()));
          break;
        case 'Change to Inactive':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenManagerInactive()));
          break;
        case 'Change to Pending':
          _userChangeStatusDialog(context, StatusIntBase.Pending);
          break;
      }
    }

    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoaded) {
          if (state.user.status.contains(StatusStringBase.Pending)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Avatar',
                  'Change to Inactive'
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.user.status.contains(StatusStringBase.Inactive)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Avatar',
                  'Change to Pending'
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.user.status.contains(StatusStringBase.Active)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Avatar',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          }
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

class ManagerDetailHeader extends StatelessWidget {
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

class ManagerDetailInformation extends StatelessWidget {
  final Size size;
  ManagerDetailInformation({this.size});
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

class ManagerDetailFooterWidget extends StatelessWidget {
  final Size size;

  ManagerDetailFooterWidget({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return LoadingContainer();
        } else if (state is UserDetailLoaded) {
          User user = state.user;
          if (user.status == StatusStringBase.Pending) {
            return Container(
              constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: PrimaryButton(
                      text: "Choose Store",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenManagerMapStore()));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (user.status == StatusStringBase.Active) {
            return Container(
              constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Store Name',
                    fieldValue: user.storeName,
                  ),
                  DetailDivider(size: size),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: PrimaryButton(
                      text: "Remove Store",
                      onPressed: () {
                        _userRemoveStoreDialog(context, user);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Text("");
        } else if (state is UserDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}
