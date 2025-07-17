import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/screens/auth_screens/intro_screen.dart';
import 'package:fourtyfourties/screens/main_screens/home_screen.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/play_store_512.png',
                  width: getSize(context).width * 0.5,
                  height: getSize(context).width * 0.5,
                ),
                Text(
                  "موسوعة الأربعين",
                  style: displayLarge.copyWith(color: whiteColor),
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 500))
          .animate(delay: const Duration(milliseconds: 500))
          .scale(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
          .animate(
            onComplete: (controller) async {
              if (kDebugMode) {
                print("Completed animation");
              }
              bool isFirstRun = await IsFirstRun.isFirstRun();
              if (context.mounted) {
                isFirstRun
                    ? Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => IntroScreen()),
                    )
                    : Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => HomeScreen()),
                    );
              }
            },
          )
          .fadeOut(
            delay: const Duration(milliseconds: 1500),
            duration: const Duration(milliseconds: 700),
          ),
    );
  }
}
