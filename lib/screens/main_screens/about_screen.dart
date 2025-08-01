import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, theme, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: whiteColor),
                        child: Image.asset(
                          "assets/play_store_512.png",
                          width: getSize(context).width * 0.16,
                          height: getSize(context).width * 0.16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(CupertinoIcons.chevron_back),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "عن التطبيق",
                            style: displayMedium.copyWith(
                              color: theme.isDark ? whiteColor : blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: theme.isDark ? whiteInDark : whiteColor,
                          borderRadius: roundedRadius,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  theme.isDark
                                      ? whiteInDark.withValues(alpha: 0.0)
                                      : whiteInDark.withValues(alpha: 0.05),
                              spreadRadius: 5,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        getSize(context).width * 0.05,
                                      ),
                                      child: Image.asset(
                                        "assets/moyassarahBooks.png",
                                        width: getSize(context).width * 0.2,
                                        height: getSize(context).width * 0.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),

                              Text(
                                "أحد منتجات مشروع الكتب الميسرة",
                                style: displayMedium.copyWith(
                                  color: theme.isDark ? whiteColor : blackColor,
                                ),
                              ),
                              SizedBox(height: 24),

                              // TODO ADD REAL DESCRIPTION
                              Text(
                                "تطبيق يهدف إلى تسهيل الوصول إلى الأحاديث النبوية الشريفة بطريقة ميسرة وسهلة الاستخدام تطبيق يهدف إلى تسهيل الوصول إلى الأحاديث النبوية الشريفة بطريقة ميسرة وسهلة الاستخدام تطبيق يهدف إلى تسهيل الوصول إلى الأحاديث النبوية الشريفة بطريقة ميسرة وسهلة الاستخدام تطبيق يهدف إلى تسهيل الوصول إلى الأحاديث النبوية الشريفة بطريقة ميسرة وسهلة الاستخدام تطبيق يهدف إلى تسهيل الوصول إلى الأحاديث النبوية الشريفة بطريقة ميسرة وسهلة الاستخدام تطبيق يهدف إلى تسهيل الوصول إلى الأحاديث النبوية الشريفة بطريقة ميسرة وسهلة الاستخدام.",
                                style: labelLarge.copyWith(
                                  color: theme.isDark ? whiteColor : blackColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
