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
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
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
            SizedBox(width: 25.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child: Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
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

class ObjectListInkWell3 extends StatelessWidget {
  ObjectListInkWell3({
    this.model,
    @required this.imageURL,
    @required this.title,
    @required this.sub,
    @required this.three,
    @required this.status,
    this.navigationField,
    @required this.onTap,
  });
  final String model;
  final String imageURL;
  final String title;
  final String sub;
  final String three;
  final String status;
  final String navigationField;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
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
            SizedBox(width: 25.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    width: 150,
                    child: Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    width: 150,
                    child: Text(
                      three,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
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

class CategoryListInkWell extends StatelessWidget {
  CategoryListInkWell({
    this.model,
    @required this.title,
    @required this.status,
    this.navigationField,
    @required this.onTap,
  });
  final String model;
  final String title;
  final String status;
  final String navigationField;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
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

class ShelfListInkWell extends StatelessWidget {
  ShelfListInkWell({
    this.model,
    @required this.title,
    @required this.sub,
    @required this.three,
    @required this.status,
    this.navigationField,
    @required this.onTap,
  });
  final String model;
  final String title;
  final String sub;
  final String three;
  final String status;
  final String navigationField;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child: Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      three,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.0),
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

class StackListInkWell extends StatelessWidget {
  StackListInkWell({
    this.model,
    @required this.title,
    @required this.sub,
    @required this.status,
    this.navigationField,
    @required this.onTap,
    @required this.three,
  });
  final String model;
  final String title;
  final String sub;
  final String three;
  final String status;
  final String navigationField;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child: Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    //color: Colors.red,
                    child: Text(
                      three,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.0),
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

class CountingListInkWell extends StatelessWidget {
  CountingListInkWell({
    this.model,
    @required this.imageURL,
    @required this.title,
    @required this.sub,
    @required this.status,
    @required this.onTap,
    @required this.onRemove,
  });
  final String model;
  final String imageURL;
  final String title;
  final String sub;
  final String status;
  final Function() onTap;
  final Function() onRemove;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
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
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child: Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/cancel.png",
                      color: kPrimaryColor,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class CountingVideoListInkWell extends StatelessWidget {
  CountingVideoListInkWell({
    this.model,
    @required this.index,
    @required this.title,
    @required this.sub,
    @required this.three,
    @required this.four,
    @required this.five,
    @required this.status,
    this.navigationField,
    @required this.onTap,
  });
  final String model;
  final String index;
  final String title;
  final String sub;
  final String three;
  final String four;
  final String five;
  final String status;
  final String navigationField;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(6.0),
        width: double.infinity,
        height: 120.0,
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
            SizedBox(width: 10.0),
            Container(
              child: Text(
                index,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(title: title),
                  SizedBox(height: 2.0),
                  SubText(sub: sub),
                  SizedBox(height: 2.0),
                  SubText(sub: three),
                  SizedBox(height: 2.0),
                  SubText(sub: four),
                  SizedBox(height: 2.0),
                  SubText(sub: five),
                  SizedBox(height: 2.0),
                ],
              ),
            ),
            SizedBox(width: 2.0),
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

class SubText extends StatelessWidget {
  const SubText({
    @required this.sub,
  });

  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        sub,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black.withOpacity(0.6),
          // color: kPrimaryColor,
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  TitleText({
    @required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
