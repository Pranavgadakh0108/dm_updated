import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateWidget extends StatelessWidget {
  final TextStyle? textStyle;
  final String separator;

  const CurrentDateWidget({
    super.key,
    this.textStyle,
    this.separator = '/',
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd${separator}MM${separator}yyyy').format(DateTime.now());

    return Text(
      formattedDate,
      style: textStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
