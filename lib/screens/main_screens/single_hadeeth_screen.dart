import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/functions_helper.dart';
import 'package:fourtyfourties/model/encyclopedia_model.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:fourtyfourties/widgets/dialogs/flush_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SingleHadeethScreen extends StatelessWidget {
  const SingleHadeethScreen({super.key, required this.hadeeth});
  final Hadeeth hadeeth;
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, theme, _) {
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
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  hadeeth.hadeethTitle,
                                  style: displayMedium.copyWith(
                                    color:
                                        theme.isDark ? whiteColor : blackColor,
                                  ),
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text:
                                              "${hadeeth.hadeethTitle} | ${hadeeth.hadeethContent}",
                                        ),
                                      ).then((v) {
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
                                      Icons.copy,
                                      size: 16,
                                      color:
                                          theme.isDark
                                              ? whiteColor.withValues(
                                                alpha: 0.7,
                                              )
                                              : blackColor.withValues(
                                                alpha: 0.4,
                                              ),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,

                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      SharePlus.instance.share(
                                        ShareParams(
                                          text:
                                              "${hadeeth.hadeethTitle} | ${hadeeth.hadeethContent}",
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      size: 16,
                                      color:
                                          theme.isDark
                                              ? whiteColor.withValues(
                                                alpha: 0.7,
                                              )
                                              : blackColor.withValues(
                                                alpha: 0.4,
                                              ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            hadeeth.hadeethContent,
                            style: labelLarge.copyWith(
                              color: theme.isDark ? whiteColor : blackColor,
                            ),
                            textAlign: TextAlign.justify,
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
