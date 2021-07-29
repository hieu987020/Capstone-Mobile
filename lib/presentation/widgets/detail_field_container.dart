import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailDivider extends StatelessWidget {
  const DetailDivider({
    @required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Divider(
        height: 1,
        color: kPrimaryColor.withOpacity(0.6),
      ),
    );
  }
}

class DetailFieldContainer extends StatelessWidget {
  DetailFieldContainer({
    this.suffixIcon,
    @required this.fieldName,
    @required this.fieldValue,
  });
  final Widget suffixIcon;
  final String fieldName;
  final String fieldValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 50,
      constraints: BoxConstraints(minHeight: 50, maxHeight: 500),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              //color: Colors.blue,
              alignment: Alignment.centerLeft,
              child: Text(
                fieldName,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 200,
              //color: Colors.blue,
              alignment: Alignment.centerRight,
              child: Text(
                fieldValue,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
