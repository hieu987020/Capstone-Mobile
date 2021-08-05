import 'package:capstone/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BorderTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  BorderTextField({
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.borderRadius),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: this.obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 0.0),
          suffixIcon: this.suffixIcon,
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(169, 176, 185, 1),
          ),
        ),
        validator: (value) {
          switch (hintText) {
            case 'Username':
              if (value.isEmpty) {
                return "Username is required";
              }
              break;
            case 'Password':
              if (value.isEmpty) {
                return "Password is required";
              }
              break;
            case 'Fullname':
              if (value.length < 2 || value.length > 100) {
                return "2 - 100 characters'";
              }
              break;
            case 'Identify Card':
              if (value.length < 9 || value.length > 12) {
                return "'9 - 12 digits";
              }
              break;
            case 'Phone':
              if (value.length != 10 || value.length > 12) {
                return "0xxxxxxxxx(x is a digits)";
              }
              break;
            case 'Email':
              if (RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
                      .hasMatch(value) ==
                  false) {
                return "exp: name@gmail.com";
              }
              break;
            case 'Address':
              if (value.length < 1 || value.length > 250) {
                return "1 - 250 characters";
              }
              break;
              break;
            default:
          }
          return null;
        },
      ),
    );
  }
}

class ManagerTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  ManagerTextField({
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.borderRadius),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: this.obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 0.0),
          suffixIcon: this.suffixIcon,
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(169, 176, 185, 1),
          ),
        ),
        validator: (value) {
          switch (hintText) {
            case 'Fullname':
              if (value.length < 2 || value.length > 100) {
                return "2 - 100 characters'";
              }
              break;
            case 'Identify Card':
              if (value.length < 9 || value.length > 12) {
                return "'9 - 12 digits";
              }
              break;
            case 'Phone':
              if (value.length != 10 || value.length > 12) {
                return "0xxxxxxxxx(x is a digits)";
              }
              break;
            case 'Email':
              if (RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
                      .hasMatch(value) ==
                  false) {
                return "exp: name@gmail.com";
              }
              break;
            case 'Address':
              if (value.length < 1 || value.length > 250) {
                return "1 - 250 characters";
              }
              break;
            default:
          }
          return null;
        },
      ),
    );
  }
}

class ProductTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  ProductTextField({
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.borderRadius),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: this.obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 0.0),
          suffixIcon: this.suffixIcon,
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(169, 176, 185, 1),
          ),
        ),
        validator: (value) {
          switch (hintText) {
            case 'Product Name':
              if (value.length < 2 || value.length > 100) {
                return "2 - 100 characters";
              }
              break;
            case 'Description':
              if (value.length < 2 || value.length > 250) {
                return "2 - 250 characters";
              }
              break;
            case 'Category':
              if (value.length < 2 || value.length > 250) {
                return "2 - 250 characters";
              }
              break;
            default:
          }
          return null;
        },
      ),
    );
  }
}

class CameraTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  CameraTextField({
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.borderRadius),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: this.obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 0.0),
          suffixIcon: this.suffixIcon,
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(169, 176, 185, 1),
          ),
        ),
        validator: (value) {
          switch (hintText) {
            case 'Camera Name':
              if (value.length < 2 || value.length > 100) {
                return "2 - 100 characters";
              }
              break;
            case 'IP Address':
              if (!RegExp(
                      r'^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.(?!$)|$)){4}$')
                  .hasMatch(value)) {
                return "IP Address must be x.x.x.x format (x is number between 0 to 255)";
              }
              break;
            case 'RTSP String':
              if (!RegExp(
                      r'^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.(?!$)|$)){4}$')
                  .hasMatch(value)) {
                return "RTSP String must be x.x.x.x format (x is number between 0 to 255)";
              }
              break;
            case 'MAC Address':
              if (!RegExp(r'^([0-9A-Fa-f]{2}[-]){5}([0-9A-Fa-f]{2})$')
                  .hasMatch(value)) {
                return "MAC address exp: 1A-2B-3C-4D-5E-6F";
              }
              break;
            default:
          }
          return null;
        },
      ),
    );
  }
}

class StoreTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  StoreTextField({
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.borderRadius),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        obscureText: this.obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 0.0),
          suffixIcon: this.suffixIcon,
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(169, 176, 185, 1),
          ),
        ),
        validator: (value) {
          switch (hintText) {
            case 'Store Name':
              if (value.length < 2 || value.length > 100) {
                return "2 - 100 characters";
              }
              break;
            case 'Address':
              if (value.isEmpty) {
                return "Address is required";
              }
              break;
            case 'District':
              if (value.isEmpty) {
                return "District is required";
              }
              break;
            default:
          }
          return null;
        },
      ),
    );
  }
}

class DateTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  DateTextField({
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.validator,
  });

  @override
  _DateTextFieldState createState() => _DateTextFieldState(
        hintText,
        obscureText,
        suffixIcon,
        prefixIcon,
        borderRadius,
        controller,
        validator,
      );
}

class _DateTextFieldState extends State<DateTextField> {
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final TextEditingController controller;
  final String Function(String) validator;
  _DateTextFieldState(
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius,
    this.controller,
    this.validator,
  );
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var f = new DateFormat('yyyy-MM-dd');
        String date = f.format(picked);
        controller.value = TextEditingValue(text: date);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        onTap: () {
          _selectDate(context);
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        obscureText: this.widget.obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: this.widget.prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 0.0),
          suffixIcon: this.widget.suffixIcon,
          border: InputBorder.none,
          hintText: this.widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(169, 176, 185, 1),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Date of birth is required";
          }
          return null;
        },
      ),
    );
  }
}

class ReasonTextField extends StatelessWidget {
  ReasonTextField(this._validate, this._labelText, this._controller);

  final String _validate;
  final String _labelText;
  final TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: _labelText,
        contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
      ),
      validator: (value) {
        switch (_labelText) {
          case 'Reason':
            if (value.isEmpty) {
              return _validate;
            }
            break;
          default:
        }
        return null;
      },
    );
  }
}
