import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/common_widget.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStackDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Stack detail'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocListener<StackUpdateInsideBloc, StackUpdateInsideState>(
        listener: (context, state) {
          if (state is StackUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is StackUpdateInsideError) {
            _stackUpdateInsideError(context, state);
          } else if (state is StackUpdateInsideLoaded) {
            _stackUpdateInsideLoaded(context);
          }
        },
        child: StackDetailView(),
      ),
    );
  }
}

// ignore: todo
//TODO Stuff
_stackUpdateInsideError(BuildContext context, StackUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error notification'),
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

_stackUpdateInsideLoaded(BuildContext context) {
  String stackId;
  var state = BlocProvider.of<StackDetailBloc>(context).state;
  if (state is StackDetailLoaded) {
    stackId = state.stack.stackId;
  }
  BlocProvider.of<StackDetailBloc>(context).add(StackDetailFetchEvent(stackId));
  Navigator.pop(context);
}

_removeProduct(BuildContext context) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove product'),
        content: Text('Are you sure to remove this product'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String stackId;
              String productId;
              var state = BlocProvider.of<StackDetailBloc>(context).state;
              if (state is StackDetailLoaded) {
                stackId = state.stack.stackId;
                productId = state.stack.product.productId;
              }
              BlocProvider.of<StackUpdateInsideBloc>(context)
                  .add(StackMapProductEvent(stackId, productId, 2));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_removeEmotionCamera(BuildContext context) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove emotion camera'),
        content: Text('Are you sure to remove this camera'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String stackId;
              String cameraId;
              var state = BlocProvider.of<StackDetailBloc>(context).state;
              if (state is StackDetailLoaded) {
                stackId = state.stack.stackId;
                cameraId = state.stack.camera.cameraId;
              }
              BlocProvider.of<StackUpdateInsideBloc>(context)
                  .add(StackMapCameraEvent(stackId, cameraId, 2));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

//! View
class StackDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          StackDetailInformation(),
          ProductInside(),
          CameraInside(),
        ],
      ),
    );
  }
}

class StackDetailInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StackDetailBloc, StackDetailState>(
      builder: (context, state) {
        if (state is StackDetailLoading) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingWidget(),
                ],
              ),
            ),
          );
        } else if (state is StackDetailLoaded) {
          StackModel stack = state.stack;
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 150,
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.025,
                MediaQuery.of(context).size.width * 0.025,
                MediaQuery.of(context).size.width * 0.025,
                MediaQuery.of(context).size.width * 0.025,
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SDBodyTitleText(
                          "Stack Position " + stack.position.toString()),
                      StatusText(stack.statusName),
                    ],
                  ),
                  SDBodyFieldnameText("Created Time"),
                  SDBodyContentText(stack.createTime),
                  SDBodyFieldnameText("Updated Time"),
                  SDBodyContentText(stack.updatedTime),
                ],
              ),
            ),
          );
        } else if (state is StackDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class ProductInside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StackDetailBloc, StackDetailState>(
      builder: (context, state) {
        if (state is StackDetailLoading) {
          return Container(
            height: 200,
            child: LoadingWidget(),
          );
        } else if (state is StackDetailLoaded) {
          if (state.stack.product == null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 50,
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SDBodyTitleText("Add Product"),
                        Container(
                          width: 50,
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.grey[500],
                            ),
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(ProductFetchEvent(StatusIntBase.Active));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenStackMapProduct()));
                            },
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            Product product = state.stack.product;
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 200,
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SDBodyTitleText(product.productName),
                        ProductInsideMenu(),
                      ],
                    ),
                    SDBodyFieldnameText("Description"),
                    SDBodyContentText(product.description),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      height: 100,
                      child: Image.network(product.imageUrl),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class ProductInsideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String productId;
    Camera camera;
    var state = BlocProvider.of<StackDetailBloc>(context).state;
    if (state is StackDetailLoaded) {
      productId = state.stack.product.productId;
      camera = state.stack.camera;
    }

    _handleClick(String value) {
      switch (value) {
        case 'View Detail':
          BlocProvider.of<ProductDetailBloc>(context)
              .add(ProductDetailFetchEvent(productId));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenProductDetailManager()));
          break;

        case 'Remove':
          _removeProduct(context);
          break;
      }
    }

    return PopupMenuButton<String>(
      onSelected: _handleClick,
      itemBuilder: (BuildContext context) {
        return {'View Detail', 'Remove'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}

class CameraInside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StackDetailBloc, StackDetailState>(
      builder: (context, state) {
        if (state is StackDetailLoading) {
          return Container(
            height: 200,
            child: LoadingWidget(),
          );
        } else if (state is StackDetailLoaded) {
          if (state.stack.camera == null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 50,
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SDBodyTitleText("Add Camera"),
                        state.stack.product == null
                            ? Text("")
                            : Container(
                                width: 50,
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.grey[500],
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<CameraBloc>(context).add(
                                        CameraFetchEvent(
                                            StatusIntBase.Pending));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScreenStackMapCamera()));
                                  },
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            Camera camera = state.stack.camera;
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 200,
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SDBodyTitleText(camera.cameraName),
                        CameraInsideMenu(),
                      ],
                    ),
                    SDBodyFieldnameText("IP Address"),
                    SDBodyContentText(camera.ipAddress),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      height: 100,
                      child: Image.network(camera.imageUrl),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class CameraInsideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'View Detail':
          String cameraId;
          var state = BlocProvider.of<ShelfDetailBloc>(context).state;
          if (state is ShelfDetailLoaded) {
            cameraId = state.shelf.camera.first.cameraId;
          }
          BlocProvider.of<CameraDetailBloc>(context)
              .add(CameraDetailFetchEvent(cameraId));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCameraDetailManager()));
          break;

        case 'Remove':
          _removeEmotionCamera(context);
          break;
      }
    }

    return PopupMenuButton<String>(
      onSelected: _handleClick,
      itemBuilder: (BuildContext context) {
        return {'View Detail', 'Remove'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
