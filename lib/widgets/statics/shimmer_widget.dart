import 'package:flutter/material.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.child,
    this.radius = 12,
    this.color = greenColor,
  });
  final double? width;
  final double? height;
  final Widget? child;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, theme, _) {
        return Shimmer.fromColors(
          baseColor: theme.isDark ? whiteColor : color.withValues(alpha: 0.5),
          highlightColor: Colors.white.withValues(alpha: 0.5),
          enabled: true,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5),
              color: Colors.white10,
              borderRadius: BorderRadius.circular(radius),
            ),
            width: width,
            height: height,
            child: child,
          ),
        );
      },
    );
  }
}
