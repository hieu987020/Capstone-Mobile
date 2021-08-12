import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  VideoApp({this.video});

  final Video video;
  @override
  _VideoAppState createState() => _VideoAppState(video);
}

class _VideoAppState extends State<VideoApp> {
  _VideoAppState(this.video);
  final Video video;

  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(video.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      placeholder: Container(
        color: kPrimaryColor.withOpacity(0.3),
      ),
      // autoInitialize: true,
    );

    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video Ended');
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int totalEmotion = 0;
    if (video.emotion != null) {
      Emotion emotion = video.emotion;
      totalEmotion = emotion.angry +
          emotion.disgust +
          emotion.fear +
          emotion.happy +
          emotion.sad +
          emotion.surprise +
          emotion.neutral;
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Play Video'),
      body: MyScrollView(
        listWidget: [
          SizedBox(
            height: 300,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          SizedBox(height: 5),
          Container(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailFieldContainer(
                  fieldName: 'Video Name',
                  fieldValue: video.videoName,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Start Time',
                  fieldValue: video.startedTime,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'End Time',
                  fieldValue: video.endedTime,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Upload Time',
                  fieldValue: video.updatedTime,
                ),
                DetailDivider(size: size),
                (video.hotspot != null)
                    ? DetailFieldContainer(
                        fieldName: 'Total People ',
                        fieldValue: video.hotspot.totalPeople.toString(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EmotionText(title: "Angry"),
                          EmotionCapture(
                            count: video.emotion.angry,
                            total: totalEmotion,
                            size: size,
                          ),
                          DetailDivider(size: size),
                          EmotionText(title: "Disgust"),
                          EmotionCapture(
                            count: video.emotion.disgust,
                            total: totalEmotion,
                            size: size,
                          ),
                          DetailDivider(size: size),
                          EmotionText(title: "Fear"),
                          EmotionCapture(
                            count: video.emotion.fear,
                            total: totalEmotion,
                            size: size,
                          ),
                          DetailDivider(size: size),
                          EmotionText(title: "Happy"),
                          EmotionCapture(
                            count: video.emotion.happy,
                            total: totalEmotion,
                            size: size,
                          ),
                          DetailDivider(size: size),
                          EmotionText(title: "Sad"),
                          EmotionCapture(
                            count: video.emotion.sad,
                            total: totalEmotion,
                            size: size,
                          ),
                          DetailDivider(size: size),
                          EmotionText(title: "Surprise"),
                          EmotionCapture(
                            count: video.emotion.surprise,
                            total: totalEmotion,
                            size: size,
                          ),
                          DetailDivider(size: size),
                          EmotionText(title: "Neutral"),
                          EmotionCapture(
                            count: video.emotion.neutral,
                            total: totalEmotion,
                            size: size,
                          ),
                        ],
                      ),
                DetailDivider(size: size),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmotionCapture extends StatelessWidget {
  EmotionCapture(
      {@required this.count, @required this.total, @required this.size});
  final int count;
  final int total;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                color: Colors.grey[200],
                height: 30,
                child: Row(
                  children: [
                    Container(
                      width:
                          MediaQuery.of(context).size.width * (count / total),
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: 25,
            alignment: Alignment.centerLeft,
            child: Text(count.toString()),
          ),
        ],
      ),
    );
  }
}

class EmotionText extends StatelessWidget {
  EmotionText({@required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
