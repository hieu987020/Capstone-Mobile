import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreUpdateImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Change Image'),
      body: BlocListener<StoreUpdateImageBloc, StoreUpdateImageState>(
        listener: (context, state) {
          if (state is StoreUpdateImageLoading) {
            loadingCommon(context);
          } else if (state is StoreUpdateImageError) {
            _storeUpdateImageError(context, state);
          } else if (state is StoreUpdateImageLoaded) {
            _storeUpdateImageLoaded(context, state);
          }
        },
        child: UpdateImage(
          model: 'store',
        ),
      ),
    );
  }
}

_storeUpdateImageError(BuildContext context, StoreUpdateImageError state) {
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

_storeUpdateImageLoaded(BuildContext context, StoreUpdateImageLoaded state) {
  String storeId;
  var storeDetailState = BlocProvider.of<StoreDetailBloc>(context).state;
  if (storeDetailState is StoreDetailLoaded) {
    storeId = storeDetailState.store.storeId;
  }
  BlocProvider.of<StoreDetailBloc>(context).add(StoreDetailFetchEvent(storeId));
  Navigator.pop(context);
  Navigator.pop(context);
}
