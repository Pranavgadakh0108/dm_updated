import 'package:dmboss/widgets/current_date.dart';
import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.calendar_month, color: Colors.black),
          SizedBox(width: 5),
          CurrentDateWidget()
        ],
      ),
    );
  }
}
