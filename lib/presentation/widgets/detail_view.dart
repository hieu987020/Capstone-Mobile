import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final Size size;
  final Widget header;
  final Widget info;
  final Widget footer;
  DetailView({this.size, this.header, this.info, this.footer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        bottom: true,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              info,
              footer,
            ],
          ),
        ),
      ),
    );
  }
}

class DetailHeaderContainer extends StatelessWidget {
  DetailHeaderContainer({
    this.imageURL,
    this.title,
    this.status,
  });
  final String imageURL;
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(imageURL),
              backgroundColor: Colors.grey[200],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: new Text(
              title,
              style: TextStyle(
                color: Color.fromRGBO(69, 75, 102, 1),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //SDHeaderText(user.fullName),
          StatusText(status),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
