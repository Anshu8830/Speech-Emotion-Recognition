import 'dart:convert';

PredictedEmotion welcomeFromJson(String str) => PredictedEmotion.fromJson(json.decode(str));

String welcomeToJson(PredictedEmotion data) => json.encode(data.toJson());

class PredictedEmotion {
    PredictedEmotion({
        required this.emotion,
    });

    String emotion;

    factory PredictedEmotion.fromJson(Map<String, dynamic> json) => PredictedEmotion(
        emotion: json["emotion"],
    );

    Map<String, dynamic> toJson() => {
        "emotion": emotion,
    };
}

