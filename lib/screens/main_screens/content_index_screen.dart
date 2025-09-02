import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/model/encyclopedia_model.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:fourtyfourties/providers/encyclopedia_provider.dart';
import 'package:fourtyfourties/screens/main_screens/settings_screen.dart';
import 'package:provider/provider.dart';

class ContentIndexScreen extends StatefulWidget {
  const ContentIndexScreen({super.key});

  @override
  State<ContentIndexScreen> createState() => _ContentIndexScreenState();
}

class _ContentIndexScreenState extends State<ContentIndexScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<EncyclopediaProvider, DarkThemeProvider>(
      builder: (context, encyclopediaProvider, theme, _) {
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
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
                        child: TextField(
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: searchController,
                          style: labelLarge.copyWith(
                            color: theme.isDark ? whiteColor : blackColor,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: AnimatedSwitcher(
                                duration: 300.ms,
                                child: Icon(
                                  searchController.text.isNotEmpty
                                      ? Icons.close
                                      : Icons.search,
                                  color:
                                      theme.isDark
                                          ? whiteColor.withValues(alpha: 0.7)
                                          : blackColor.withValues(alpha: 0.7),
                                ),
                              ),
                              onPressed: () {
                                if (searchController.text.isNotEmpty) {
                                  searchController.clear();
                                  setState(() {});
                                }
                              },
                            ),
                            hintText: "البحث في المحتويات",
                            hintStyle: labelLarge.copyWith(
                              color:
                                  theme.isDark
                                      ? whiteColor.withValues(alpha: 0.5)
                                      : blackColor.withValues(alpha: 0.5),
                            ),
                            labelStyle: labelLarge.copyWith(
                              color: theme.isDark ? whiteColor : blackColor,
                            ),

                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "فهرس المحتويات",
                            style: displayMedium.copyWith(
                              color: theme.isDark ? whiteColor : blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: Container(
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: encyclopediaProvider.encyclopedia.length,
                            itemBuilder: (context, index) {
                              return AnimatedSize(
                                duration: 300.ms,
                                child: IndexItemCard(
                                  searchValue: searchController.text,
                                  encyclopediaModel:
                                      encyclopediaProvider.encyclopedia[index],
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SettingsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.isDark ? whiteInDark : whiteColor,
                            borderRadius: BorderRadius.circular(100),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.settings,
                                  color:
                                      theme.isDark
                                          ? whiteColor
                                          : blackColor.withValues(alpha: 0.7),
                                ),
                                SizedBox(width: 24),
                                Text(
                                  "الإعدادات",
                                  style: labelLarge.copyWith(
                                    color:
                                        theme.isDark
                                            ? whiteColor
                                            : blackColor.withValues(alpha: 0.7),
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
              ),
            ],
          ),
        );
      },
    );
  }
}

class IndexItemCard extends StatelessWidget {
  const IndexItemCard({
    super.key,
    required this.encyclopediaModel,
    this.searchValue,
    required this.index,
  });
  final EncyclopediaModel encyclopediaModel;
  final String? searchValue;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, theme, _) {
        return GestureDetector(
          onTap: () {
            Provider.of<EncyclopediaProvider>(
              context,
              listen: false,
            ).setSelectedIndex(index);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  encyclopediaModel.title,
                  style: displayLarge.copyWith(
                    color: theme.isDark ? whiteColor : blackColor,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 32,
                //     vertical: 16,
                //   ),
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: encyclopediaModel.hadiths.length,
                //     itemBuilder: (context, hadithIndex) {
                //       return AnimatedSize(
                //         duration: 300.ms,
                //         child:
                //             searchValue != null
                //                 ? (encyclopediaModel
                //                             .hadiths[hadithIndex]
                //                             .title
                //                             .contains(searchValue!) ||
                //                         encyclopediaModel
                //                             .hadiths[hadithIndex]
                //                             .text
                //                             .contains(searchValue!))
                //                     ? Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                         vertical: 8.0,
                //                       ),
                //                       child: Row(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Expanded(
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.start,
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 Text(
                //                                   encyclopediaModel
                //                                       .hadiths[hadithIndex]
                //                                       .title,
                //                                   style: labelLarge.copyWith(
                //                                     color:
                //                                         theme.isDark
                //                                             ? whiteColor
                //                                                 .withValues(
                //                                                   alpha: 0.7,
                //                                                 )
                //                                             : blackColor,
                //                                   ),
                //                                   maxLines: 1,
                //                                 ),
                //                                 if (searchValue != null &&
                //                                     !encyclopediaModel
                //                                         .hadiths[hadithIndex]
                //                                         .title
                //                                         .contains(searchValue!) &&
                //                                     encyclopediaModel
                //                                         .hadiths[hadithIndex]
                //                                         .text
                //                                         .contains(searchValue!))
                //                                   Text(
                //                                     "${searchValue!}......",
                //                                     style: labelSmall.copyWith(
                //                                       color:
                //                                           theme.isDark
                //                                               ? whiteColor
                //                                                   .withValues(
                //                                                     alpha: 0.5,
                //                                                   )
                //                                               : blackColor
                //                                                   .withValues(
                //                                                     alpha: 0.7,
                //                                                   ),
                //                                     ),
                //                                     maxLines: 1,
                //                                   ),
                //                               ],
                //                             ),
                //                           ),

                //                           GestureDetector(
                //                             onTap: () {
                //                               Navigator.push(
                //                                 context,
                //                                 CupertinoPageRoute(
                //                                   builder:
                //                                       (
                //                                         context,
                //                                       ) => SingleHadithScreen(
                //                                         hadith:
                //                                             encyclopediaModel
                //                                                 .hadiths[hadithIndex],
                //                                       ),
                //                                 ),
                //                               );
                //                             },
                //                             child: Text(
                //                               "عرض الحديث",
                //                               style: labelLarge.copyWith(
                //                                 color: greenColor,
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     )
                //                     : SizedBox()
                //                 : SizedBox(),
                //       );
                //     },
                //   ),
                // ),
                Divider(
                  color:
                      theme.isDark
                          ? whiteColor.withValues(alpha: 0.1)
                          : blackColor.withValues(alpha: 0.1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
