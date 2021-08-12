import 'package:equatable/equatable.dart';

class Hotspot extends Equatable {
  final String hotspotId;
  final String startedTime;
  final String description;
  final String createdTime;
  final String updatedTime;
  final int totalPeople;
  Hotspot({
    this.hotspotId,
    this.startedTime,
    this.description,
    this.createdTime,
    this.updatedTime,
    this.totalPeople,
  });

  @override
  List<Object> get props => [
        hotspotId,
        startedTime,
        description,
        createdTime,
        updatedTime,
        totalPeople,
      ];

  Hotspot copyWith({
    String hotspotId,
    String startedTime,
    String description,
    String createdTime,
    String updatedTime,
    int totalPeople,
  }) {
    return Hotspot(
      hotspotId: hotspotId ?? this.hotspotId,
      startedTime: startedTime ?? this.startedTime,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      totalPeople: totalPeople ?? this.totalPeople,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotspotId': hotspotId,
      'startedTime': startedTime,
      'description': description,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'totalPeople': totalPeople,
    };
  }

  factory Hotspot.fromJson(Map<String, dynamic> map) {
    return Hotspot(
      hotspotId: map['hotspotId'],
      startedTime: map['startedTime'],
      description: map['description'],
      createdTime: map['createdTime'],
      updatedTime: map['updatedTime'],
      totalPeople: map['totalPeople'],
    );
  }
}

class Emotion extends Equatable {
  final String emotionId;
  final String startTime;
  final String endTime;
  final String videoName;
  final int angry;
  final int disgust;
  final int fear;
  final int happy;
  final int sad;
  final int surprise;
  final int neutral;
  final String description;
  final String createdTime;
  final String updatedTime;
  Emotion({
    this.emotionId,
    this.startTime,
    this.endTime,
    this.videoName,
    this.angry,
    this.disgust,
    this.fear,
    this.happy,
    this.sad,
    this.surprise,
    this.neutral,
    this.description,
    this.createdTime,
    this.updatedTime,
  });

  @override
  List<Object> get props => [
        emotionId,
        startTime,
        endTime,
        videoName,
        angry,
        disgust,
        fear,
        happy,
        sad,
        surprise,
        neutral,
        description,
        createdTime,
        updatedTime,
      ];

  Emotion copyWith({
    String emotionId,
    String startTime,
    String endTime,
    String videoName,
    int angry,
    int disgust,
    int fear,
    int happy,
    int sad,
    int surprise,
    int neutral,
    String description,
    String createdTime,
    String updatedTime,
  }) {
    return Emotion(
      emotionId: emotionId ?? this.emotionId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      videoName: videoName ?? this.videoName,
      angry: angry ?? this.angry,
      disgust: disgust ?? this.disgust,
      fear: fear ?? this.fear,
      happy: happy ?? this.happy,
      sad: sad ?? this.sad,
      surprise: surprise ?? this.surprise,
      neutral: neutral ?? this.neutral,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emotionId': emotionId,
      'startTime': startTime,
      'endTime': endTime,
      'videoName': videoName,
      'angry': angry,
      'disgust': disgust,
      'fear': fear,
      'happy': happy,
      'sad': sad,
      'surprise': surprise,
      'neutral': neutral,
      'description': description,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
    };
  }

  factory Emotion.fromJson(Map<String, dynamic> map) {
    return Emotion(
      emotionId: map['emotionId'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      videoName: map['videoName'],
      angry: map['angry'],
      disgust: map['disgust'],
      fear: map['fear'],
      happy: map['happy'],
      sad: map['sad'],
      surprise: map['surprise'],
      neutral: map['neutral'],
      description: map['description'],
      createdTime: map['createdTime'],
      updatedTime: map['updatedTime'],
    );
  }
}

class Video extends Equatable {
  final String videoName;
  final String videoUrl;
  final String startedTime;
  final String endedTime;
  final String createdTime;
  final String updatedTime;
  final int statusId;
  final Hotspot hotspot;
  final Emotion emotion;
  Video({
    this.videoName,
    this.videoUrl,
    this.startedTime,
    this.endedTime,
    this.createdTime,
    this.updatedTime,
    this.statusId,
    this.hotspot,
    this.emotion,
  });

  @override
  List<Object> get props => [
        videoName,
        videoUrl,
        startedTime,
        endedTime,
        createdTime,
        updatedTime,
        statusId,
        hotspot,
        emotion,
      ];

  Video copyWith({
    String videoName,
    String videoUrl,
    String startedTime,
    String endedTime,
    String createdTime,
    String updatedTime,
    int statusId,
    Hotspot hotspot,
    Emotion emotion,
  }) {
    return Video(
      videoName: videoName ?? this.videoName,
      videoUrl: videoUrl ?? this.videoUrl,
      startedTime: startedTime ?? this.startedTime,
      endedTime: endedTime ?? this.endedTime,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      statusId: statusId ?? this.statusId,
      hotspot: hotspot ?? this.hotspot,
      emotion: emotion ?? this.emotion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoName': videoName,
      'videoUrl': videoUrl,
      'startedTime': startedTime,
      'endedTime': endedTime,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'statusId': statusId,
      // 'hotspot': hotspot.toJson(),
      // 'emotion': emotion.toJson(),
    };
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoName: json['videoName'],
      videoUrl: json['videoUrl'],
      startedTime: json['startedTime'],
      endedTime: json['endedTime'],
      createdTime: json['createdTime'],
      updatedTime: json['updatedTime'],
      statusId: json['statusId'],
      hotspot:
          json["hotSpot"] == null ? null : Hotspot.fromJson(json["hotSpot"]),
      //Hotspot.fromJson(map['hotSpot']),
      emotion:
          json["emotion"] == null ? null : Emotion.fromJson(json["emotion"]),
      //Emotion.fromJson(map['Emotion']),
    );
  }
}
