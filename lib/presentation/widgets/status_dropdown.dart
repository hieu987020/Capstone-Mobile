import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusDropdown extends StatefulWidget {
  final Function onChange;
  final String model;
  StatusDropdown({this.onChange, this.model});

  @override
  State<StatusDropdown> createState() => StatusDropdownState(onChange, model);
}

class StatusDropdownState extends State<StatusDropdown> {
  final Function onChanged;
  final String model;
  String dropdownValue = "All";

  StatusDropdownState(this.onChanged, this.model);
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 15,
      iconEnabledColor: Colors.black,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        if (model == 'manager') {
          if (newValue == "Active") {
            BlocProvider.of<UserBloc>(context)
                .add(UserFetchEvent(StatusIntBase.Active));
          } else if (newValue == "Pending") {
            BlocProvider.of<UserBloc>(context)
                .add(UserFetchEvent(StatusIntBase.Pending));
          } else if (newValue == "Inactive") {
            BlocProvider.of<UserBloc>(context)
                .add(UserFetchEvent(StatusIntBase.Inactive));
          } else if (newValue == "All") {
            BlocProvider.of<UserBloc>(context)
                .add(UserFetchEvent(StatusIntBase.All));
          }
        } else if (model == 'store') {
          if (newValue == "Active") {
            BlocProvider.of<StoreBloc>(context)
                .add(StoreFetchEvent(StatusIntBase.Active));
          } else if (newValue == "Pending") {
            BlocProvider.of<StoreBloc>(context)
                .add(StoreFetchEvent(StatusIntBase.Pending));
          } else if (newValue == "Inactive") {
            BlocProvider.of<StoreBloc>(context)
                .add(StoreFetchEvent(StatusIntBase.Inactive));
          } else if (newValue == "All") {
            BlocProvider.of<StoreBloc>(context)
                .add(StoreFetchEvent(StatusIntBase.All));
          }
        } else if (model == 'product') {
          if (newValue == "Active") {
            BlocProvider.of<ProductBloc>(context)
                .add(ProductFetchEvent(StatusIntBase.Active));
          } else if (newValue == "Inactive") {
            BlocProvider.of<ProductBloc>(context)
                .add(ProductFetchEvent(StatusIntBase.Inactive));
          } else if (newValue == "All") {
            BlocProvider.of<ProductBloc>(context)
                .add(ProductFetchEvent(StatusIntBase.All));
          }
        } else if (model == 'camera') {
          if (newValue == "Active") {
            BlocProvider.of<CameraBloc>(context)
                .add(CameraFetchEvent(StatusIntBase.Active));
          } else if (newValue == "Pending") {
            // BlocProvider.of<CameraBloc>(context)
            //     .add(CameraFetchEvent(StatusIntBase.Pending));
          } else if (newValue == "Inactive") {
            BlocProvider.of<CameraBloc>(context)
                .add(CameraFetchEvent(StatusIntBase.Inactive));
          } else if (newValue == "All") {
            BlocProvider.of<CameraBloc>(context)
                .add(CameraFetchEvent(StatusIntBase.All));
          }
        } else if (model == 'category') {
          if (newValue == "Active") {
            BlocProvider.of<CategoryBloc>(context)
                .add(CategoryFetchEvent(StatusIntBase.Active));
          } else if (newValue == "Pending") {
            BlocProvider.of<CategoryBloc>(context)
                .add(CategoryFetchEvent(StatusIntBase.Pending));
          } else if (newValue == "Inactive") {
            BlocProvider.of<CategoryBloc>(context)
                .add(CategoryFetchEvent(StatusIntBase.Inactive));
          } else if (newValue == "All") {
            BlocProvider.of<CategoryBloc>(context)
                .add(CategoryFetchEvent(StatusIntBase.All));
          }
        }
      },
      items: <String>['All', 'Active', 'Pending', 'Inactive']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
