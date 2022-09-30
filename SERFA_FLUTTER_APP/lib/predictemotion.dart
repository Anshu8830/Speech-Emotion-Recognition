import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PredictEmotion extends StatelessWidget {
  String emotion;
  PredictEmotion(
    {
      required this.emotion
    }
  );

  final style = const TextStyle(
                  fontSize: 25.00,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(179, 32, 4, 38),
                ); 

  var printtext;
  var path;
  void text(String emotion) {
    if(emotion == 'neutral') {
      printtext = 'You are Neutral';
      path = 'assets/Predicted_Emojis/neutral.json';
    }
    else if(emotion == 'calm') {
      printtext = 'You are Calm';
      path = 'assets/Predicted_Emojis/calm.json';
    }
    else if(emotion == 'happy') {
      printtext = 'Yeah! Stay Happy, Stay Blessed';
      path = 'assets/Predicted_Emojis/happy.json';
    }
    else if(emotion == 'sad') {
      printtext = "Everything will be ok, Don't be sad";
      path = 'assets/Predicted_Emojis/sad.json';
    }
    else if(emotion == 'fear') {
      printtext = "God is with you, Don't be fear";
      path = 'assets/Predicted_Emojis/fear.json';
    }
    else if(emotion == 'disgust') {
      printtext = 'You feeling Disgust';
      path = 'assets/Predicted_Emojis/disgust.json';
    }
    else if(emotion == 'surprised') {
      printtext = 'We are also Surprised';
      path = 'assets/Predicted_Emojis/surprised.json';
    }
  }
  Widget EmotionBuilder(String emotion,String path) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            printtext,
            style: GoogleFonts.mochiyPopOne(
              textStyle: style,
            ), 
            textAlign: TextAlign.center,       
          ),
          const SizedBox(height: 10,),
          Lottie.asset(path),
        ],
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    text(emotion);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade300,
              Colors.blue.shade300,
              Colors.white70,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmotionBuilder(emotion,path),
            const SizedBox(height: 50),
            const Text(
              'Help us to Improve our Application',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 0, 6, 12),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Predicted Emotion is Correct?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 0, 6, 12),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  label: const Text('Yes'),
                  icon: const Icon(Icons.done),
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                ),
                const SizedBox(width: 20,),
                ElevatedButton.icon(
                  label: const Text('No'),
                  icon: const Icon(Icons.clear),
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}