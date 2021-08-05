import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Store Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          StoreMenu(),
        ],
      ),
      body: BlocListener<StoreUpdateInsideBloc, StoreUpdateInsideState>(
        listener: (context, state) {
          if (state is StoreUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is StoreUpdateInsideError) {
            _storeUpdateInsideError(context, state);
          } else if (state is StoreUpdateInsideLoaded) {
            _storeUpdateInsideLoaded(context, state);
          }
        },
        child: MyScrollView(
          listWidget: [
            StoreDetailHeader(),
            StoreDetailInformation(size: size),
            StoreDetailFooterWidget(size: size),
          ],
        ),
      ),
    );
  }
}

_storeUpdateInsideLoaded(BuildContext context, StoreUpdateInsideLoaded state) {
  String storeId;
  var stateDetail = BlocProvider.of<StoreDetailBloc>(context).state;
  if (stateDetail is StoreDetailLoaded) {
    storeId = stateDetail.store.storeId;
  }
  BlocProvider.of<StoreDetailBloc>(context).add(StoreDetailFetchEvent(storeId));
  Navigator.pop(context);
}

_storeUpdateInsideError(BuildContext context, StoreUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Fail'),
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

_storeChangeStatusDialog(BuildContext context, int statusId) {
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
              String storeId;
              var state = BlocProvider.of<StoreDetailBloc>(context).state;
              if (state is StoreDetailLoaded) {
                storeId = state.store.storeId;
              }
              BlocProvider.of<StoreUpdateInsideBloc>(context)
                  .add(StoreChangeStatus(storeId, statusId, null));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_storeRemoveManagerDialog(BuildContext context, Store store) {
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
              BlocProvider.of<StoreUpdateInsideBloc>(context)
                  .add(StoreMapManagerEvent(store.storeId, store.managerId, 2));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class StoreMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Update Information':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenStoreUpdateInformation()));
          break;
        case 'Change Image':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenStoreUpdateImage()));
          break;
        case 'Change to Inactive':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenStoreInactive()));
          break;
        case 'Change to Pending':
          _storeChangeStatusDialog(context, StatusIntBase.Pending);
          break;
      }
    }

    return BlocBuilder<StoreDetailBloc, StoreDetailState>(
      builder: (context, state) {
        if (state is StoreDetailLoaded) {
          if (state.store.statusName.contains(StatusStringBase.Pending)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
                  'Change to Inactive',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.store.statusName
              .contains(StatusStringBase.Inactive)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
                  'Change to Pending',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.store.statusName.contains(StatusStringBase.Active)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
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
            return {""}.map((String choice) {
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

class StoreDetailHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailBloc, StoreDetailState>(
      builder: (context, state) {
        if (state is StoreDetailLoading) {
          return LoadingContainer();
        } else if (state is StoreDetailLoaded) {
          var store = state.store;
          return DetailHeaderContainer(
            imageURL: store.imageUrl,
            title: store.storeName,
            status: store.statusName,
          );
        } else if (state is StoreDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class StoreDetailInformation extends StatelessWidget {
  final Size size;
  StoreDetailInformation({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailBloc, StoreDetailState>(
      builder: (context, state) {
        if (state is StoreDetailLoading) {
          return LoadingContainer();
        } else if (state is StoreDetailLoaded) {
          var store = state.store;
          return Container(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailFieldContainer(
                  fieldName: 'Store Name',
                  fieldValue: store.storeName,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Address',
                  fieldValue: store.address,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'City',
                  fieldValue: store.cityName,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'District',
                  fieldValue: store.districtName,
                ),
                (store.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailDivider(size: size),
                (store.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailFieldContainer(
                        fieldName: 'Reason Inactive',
                        fieldValue: store.reasonInactive,
                      ),
                DetailDivider(size: size),
              ],
            ),
          );
        } else if (state is StoreDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class StoreDetailFooterWidget extends StatelessWidget {
  final Size size;
  StoreDetailFooterWidget({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailBloc, StoreDetailState>(
      builder: (context, state) {
        if (state is StoreDetailLoading) {
          return LoadingContainer();
        } else if (state is StoreDetailLoaded) {
          var store = state.store;
          if (store.statusName == StatusStringBase.Pending) {
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
                      text: "Choose Manager",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenStoreMapManager()));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (store.statusName == StatusStringBase.Active) {
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
                    fieldName: 'Manager Name',
                    fieldValue: store.managerUsername,
                  ),
                  DetailDivider(size: size),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: PrimaryButton(
                      text: "Remove Manager",
                      onPressed: () {
                        _storeRemoveManagerDialog(context, store);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        } else if (state is StoreDetailError) {
          return FailureStateWidget();
        }
        return Text("");
      },
    );
  }
}
