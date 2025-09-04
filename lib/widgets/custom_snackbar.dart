import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.green,
  int durationSeconds = 2,
  double borderRadius = 20.0,
  double verticalPosition = 0.06,
  double horizontalMargin = 0.1,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * verticalPosition,
        left: MediaQuery.of(context).size.width * horizontalMargin,
        right: MediaQuery.of(context).size.width * horizontalMargin,
      ),
      duration: Duration(seconds: durationSeconds),
    ),
  );
}
