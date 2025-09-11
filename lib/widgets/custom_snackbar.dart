import 'package:dmboss/app/myapp.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar({
  String? message,
  Color backgroundColor = Colors.green,
  int durationSeconds = 2,
  double borderRadius = 20.0,
  double verticalPosition = 0.06,
  double horizontalMargin = 0.1,
  BuildContext? context,
}) {
  final mediaQuery = context != null && context.mounted
      ? MediaQuery.of(context)
      : null;

  final double bottomMargin = mediaQuery != null
      ? mediaQuery.size.height * verticalPosition
      : 20.0;

  final double horizontalMarginValue = mediaQuery != null
      ? mediaQuery.size.width * horizontalMargin
      : 20.0;

  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(
        message ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: bottomMargin,
        left: horizontalMarginValue,
        right: horizontalMarginValue,
      ),
      duration: Duration(seconds: durationSeconds),
    ),
  );
}
