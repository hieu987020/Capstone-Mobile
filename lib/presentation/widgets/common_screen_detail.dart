import 'package:flutter/material.dart';

class ListViewBoldText extends StatelessWidget {
  final String _text;
  ListViewBoldText(this._text);
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Color.fromRGBO(69, 75, 102, 1),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ListViewNormalText extends StatelessWidget {
  final String _text;
  ListViewNormalText(this._text);
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Color.fromRGBO(24, 34, 76, 1),
        fontSize: 15,
      ),
    );
  }
}

class SDHeaderText extends StatelessWidget {
  final String _text;
  SDHeaderText(this._text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
      child: new Text(
        _text,
        style: TextStyle(
          color: Color.fromRGBO(69, 75, 102, 1),
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DetailTitleText extends StatelessWidget {
  DetailTitleText(this._text);
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Text(
      _text ?? "",
      style: TextStyle(
        color: Color.fromRGBO(69, 75, 102, 1),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DetailFieldNameText extends StatelessWidget {
  DetailFieldNameText(this._text);
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Text(
      _text ?? "",
      style: TextStyle(
        color: Color.fromRGBO(110, 124, 135, 1),
        fontSize: 12,
      ),
    );
  }
}

class DetailInfoText extends StatelessWidget {
  DetailInfoText(this._text);
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Text(
      _text ?? "",
      style: TextStyle(
        color: Color.fromRGBO(110, 124, 135, 1),
        fontSize: 12,
      ),
    );
  }
}

class SDBodyTitleText extends StatelessWidget {
  final String _tile;
  SDBodyTitleText(this._tile);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        (_tile),
        style: TextStyle(
          color: Color.fromRGBO(69, 75, 102, 1),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SDBodyFieldnameText extends StatelessWidget {
  final String _text;
  SDBodyFieldnameText(this._text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: new Text(
        _text,
        style: TextStyle(
          color: Color.fromRGBO(110, 124, 135, 1),
          fontSize: 12,
        ),
      ),
    );
  }
}

class SDBodyContentText extends StatelessWidget {
  final String _text;
  SDBodyContentText(this._text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 8),
      child: new Text(
        _text,
        style: TextStyle(
          color: Color.fromRGBO(69, 75, 102, 1),
          fontSize: 18,
        ),
      ),
    );
  }
}

class SDBodyContentGenderText extends StatelessWidget {
  final int genderId;
  SDBodyContentGenderText(this.genderId);
  @override
  Widget build(BuildContext context) {
    String gender = "Other";
    if (genderId == 0) {
      gender = "Male";
    } else if (genderId == 1) {
      gender = "Female";
    }
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 8),
      child: new Text(
        gender,
        style: TextStyle(
          color: Color.fromRGBO(69, 75, 102, 1),
          fontSize: 18,
        ),
      ),
    );
  }
}
