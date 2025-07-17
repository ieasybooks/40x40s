import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:fourtyfourties/providers/encyclopedia_provider.dart';
import 'package:fourtyfourties/screens/main_screens/content_index_screen.dart';
import 'package:fourtyfourties/widgets/dialogs/flush_bar.dart';
import 'package:fourtyfourties/widgets/statics/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<EncyclopediaProvider, DarkThemeProvider>(
      builder: (context, encyclopediaConsumer, darkThemeConsumer, child) {
        return Scaffold(
          key: homeScaffoldKey,

          body: AnimatedSwitcher(
            duration: 300.ms,
            child:
                encyclopediaConsumer.busy ||
                        encyclopediaConsumer.encyclopedia.isEmpty
                    ? Center(
                      child: ShimmerWidget(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/green40.png"),
                            Text("جاري التحميل...", style: displayLarge),
                          ],
                        ),
                      ),
                    )
                    : Stack(
                      children: [
                        Column(
                          children: [
                            SafeArea(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                    ),
                                    child: Image.asset(
                                      "assets/play_store_512.png",
                                      width: getSize(context).width * 0.16,
                                      height: getSize(context).width * 0.16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder:
                                              (context) => ContentIndexScreen(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.menu_rounded),
                                  ),
                                ],
                              ),
                            ),
                            TabBar(
                              controller:
                                  encyclopediaConsumer
                                      .encycleopediaTabController,
                              onTap: (index) {
                                encyclopediaConsumer.setSelectedIndex(index);
                              },

                              tabAlignment: TabAlignment.center,
                              indicatorColor: Colors.transparent,
                              dividerColor: Colors.transparent,
                              labelStyle: displayLarge.copyWith(
                                color: blackColor.withValues(alpha: 0.7),
                              ),
                              unselectedLabelStyle: labelLarge.copyWith(
                                color: blackColor.withValues(alpha: 0.3),
                              ),
                              isScrollable: true,
                              tabs:
                                  encyclopediaConsumer.encyclopedia.map((
                                    encyclopedia,
                                  ) {
                                    return Tab(
                                      text: encyclopedia.encyclopediaTitle,
                                    );
                                  }).toList(),
                            ),
                            SizedBox(height: 24),
                            Expanded(
                              child: TabBarView(
                                controller:
                                    encyclopediaConsumer
                                        .encycleopediaTabController,
                                children:
                                    encyclopediaConsumer.encyclopedia.map((
                                      encyclopedia,
                                    ) {
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    darkThemeConsumer.isDark
                                                        ? whiteColor.withValues(
                                                          alpha: 0.2,
                                                        )
                                                        : blackColor.withValues(
                                                          alpha: 0.1,
                                                        ),
                                                blurRadius: 10,
                                                spreadRadius: 4,
                                              ),
                                            ],
                                            color:
                                                darkThemeConsumer.isDark
                                                    ? whiteInDark
                                                    : whiteColor,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Container(
                                                    width:
                                                        getSize(context).width *
                                                        0.1,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                      color:
                                                          darkThemeConsumer
                                                                  .isDark
                                                              ? whiteColor
                                                                  .withValues(
                                                                    alpha: 0.5,
                                                                  )
                                                              : blackColor
                                                                  .withValues(
                                                                    alpha: 0.1,
                                                                  ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          encyclopedia
                                                              .ahadeeth
                                                              .length,
                                                      itemBuilder: (
                                                        context,
                                                        index,
                                                      ) {
                                                        final hadeeth =
                                                            encyclopedia
                                                                .ahadeeth[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 18,
                                                                vertical: 9,
                                                              ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    hadeeth
                                                                        .hadeethTitle,
                                                                    style: labelMedium.copyWith(
                                                                      color:
                                                                          darkThemeConsumer.isDark
                                                                              ? whiteColor.withValues(
                                                                                alpha:
                                                                                    0.7,
                                                                              )
                                                                              : blackColor.withValues(
                                                                                alpha:
                                                                                    0.4,
                                                                              ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      IconButton(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        visualDensity:
                                                                            VisualDensity.compact,
                                                                        onPressed: () {
                                                                          Clipboard.setData(
                                                                            ClipboardData(
                                                                              text:
                                                                                  "${hadeeth.hadeethTitle} | ${hadeeth.hadeethContent}",
                                                                            ),
                                                                          ).then((
                                                                            v,
                                                                          ) {
                                                                            if (context.mounted) {
                                                                              showCustomFlushbar(
                                                                                "تم النسخ للحافظة",
                                                                                greenColor,
                                                                                Icons.copy,
                                                                                context,
                                                                              );
                                                                            }
                                                                          });
                                                                        },
                                                                        icon: Icon(
                                                                          Icons
                                                                              .copy,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              darkThemeConsumer.isDark
                                                                                  ? whiteColor.withValues(
                                                                                    alpha:
                                                                                        0.7,
                                                                                  )
                                                                                  : blackColor.withValues(
                                                                                    alpha:
                                                                                        0.4,
                                                                                  ),
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        padding:
                                                                            EdgeInsets.zero,

                                                                        visualDensity:
                                                                            VisualDensity.compact,
                                                                        onPressed: () {
                                                                          SharePlus.instance.share(
                                                                            ShareParams(
                                                                              text:
                                                                                  "${hadeeth.hadeethTitle} | ${hadeeth.hadeethContent}",
                                                                            ),
                                                                          );
                                                                        },
                                                                        icon: Icon(
                                                                          Icons
                                                                              .share,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              darkThemeConsumer.isDark
                                                                                  ? whiteColor.withValues(
                                                                                    alpha:
                                                                                        0.7,
                                                                                  )
                                                                                  : blackColor.withValues(
                                                                                    alpha:
                                                                                        0.4,
                                                                                  ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                hadeeth
                                                                    .hadeethContent,
                                                                style: labelLarge.copyWith(
                                                                  color:
                                                                      darkThemeConsumer
                                                                              .isDark
                                                                          ? whiteColor
                                                                          : null,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getSize(
                                                            context,
                                                          ).height *
                                                          0.09,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: blackColor.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(26),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      encyclopediaConsumer.goToPrevious();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.chevron_right_circle,
                                      color: whiteColor,
                                    ),
                                  ),
                                  Text(
                                    encyclopediaConsumer
                                        .encyclopedia[encyclopediaConsumer
                                            .selectedIndex]
                                        .encyclopediaTitle,
                                    style: displaySmall.copyWith(
                                      color: whiteColor,
                                    ),
                                  ),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      encyclopediaConsumer.goToNext();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.chevron_left_circle,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
