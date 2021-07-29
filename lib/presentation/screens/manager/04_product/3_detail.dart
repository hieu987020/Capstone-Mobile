import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductDetailManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Product Detail'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return LoadingWidget();
          } else if (state is ProductDetailLoaded) {
            return Text("");
          }
          //! Product Detail : In failure state
          else if (state is ProductDetailError) {
            return FailureStateWidget();
          }
          //! Product Detail : Unmapped state
          return UnmappedStateWidget();
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
