import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScreenVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _controller = VideoPlayerController.network(
    //   'https://storage.googleapis.com/capstone_storeage/videos/bdfe8984-d8ff-44c3-91f4-55f0d63d86b9-20210701-031548.mp4',
    // );
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Shelf'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ScreenShelfSearch()));
            },
          )
        ],
      ),
      drawer: ManagerNavigator(),
    );
  }
}
