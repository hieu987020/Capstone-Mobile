import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Camera'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenCameraSearch()));
            },
          )
        ],
      ),
      drawer: ManagerNavigator(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenCameraCreate()));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Stack(
        children: [
          BlocBuilder<CameraBloc, CameraState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is CameraLoaded) {
                return CameraContentManager();
              } else if (state is CameraError) {
                return FailureStateWidget();
              } else if (state is CameraLoading) {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class CameraContentManager extends StatefulWidget {
  @override
  _CameraContentManagerState createState() => _CameraContentManagerState();
}

class _CameraContentManagerState extends State<CameraContentManager> {
  @override
  Widget build(BuildContext context) {
    List<Camera> cameras;
    var state = BlocProvider.of<CameraBloc>(context).state;
    if (state is CameraLoaded) {
      cameras = state.cameras;
    }
    Future<Null> _onCameraRefresh(BuildContext context) async {
      BlocProvider.of<CameraBloc>(context)
          .add(CameraFetchEvent(StatusIntBase.All));
      setState(() {
        cameras.clear();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onCameraRefresh(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
        child: FutureBuilder<List<Camera>>(
          initialData: cameras,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Camera> cameraLst = snapshot.data;
              return ListView.builder(
                itemCount: cameraLst.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cameraLst[index].imageUrl),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(cameraLst[index].cameraName),
                    subtitle: Text(cameraLst[index].ipAddress),
                    trailing: StatusText(cameraLst[index].statusName),
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

class CameraStatusDropdownManager extends StatefulWidget {
  @override
  _CameraStatusDropdownManagerState createState() =>
      _CameraStatusDropdownManagerState();
}

class _CameraStatusDropdownManagerState
    extends State<CameraStatusDropdownManager> {
  String dropdownValue = "All";
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
        if (newValue == "Active") {
          BlocProvider.of<CameraBloc>(context)
              .add(CameraFetchEvent(StatusIntBase.Active));
        } else if (newValue == "Pending") {
          BlocProvider.of<CameraBloc>(context)
              .add(CameraFetchEvent(StatusIntBase.Pending));
        } else if (newValue == "Inactive") {
          BlocProvider.of<CameraBloc>(context)
              .add(CameraFetchEvent(StatusIntBase.Inactive));
        } else if (newValue == "All") {
          BlocProvider.of<CameraBloc>(context)
              .add(CameraFetchEvent(StatusIntBase.All));
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
