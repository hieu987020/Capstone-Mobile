import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ManagerCardHeader extends StatelessWidget {
  final String _text;

  ManagerCardHeader(this._text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeaderText(_text),
        Container(
          child: StatusDropdown(),
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        )
      ],
    );
  }
}

class ManagerCardAvatar extends StatelessWidget {
  final String _assetPath;

  ManagerCardAvatar(this._assetPath);

  @override
  Widget build(BuildContext context) {
    if (_assetPath == null) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
          ),
        ),
      );
    } else {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(_assetPath),
          ),
        ),
      );
    }
  }
}
