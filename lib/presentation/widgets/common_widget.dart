import 'package:flutter/material.dart';

//! Common : Appbar Text
class AppBarText extends StatelessWidget {
  final String _text;
  AppBarText(this._text);
  @override
  Widget build(BuildContext context) {
    if (_text != null) {
      return Container(
        child: Text(
          _text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Text("");
  }
}

//! Common : Header Text
class ScreenHeaderText extends StatelessWidget {
  final String _text;
  ScreenHeaderText(this._text);
  @override
  Widget build(BuildContext context) {
    if (_text != null) {
      return Container(
        child: new Text(
          _text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: EdgeInsets.only(top: 10, left: 5, right: 10),
      );
    }
    return Text("");
  }
}

//! Common : Status Text
class StatusText extends StatelessWidget {
  final String _text;
  StatusText(this._text);
  @override
  Widget build(BuildContext context) {
    if (this._text == "Active") {
      return Container(
        height: 30,
        width: 70,
        decoration: BoxDecoration(
          color: Color.fromRGBO(235, 255, 241, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: new Center(
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(17, 156, 43, 1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (this._text == "Pending") {
      return Container(
        height: 30,
        width: 70,
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 221, 78, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: new Center(
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(131, 81, 1, 1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (this._text == "Inactive") {
      return Container(
        height: 30,
        width: 70,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 239, 235, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: new Center(
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(204, 9, 5, 1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Text("");
    }
  }
}

//! Common : In Progress View
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]),
          strokeWidth: 1,
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: AlertDialog(
        content: Center(
          heightFactor: 0.5,
          widthFactor: 0.5,
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]),
              strokeWidth: 1,
            ),
          ),
        ),
      ),
    );
  }
}

loadingCommon(BuildContext context) {
  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return LoadingDialog();
    },
  );
}

//! Common : Unmapped State View
class UnmappedStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Not map state"),
    );
  }
}

//! Common : Failure State View
class FailureStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Oops check your internet network"),
    );
  }
}

//! Common : Duplicated Text Field
class DuplicateField extends StatelessWidget {
  final String message;

  const DuplicateField(this.message);

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return Text("");
  }
}

class NoRecordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Record Found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            height: 80,
            child: Image.asset('assets/images/no_data.png'),
          ),
        ],
      ),
    );
  }
}

class ErrorRecordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Some records are not found, please try again!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            height: 80,
            child: Image.asset('assets/images/no_data.png'),
          ),
        ],
      ),
    );
  }
}
