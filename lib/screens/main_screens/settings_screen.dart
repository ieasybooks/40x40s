import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

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

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
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
                    ListTile(title: Text("الوضع الليلي")),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.info_outline),

                                Text("عن التطبيق", style: labelLarge),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Icon(Icons.share),

                                Text("مشاركة التطبيق", style: labelLarge),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
