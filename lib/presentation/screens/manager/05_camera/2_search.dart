import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraSearchAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CameraSearchFormManager(),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlocBuilder<CameraBloc, CameraState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is CameraLoaded) {
                return CameraSearchContentManager();
              } else if (state is CameraError) {
                return FailureStateWidget();
              } else if (state is CameraLoading) {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}

// //! Camera : Search Form
class CameraSearchFormManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    //final String _labelText = "Search by cameraname";
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // labelText: _labelText,
              contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
            ),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              BlocProvider.of<CameraBloc>(context)
                  .add(CameraSearchEvent(_controller.text));
              print("========================\n");
              print(_controller.text);
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }
}

class CameraSearchContentManager extends StatefulWidget {
  @override
  _CameraSearchContentManagerState createState() =>
      _CameraSearchContentManagerState();
}

class _CameraSearchContentManagerState
    extends State<CameraSearchContentManager> {
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
                    subtitle: Text(cameraLst[index].cameraName),
                    trailing: StatusText(cameraLst[index].statusName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenCameraDetailManager()),
                      );
                      BlocProvider.of<CameraDetailBloc>(context).add(
                          CameraDetailFetchEvent(cameraLst[index].cameraName));
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
