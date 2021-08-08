import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/admin/03_manager/3_detail.dart';
import 'package:capstone/presentation/screens/manager/07_profile/1_manager.dart';
import 'package:capstone/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminNavigator extends StatelessWidget {
  final Size size;
  final String selectedIndex;

  AdminNavigator({this.size, this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    LoginModel loginModel;
    var state = BlocProvider.of<LoginBloc>(context).state;
    if (state is LoginAdminLoaded) {
      loginModel = state.loginModel;
    } else if (state is LoginManagerLoaded) {
      loginModel = state.loginModel;
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: size.width * 0.9,
            child: DrawerHeader(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(kDefaultPadding / 2),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(loginModel.imageURL),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(kDefaultPadding / 2),
                        child: Text(
                          loginModel.fullName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenManagerDetail()),
                      );
                      BlocProvider.of<UserDetailBloc>(context)
                          .add(UserDetailFetchEvent(loginModel.userName));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/icons/fullname.png",
                          color: Colors.white,
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.all(kDefaultPadding / 2),
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Dashboard',
            iconAsset: 'assets/icons/dashboard.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/admin_dashboard");
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Video',
            iconAsset: 'assets/icons/video.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/video");
              BlocProvider.of<StoreBloc>(context).add(StoreGetOperationEvent());
              BlocProvider.of<ShelfBloc>(context).add(ShelfFetchInitalEvent());
              BlocProvider.of<ProductBloc>(context).add(ProductAllEvent());
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Store',
            iconAsset: 'assets/icons/store.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/store");
              BlocProvider.of<StoreBloc>(context)
                  .add(StoreFetchEvent(StatusIntBase.All));
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Manager',
            iconAsset: 'assets/icons/manager.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/manager");
              BlocProvider.of<UserBloc>(context)
                  .add(UserFetchEvent(StatusIntBase.All));
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Category',
            iconAsset: 'assets/icons/category.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/category");
              BlocProvider.of<CategoryBloc>(context)
                  .add(CategoryFetchEvent(StatusIntBase.All));
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Product',
            iconAsset: 'assets/icons/product.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/product");
              BlocProvider.of<ProductBloc>(context)
                  .add(ProductFetchEvent(StatusIntBase.All));
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Camera',
            iconAsset: 'assets/icons/camera.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/camera");
              BlocProvider.of<CameraBloc>(context)
                  .add(CameraFetchEvent(StatusIntBase.All));
            },
          ),
          Divider(
            height: 1,
            color: kPrimaryColor.withOpacity(0.6),
          ),
          ListTile(
            title: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  // fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: kTextColor,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
              BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent());
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required this.selectedIndex,
    @required this.size,
    @required this.indexName,
    @required this.iconAsset,
    @required this.onTap,
  }) : super(key: key);

  final String selectedIndex;
  final Size size;

  final String indexName;
  final String iconAsset;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: selectedIndex == indexName
                ? BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.4),
                    borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(28),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(28),
                    ),
                  )
                : BoxDecoration(),
            height: 60,
            width: size.width * 0.6,
            child: Row(
              children: [
                SizedBox(width: 25),
                Image.asset(
                  iconAsset,
                  color:
                      selectedIndex == indexName ? kPrimaryColor : kTextColor,
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    indexName,
                    style: TextStyle(
                      color: selectedIndex == indexName
                          ? kPrimaryColor
                          : kTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManagerNavigator extends StatelessWidget {
  final Size size;
  final String selectedIndex;

  ManagerNavigator({this.size, this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    LoginModel loginModel;
    var state = BlocProvider.of<LoginBloc>(context).state;
    if (state is LoginAdminLoaded) {
      loginModel = state.loginModel;
    } else if (state is LoginManagerLoaded) {
      loginModel = state.loginModel;
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: size.width * 0.9,
            child: DrawerHeader(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(kDefaultPadding / 2),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(loginModel.imageURL),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(kDefaultPadding / 2),
                        child: Text(
                          loginModel.fullName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenManagerProfile()),
                      );
                      BlocProvider.of<UserDetailBloc>(context)
                          .add(UserDetailFetchEvent(loginModel.userName));
                      BlocProvider.of<StoreDetailBloc>(context)
                          .add(StoreDetailFetchEvent(loginModel.storeId));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/icons/fullname.png",
                          color: Colors.white,
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.all(kDefaultPadding / 2),
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Dashboard',
            iconAsset: 'assets/icons/dashboard.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/admin_dashboard");
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Video',
            iconAsset: 'assets/icons/video.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/manager_video");
              BlocProvider.of<UserBloc>(context)
                  .add(UserFetchEvent(StatusIntBase.All));
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Shelf',
            iconAsset: 'assets/icons/shelf.png',
            onTap: () {
              BlocProvider.of<ShelfBloc>(context)
                  .add(ShelfFetchEvent(StatusIntBase.All));
              Navigator.pushReplacementNamed(context, "/shelf");
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Camera',
            iconAsset: 'assets/icons/camera.png',
            onTap: () {
              BlocProvider.of<CameraBloc>(context)
                  .add(CameraFetchEvent(StatusIntBase.All));
              Navigator.pushReplacementNamed(context, "/manager_camera");
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Product',
            iconAsset: 'assets/icons/product.png',
            onTap: () {
              Navigator.pushReplacementNamed(context, "/manager_product");
              BlocProvider.of<ProductBloc>(context)
                  .add(ProductFetchEvent(StatusIntBase.All));
            },
          ),
          DrawerItem(
            selectedIndex: selectedIndex,
            size: size,
            indexName: 'Category',
            iconAsset: 'assets/icons/category.png',
            onTap: () {
              BlocProvider.of<CategoryBloc>(context)
                  .add(CategoryFetchEvent(StatusIntBase.All));
              Navigator.pushReplacementNamed(context, "/manager_category");
            },
          ),
          SizedBox(height: 30),
          Divider(
            height: 1,
            color: kPrimaryColor.withOpacity(0.6),
          ),
          ListTile(
            title: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  // fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: kTextColor,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
              BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent());
            },
          ),
        ],
      ),
    );
  }
}

removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
