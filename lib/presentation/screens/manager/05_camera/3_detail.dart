import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraDetailManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Camera Detail'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<CameraDetailBloc, CameraDetailState>(
        builder: (context, state) {
          if (state is CameraDetailLoading) {
            return LoadingWidget();
          } else if (state is CameraDetailLoaded) {
            return Text("");
          }
          //! Camera Detail : In failure state
          else if (state is CameraDetailError) {
            return FailureStateWidget();
          }
          //! Camera Detail : Unmapped state
          return UnmappedStateWidget();
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
