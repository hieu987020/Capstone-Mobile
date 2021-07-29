import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddFloatingButton extends StatelessWidget {
  const AddFloatingButton({
    this.onPressed,
  });
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      child: Icon(Icons.add),
      onPressed: onPressed,
    );
  }
}
