import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/screens/main_screens/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        titleWidget: Text(
          "مجموعة من الأحاديث النبوية المجمعة من كتب الأربعين",
          style: displayLarge.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
        ),
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("")],
        ),
        image: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: whiteColor,
          ),
          width: getSize(context).width * 0.33,
          height: getSize(context).width * 0.33,
          child: Transform.scale(
            scale: 1,
            child: Image.asset("assets/green40.png", fit: BoxFit.cover),
          ),
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          "تقدم إليك كتطبيق هاتف سهل الإستخدام والتعامل",
          style: displayLarge.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
        ),
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("")],
        ),
        image: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: whiteColor,
          ),
          width: getSize(context).width * 0.33,
          height: getSize(context).width * 0.33,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/handPhone.png",
              fit: BoxFit.cover,
              color: greenColor,
            ),
          ),
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          "أحد منتجات مشروع الكتب الميسرة",
          style: displayLarge.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
        ),

        bodyWidget: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(context).width * 0.15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "الذي يهدف إلى تسهيل وصول المسلمين إلى الكتب الإسلامية الأساسية",
                  style: displaySmall.copyWith(color: whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        image: Container(
          width: getSize(context).width * 0.33,
          height: getSize(context).width * 0.33,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: whiteColor,
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/moyassarahBooks.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: greenColor,

      body: Directionality(
        textDirection: TextDirection.rtl,

        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(color: whiteColor),
                    child: Image.asset(
                      "assets/green40.png",
                      width: getSize(context).width * 0.2,
                      height: getSize(context).width * 0.2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IntroductionScreen(
                dotsFlex: 1,
                controlsPadding: EdgeInsets.symmetric(vertical: 16),
                globalBackgroundColor: greenColor,
                showBackButton: true,
                showBottomPart: true,
                showNextButton: true,
                showSkipButton: true,

                pages: pages,
                skip: Text(
                  "تخطي",
                  style: displaySmall.copyWith(color: whiteColor),
                ),

                // done: Text(
                //   "بدء الإستخدام",
                //   style: displaySmall.copyWith(color: whiteColor),
                // ),
                next: Text(
                  "التالي",
                  style: displaySmall.copyWith(color: whiteColor),
                ),
                back: Text(
                  "تراجع",
                  style: displaySmall.copyWith(color: whiteColor),
                ),

                dotsDecorator: DotsDecorator(
                  // size: const Size(10.0, 10.0),
                  // activeSize: const Size(30.0, 10.0),
                  // fadeOutSize: const Size(10.0, 10.0),
                  sizes: [
                    const Size(10.0, 10.0),
                    const Size(10.0, 10.0),
                    const Size(10.0, 10.0),
                  ],
                  activeColors: [whiteColor, whiteColor, whiteColor],
                  activeSizes: [
                    Size(25.0, 10.0),
                    Size(25.0, 10.0),
                    Size(25.0, 10.0),
                  ],
                  colors: [
                    whiteColor.withValues(alpha: 0.5),
                    whiteColor.withValues(alpha: 0.5),
                    whiteColor.withValues(alpha: 0.5),
                  ],
                  activeShapes: [
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ],

                  spacing: const EdgeInsets.symmetric(horizontal: 2.0),

                  // activeColors: [whiteColor, whiteColor.withValues(alpha: 0.5)],
                  // spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                ),
                showDoneButton: true,

                overrideDone: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "بدء الإستخدام",
                          style: displayMedium.copyWith(
                            color: blackColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
