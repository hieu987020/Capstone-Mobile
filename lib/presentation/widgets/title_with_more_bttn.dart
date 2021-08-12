import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TitleWithMoreBtn extends StatelessWidget {
  TitleWithMoreBtn({
    @required this.title,
    @required this.model,
    @required this.defaultStatus,
    @required this.searchValue,
    @required this.searchField,
  });
  final String title;
  final String model;
  final String defaultStatus;
  final String searchValue;
  final String searchField;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
          // StatusDropdown(
          //   model: model,
          //   defaultValue: defaultStatus,
          //   searchValue: searchValue,
          //   searchField: searchField,
          // ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  TitleWithCustomUnderline({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text.toUpperCase(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}

class TitleWithNothing extends StatelessWidget {
  TitleWithNothing({
    this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
        ],
      ),
    );
  }
}

class TitleWithColor extends StatelessWidget {
  TitleWithColor({
    this.title,
    this.color,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: <Widget>[
          Container(
            height: 24,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 4),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: kDefaultPadding / 4),
                    height: 7,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          // Text(
          //   title.toUpperCase(),
          //   style: TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //     color: color,
          //   ),
          // ),
          Spacer(),
        ],
      ),
    );
  }
}
