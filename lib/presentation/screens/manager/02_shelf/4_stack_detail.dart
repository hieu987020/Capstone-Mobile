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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Stack Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          StackMenu(),
        ],
      ),
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
        child: MyScrollView(
          listWidget: [
            SizedBox(height: 10),
            TitleWithNothing(title: "About"),
            StackDetailInformation(size: size),
            TitleWithNothing(title: "Product"),
            ProductInside(),
            TitleWithNothing(title: "Emotion Camera"),
            CameraInside(),
          ],
        ),
      ),
    );
  }
}

_stackUpdateInsideError(BuildContext context, StackUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('App Message'),
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

_removeProduct(BuildContext context, String stackId, String productId,
    String productName) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove product'),
        content: Text('Are you sure to remove product $productName?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
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

_removeEmotionCamera(
    BuildContext context, String stackId, String cameraId, String cameraName) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove emotion camera'),
        content: Text('Are you sure to remove camera $cameraName?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
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

_stackChangeStatusDialog(BuildContext context, int statusId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change to Pending'),
        content: Text('The status will change to Pending, are you sure?'),
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
              var state = BlocProvider.of<StackDetailBloc>(context).state;
              if (state is StackDetailLoaded) {
                stackId = state.stack.stackId;
              }
              BlocProvider.of<StackUpdateInsideBloc>(context)
                  .add(StackChangeStatus(stackId, statusId, null));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class StackDetailInformation extends StatelessWidget {
  final Size size;
  StackDetailInformation({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StackDetailBloc, StackDetailState>(
      builder: (context, state) {
        if (state is StackDetailLoading) {
          return LoadingContainer();
        } else if (state is StackDetailLoaded) {
          var stack = state.stack;
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Container(
              constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailFieldContainerStatus(
                    fieldName: 'Status',
                    fieldValue: stack.statusName,
                  ),
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Position',
                    fieldValue: stack.position.toString(),
                  ),
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Created time',
                    fieldValue: stack.createTime,
                  ),
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Updated time',
                    fieldValue: stack.updatedTime,
                  ),
                  (stack.reasonInactive == null)
                      ? SizedBox(height: 0)
                      : DetailDivider(size: size),
                  (stack.reasonInactive == null)
                      ? SizedBox(height: 0)
                      : DetailFieldContainer(
                          fieldName: 'Reason Inactive',
                          fieldValue: stack.reasonInactive,
                        ),
                  DetailDivider(size: size),
                ],
              ),
            ),
          );
        } else if (state is StackDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
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
          return LoadingContainer();
        } else if (state is StackDetailLoaded) {
          if (state.stack.product == null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Text(
                                ("Add Product"),
                                style: TextStyle(
                                  color: Color.fromRGBO(69, 75, 102, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor.withOpacity(0.6),
                              ),
                              onPressed: () {
                                BlocProvider.of<ProductBloc>(context).add(
                                    ProductFetchEvent(StatusIntBase.Active));
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
              ),
            );
          } else {
            Product product = state.stack.product;
            return Padding(
              padding: EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                top: kDefaultPadding / 2,
              ),
              child: CounterListInkWell(
                model: 'camera',
                imageURL: product.imageUrl,
                title: product.productName,
                sub: product.description,
                status: "Active",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenProductDetailManager()),
                  );
                  BlocProvider.of<ProductDetailBloc>(context)
                      .add(ProductDetailFetchEvent(product.productId));
                },
                onRemove: () {
                  _removeProduct(
                    context,
                    state.stack.stackId,
                    product.productId,
                    product.productName,
                  );
                },
              ),
            );
          }
        }
        return UnmappedStateWidget();
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
          return LoadingContainer();
        } else if (state is StackDetailLoaded) {
          if (state.stack.camera == null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Text(
                                ("Add Emotion Camera"),
                                style: TextStyle(
                                  color: Color.fromRGBO(69, 75, 102, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor.withOpacity(0.6),
                              ),
                              onPressed: () {
                                BlocProvider.of<CameraBloc>(context).add(
                                    CameraAvailableEvent(
                                        StatusIntBase.Pending, 2));
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
              ),
            );
          } else {
            Camera camera = state.stack.camera;
            return Padding(
              padding: EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                top: kDefaultPadding / 2,
              ),
              child: CounterListInkWell(
                model: 'camera',
                imageURL: camera.imageUrl,
                title: camera.cameraName,
                sub: "Mac Address: " + camera.macAddress,
                status: "Active",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenCameraDetailManager()),
                  );
                  BlocProvider.of<ProductDetailBloc>(context)
                      .add(ProductDetailFetchEvent(camera.cameraId));
                },
                onRemove: () {
                  _removeEmotionCamera(context, state.stack.stackId,
                      camera.cameraId, camera.cameraName);
                },
              ),
            );
          }
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class StackMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Change to Inactive':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenStackInactive()));
          break;
        case 'Change to Pending':
          _stackChangeStatusDialog(context, StatusIntBase.Pending);
          break;
      }
    }

    return BlocBuilder<StackDetailBloc, StackDetailState>(
      builder: (context, state) {
        if (state is StackDetailLoaded) {
          if (state.stack.statusName.contains(StatusStringBase.Pending)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Change to Inactive',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.stack.statusName
              .contains(StatusStringBase.Inactive)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Change to Pending',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.stack.statusName.contains(StatusStringBase.Active)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Nothing',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          }
        }
        return PopupMenuButton<String>(
          onSelected: _handleClick,
          itemBuilder: (BuildContext context) {
            return {""}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      },
    );
  }
}
