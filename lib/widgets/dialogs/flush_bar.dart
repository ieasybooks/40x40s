import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fourtyfourties/helpers/consts.dart';

Future showCustomFlushbar(
  String message,
  Color color,
  IconData icon,
  BuildContext context,
) async {
  Flushbar(
    messageText: Text(message, style: labelLarge.copyWith(color: whiteColor)),
    icon: Icon(icon, size: 28.0, color: whiteColor),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    margin: const EdgeInsets.all(0),
    messageColor: whiteColor,
    backgroundColor: color,
    flushbarStyle: FlushbarStyle.GROUNDED,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(0),
    duration: const Duration(seconds: 2),
    leftBarIndicatorColor: color,
    boxShadows: [
      BoxShadow(
        color: blackColor.withValues(alpha: 0.1),
        offset: const Offset(0.0, 2.0),
        blurRadius: 3.0,
      ),
    ],
  ).show(context);
}
