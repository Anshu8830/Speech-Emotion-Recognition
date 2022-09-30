import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

import 'timer.dart';
import 'model.dart';
import 'predictemotion.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {

  var predictedoutputemotion;
  final timeController = TimerController();
  Record record = Record();
  bool recording = false;
  bool playing = false;
  AudioPlayer audioPlayer = AudioPlayer();
  late String path, location;
  

  @override
  void initState() {
    super.initState();
    getDirectory();
  }

  Future<void> getDirectory() async {
    if (Platform.isAndroid) {
      Directory? directory = await getTemporaryDirectory();
      if (directory != null) {
        path = directory.path;
        print(path);
        location = path+'/audio'+'.wav';
      }
    }
  }

  Future<void> startRecording() async {
    bool result = await record.hasPermission();
    if (result) {
      setState(() {
        recording = true;
      });
      await record.start(
        path: location, // required
        encoder: AudioEncoder.wav, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
    }
  }  
  
  Future<void> stopRecording() async {
    await record.stop();
    recording = false;
    setState(() {});
    print(location);
  }

  uploadfile() async{
    var request = http.MultipartRequest("POST", Uri.parse("https://anshu8830.pythonanywhere.com/predict"));
    var audiofileinput = await http.MultipartFile.fromPath("file", '/data/user/0/com.example.audio_rec/cache/audio.wav');
    request.files.add(audiofileinput);
    final response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var outputemotion = welcomeFromJson(responseString);
    predictedoutputemotion = outputemotion.emotion;
    print(predictedoutputemotion);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PredictEmotion(emotion: predictedoutputemotion)
      )
    );
  }

    var  icon = Icons.mic;
    var  text = 'START';
    var  primary =Colors.indigo.shade900.withBlue(70);
    var  onPrimary = Colors.white;

  void MicButton(bool recording) {
    if(!recording) {
      icon = Icons.stop;
      text = 'STOP RECORDING';
      primary = Colors.red.shade400; 
      onPrimary = Colors.white;
    }
    else {
      icon = Icons.mic;
      text = 'START RECORDING';
      primary =Colors.indigo.shade900.withBlue(70);
      onPrimary = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade300,
              Colors.blue.shade300,
              Colors.purple.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(60),
          children : <Widget>[ 
            AvatarGlow(
              endRadius: 140,
              animate: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 92,
                  backgroundColor: Colors.indigo.shade900.withBlue(70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mic, size: 32),
                      TimerWidget(controller: timeController),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 50),
                primary: primary,
                onPrimary: onPrimary,
              ), 
              icon: Icon(icon), 
              label: Text(
                text,
                style:  const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                MicButton(recording);
                //start recording
                if (recording) {
                  stopRecording();
                  timeController.stopTimer();
                } 
                else {
                  startRecording();
                  timeController.startTimer();
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo.shade900.withBlue(70),
                minimumSize: const Size(50, 50),
              ),
              onPressed: () {
                uploadfile();
              },
              child: const Text(
                'Predict Emotion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }

  Future<void> playAudio() async {
    int result = await audioPlayer.play(location, isLocal: true);
    print(result);
    if(result == 1){
      playing = true;
      setState(() {});
    }
  }

  Future<void> pauseAudio() async {
    int result = await audioPlayer.pause();
    if(result == 1){
      playing = false;
      setState(() {});
    }
  }
}