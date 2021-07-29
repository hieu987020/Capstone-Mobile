import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Scaffold(
      appBar: buildAppBar(),
      drawer: AdminNavigator(
        size: size,
        selectedIndex: 'Camera',
      ),
      floatingActionButton: AddFloatingButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenCameraCreate()));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderWithSearchBox(size),
                TitleWithMoreBtn(
                  title: 'List Cameras',
                  model: 'camera',
                ),
                BlocBuilder<CameraBloc, CameraState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is CameraLoaded) {
                      return CameraContent();
                    } else if (state is CameraError) {
                      return FailureStateWidget();
                    } else if (state is CameraLoading) {
                      return LoadingWidget();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CameraContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Camera> cameras;
    var state = BlocProvider.of<CameraBloc>(context).state;
    if (state is CameraLoaded) {
      cameras = state.cameras;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: FutureBuilder<List<Camera>>(
          initialData: cameras,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Camera> cameraLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cameraLst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'camera',
                    imageURL: cameraLst[index].imageUrl,
                    title: cameraLst[index].cameraName,
                    sub: cameraLst[index].storeName ?? "-",
                    status: cameraLst[index].statusName,
                    navigationField: cameraLst[index].cameraId,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenCameraDetail()),
                      );
                      BlocProvider.of<CameraDetailBloc>(context).add(
                          CameraDetailFetchEvent(cameraLst[index].cameraId));
                    },
                  );
                },
              );
            } else if (snapshot.data == null) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return Text("No Record: ${snapshot.error}");
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
