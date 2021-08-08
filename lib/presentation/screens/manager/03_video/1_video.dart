import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScreenVideoManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final _controller = VideoPlayerController.network(
    //   'https://storage.googleapis.com/capstone_storeage/videos/bdfe8984-d8ff-44c3-91f4-55f0d63d86b9-20210701-031548.mp4',
    // );
    var _type = TextEditingController();
    var _startDate = TextEditingController();
    var _endDate = TextEditingController();
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: ManagerNavigator(
          size: size,
          selectedIndex: 'Video',
        ),
        body: MyScrollView(
          listWidget: [
            HeaderWithSearchBox(
              size: size,
              title: "Hi Manager",
            ),
            TitleWithMoreBtn(
              title: 'Video',
              model: 'video',
              defaultStatus: StatusStringBase.All,
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CameraTypeRatio(controller: _type, defaultValue: 'Counter'),
                    DateTextField(
                      hintText: "Date of birth",
                      controller: _startDate,
                    ),
                    SizedBox(height: 5),
                    DateTextField(
                      hintText: "Date of birth",
                      controller: _endDate,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
