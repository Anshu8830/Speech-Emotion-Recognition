import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'audioRecord.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final style = const TextStyle(
                  fontSize: 25.00,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SERFA',
          style: GoogleFonts.mochiyPopOne(
            textStyle: style,
          ),
        ),
        leading: Lottie.asset('assets/splash.json'),
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue,Colors.purple],
              begin: Alignment.topLeft
              ),
            ),
          ),
      ),
      body: AudioRecorder(),
    );
  }
}