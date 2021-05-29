import 'package:capstone/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListManagerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

class ManagerCard extends StatelessWidget {
  final String _avatar;
  final String _managerName;
  final String _storeName;
  final String _status;
  ManagerCard(this._avatar, this._managerName, this._storeName, this._status);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ManagerCardAvatar(_avatar),
        Expanded(
          child: CardText(_managerName, _storeName),
        ),
        StatusText(_status),
      ],
    );
  }
}

class ManagerCardHeader extends StatelessWidget {
  final String _text;

  ManagerCardHeader(this._text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeaderText(_text),
        StatusDropdown(),
      ],
    );
  }
}

class ManagerCardAvatar extends StatelessWidget {
  final String _assetPath;

  ManagerCardAvatar(this._assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
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
