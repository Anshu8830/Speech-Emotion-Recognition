import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'homepage.dart';

class SplashScreen extends StatelessWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  final style = const TextStyle(
                  fontSize: 35.00,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                );

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: HomePage(),
      centered: true,
      splashIconSize: 500,
      backgroundColor: Colors.purple,
      splash: ListView(
        children: [
          Lottie.asset('assets/splash.json'),
          const SizedBox(width: 5,),
          Center(
            child: Text('SERFA',
              style: GoogleFonts.mochiyPopOne(
                textStyle: style,
              ),
            ),
          ),
        ],
      ), 
      duration: 3000,
      animationDuration: const Duration(seconds: 1),
      splashTransition: SplashTransition.decoratedBoxTransition,
    );
  }
}