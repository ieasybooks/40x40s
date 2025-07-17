import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:fourtyfourties/screens/main_screens/about_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, theme, _) {
        return Scaffold(
          body: Column(
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

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "الإعدادات",
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
                                          ? whiteInDark
                                          : whiteInDark.withValues(alpha: 0.05),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    theme.isDark
                                        ? "الوضع النهاري"
                                        : "الوضع الليلي",
                                    style: displaySmall.copyWith(
                                      color:
                                          theme.isDark
                                              ? whiteColor
                                              : blackColor,
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: theme.isDark,
                                    onChanged: (v) {
                                      theme.switchMode();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => AboutScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      theme.isDark ? whiteInDark : whiteColor,
                                  borderRadius: roundedRadius,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          theme.isDark
                                              ? whiteInDark
                                              : whiteInDark.withValues(
                                                alpha: 0.05,
                                              ),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color:
                                            theme.isDark
                                                ? whiteColor
                                                : blackColor,
                                      ),

                                      Text(
                                        "عن التطبيق",
                                        style: labelLarge.copyWith(
                                          color:
                                              theme.isDark
                                                  ? whiteColor
                                                  : blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                SharePlus.instance.share(
                                  // TODO ADD LINKS HERE
                                  ShareParams(
                                    text: "ANDROIDLINK \n IOSLINK",
                                    subject: "40x40",
                                    sharePositionOrigin: Rect.fromLTWH(
                                      0,
                                      0,
                                      100,
                                      100,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      theme.isDark ? whiteInDark : whiteColor,
                                  borderRadius: roundedRadius,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          theme.isDark
                                              ? whiteInDark
                                              : whiteInDark.withValues(
                                                alpha: 0.05,
                                              ),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    children: [
                                      Icon(
                                        Icons.share,
                                        color:
                                            theme.isDark
                                                ? whiteColor
                                                : blackColor,
                                      ),

                                      Text(
                                        "مشاركة التطبيق",
                                        style: labelLarge.copyWith(
                                          color:
                                              theme.isDark
                                                  ? whiteColor
                                                  : blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
