import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Store Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          StoreMenu(),
        ],
      ),
      body: DetailView(
        size: size,
        header: StoreDetailHeader(),
        info: StoreDetailInformation(size: size),
        footer: StoreDetailFooterWidget(size: size),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenStoreUpdateImage()));
          break;
        case 'Change to Pending':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenStoreUpdateImage()));
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
          }
        }
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
      },
    );
  }
}

//! Header
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

//! Information
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

//! User Information
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
                  PrimaryButton(
                    text: "Choose Manager",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenStoreMapManager()));
                    },
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
                    fieldName: 'Store Name',
                    fieldValue: store.managerUsername,
                  ),
                  DetailDivider(size: size),
                  PrimaryButton(
                    text: "Remove Manager",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenStoreMapManager()));
                    },
                  ),
                ],
              ),
            );
          }
        } else if (state is StoreDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}
