import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ObjectListInkWell extends StatelessWidget {
  ObjectListInkWell({
    this.model,
    @required this.imageURL,
    @required this.title,
    @required this.sub,
    @required this.status,
    this.navigationField,
    @required this.onTap,
  });
  final String model;
  final String imageURL;
  final String title;
  final String sub;
  final String status;
  final String navigationField;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      // if (model == 'manager') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ScreenManagerDetail()),
      //   );
      //   BlocProvider.of<UserDetailBloc>(context)
      //       .add(UserDetailFetchEvent(navigationField));
      // } else if (model == 'store') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ScreenStoreDetail()),
      //   );
      //   BlocProvider.of<StoreDetailBloc>(context)
      //       .add(StoreDetailFetchEvent(navigationField));
      // } else if (model == 'product') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ScreenProductDetail()),
      //   );
      //   BlocProvider.of<ProductDetailBloc>(context)
      //       .add(ProductDetailFetchEvent(navigationField));
      // } else if (model == 'camera') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ScreenCameraDetail()),
      //   );
      //   BlocProvider.of<CameraDetailBloc>(context)
      //       .add(CameraDetailFetchEvent(navigationField));
      // } else if (model == 'category') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ScreenCameraDetail()),
      // );
      // }
      // },
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(6.0),
        width: double.infinity,
        height: 62.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(224, 230, 255, 1),
                    ),
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 25.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatusText(status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
