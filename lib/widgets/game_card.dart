import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title, numbers, statusText, buttonText, openTime, closeTime;
  final Color statusColor, buttonColor;

  const GameCard({
    super.key,
    required this.title,
    required this.numbers,
    required this.statusText,
    required this.statusColor,
    required this.buttonText,
    required this.buttonColor,
    required this.openTime,
    required this.closeTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 3,

      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.007,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  numbers,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      "Open : $openTime",
                      style: TextStyle(
                        fontSize: 11.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Close : $closeTime",
                      style: TextStyle(
                        fontSize: 11.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),

                Icon(
                  Icons.play_circle_filled_outlined,
                  color: buttonColor,
                  size: 60,
                ),
                Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
