import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreInactive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Reason Inactive'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: MyScrollView(
        listWidget: [StoreReasonForm()],
      ),
    );
  }
}

class StoreReasonForm extends StatefulWidget {
  @override
  _StoreReasonFormState createState() => _StoreReasonFormState();
}

class _StoreReasonFormState extends State<StoreReasonForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            ReasonTextField('Reason is required', 'Reason', _controller),
            SizedBox(
              height: 10,
            ),
            PrimaryButton(
              text: "Save",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  String storeId;
                  var state = BlocProvider.of<StoreDetailBloc>(context).state;
                  if (state is StoreDetailLoaded) {
                    storeId = state.store.storeId;
                  }
                  BlocProvider.of<StoreUpdateInsideBloc>(context).add(
                      StoreChangeStatus(
                          storeId, StatusIntBase.Inactive, _controller.text));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
