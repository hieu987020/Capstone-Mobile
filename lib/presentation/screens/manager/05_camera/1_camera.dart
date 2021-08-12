import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraManager extends StatefulWidget {
  @override
  _ScreenCameraManagerState createState() => _ScreenCameraManagerState();
}

class _ScreenCameraManagerState extends State<ScreenCameraManager> {
  TextEditingController _valueSearch = TextEditingController(text: "");

  TextEditingController _statusId = TextEditingController(text: "");

  // String searchField = "fullName";

  String selectedValueStatus = "";

  @override
  void initState() {
    selectedValueStatus = 'All';
    _valueSearch.value = TextEditingValue(text: '');
    _statusId.value = TextEditingValue(text: '0');
    super.initState();
  }

  Future<Null> _onRefresh(BuildContext context) async {
    callApi();
  }

  callApi() {
    BlocProvider.of<CameraBloc>(context).add(CameraFetchEvent(
      storeId: "",
      cameraName: _valueSearch.text,
      statusId: int.parse(_statusId.text),
      fetchNext: 100,
      pageNum: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: RefreshIndicator(
        onRefresh: () async => _onRefresh(context),
        child: Scaffold(
          appBar: buildAppBar(),
          drawer: ManagerNavigator(
            size: size,
            selectedIndex: 'Camera',
          ),
          body: MyScrollView(
            listWidget: [
              HeaderWithSearchBox(
                size: size,
                title: "Hi Manager",
                valueSearch: _valueSearch,
                onSubmitted: (value) {
                  setState(() {
                    _valueSearch.value = TextEditingValue(text: value);
                  });
                  FocusScope.of(context).requestFocus(new FocusNode());
                  callApi();
                },
                onChanged: (value) {
                  setState(() {
                    _valueSearch.value = TextEditingValue(text: value);
                  });
                },
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  callApi();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    TitleWithCustomUnderline(text: "Camera"),
                    Spacer(),
                    StatusDropdown(
                      model: 'camera',
                      defaultValue: selectedValueStatus,
                      controller: _statusId,
                      callFunc: () {
                        callApi();
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<CameraBloc, CameraState>(
                builder: (context, state) {
                  if (state is CameraLoaded) {
                    return CameraContentManager2();
                  } else if (state is CameraError) {
                    return FailureStateWidget();
                  } else if (state is CameraLoading) {
                    return LoadingWidget();
                  }
                  return LoadingWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraContentManager2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Camera> cameras;
    var state = BlocProvider.of<CameraBloc>(context).state;
    if (state is CameraLoaded) {
      cameras = state.cameras;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                            builder: (context) => ScreenCameraDetailManager()),
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
              return ErrorRecordWidget();
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
