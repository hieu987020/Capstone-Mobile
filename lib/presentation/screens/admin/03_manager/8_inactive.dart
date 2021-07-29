import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/business_logic/bloc/user/update_inactive/event.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerReasonInactive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Reason Inactive'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<UserInactiveBloc, UserInactiveState>(
        listener: (context, state) {
          if (state is UserInactiveLoaded) {
            _userChangeToInactiveLoaded(context);
          } else if (state is UserInactiveLoading) {
            loadingCommon(context);
          } else if (state is UserInactiveError) {
            _userChangeToInactiveError(context, state);
          }
        },
        child: ReasonForm(),
      ),
    );
  }
}

// ignore: todo
//TODO Stuff
_userChangeToInactiveLoaded(BuildContext context) {
  String userName;
  var userDetailState = BlocProvider.of<UserDetailBloc>(context).state;
  if (userDetailState is UserDetailLoaded) {
    userName = userDetailState.user.userName;
  }
  BlocProvider.of<UserDetailBloc>(context).add(UserDetailFetchEvent(userName));
  Navigator.pop(context);
  Navigator.pop(context);
}

_userChangeToInactiveError(BuildContext context, UserInactiveError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

// ignore: todo
//TODO View
class ReasonForm extends StatefulWidget {
  @override
  _ReasonFormState createState() => _ReasonFormState();
}

class _ReasonFormState extends State<ReasonForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            ManagerReasonTextField('Reason is required', 'Reason', _controller),
            SizedBox(
              height: 10,
            ),
            PrimaryButton(
              text: "Save",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  String userName;
                  var state = BlocProvider.of<UserDetailBloc>(context).state;
                  if (state is UserDetailLoaded) {
                    userName = state.user.userName;
                  }
                  BlocProvider.of<UserInactiveBloc>(context)
                      .add(UserChangeToInactive(userName, _controller.text));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ManagerReasonTextField extends StatelessWidget {
  ManagerReasonTextField(this._validate, this._labelText, this._controller);

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

// class ManagerInactiveSaveButton extends StatelessWidget {
//   final _formKey;
//   final TextEditingController _controller;
//   ManagerInactiveSaveButton(this._formKey, this._controller);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextButton(
//         style: TextButton.styleFrom(
//           primary: Colors.white,
//           backgroundColor: Colors.blue,
//         ),
//         onPressed: () {
//           if (_formKey.currentState.validate()) {
//             String userName;
//             var state = BlocProvider.of<UserDetailBloc>(context).state;
//             if (state is UserDetailLoaded) {
//               userName = state.user.userName;
//             }
//             BlocProvider.of<UserInactiveBloc>(context)
//                 .add(UserChangeToInactive(userName, _controller.text));
//           }
//         },
//         child: Text('Save'),
//       ),
//     );
//   }
// }
