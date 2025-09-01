// import 'package:flutter/material.dart';

// class SubmitButton extends StatelessWidget {
//   final String data;
//   final void Function()? onPressed;
//   const SubmitButton({super.key, required this.data, this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.orange,
//         // padding: const EdgeInsets.symmetric(
//         //   horizontal: 150,
//         //   vertical: 12,
//         // ),
//         padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       ),
//       child: Text(
//         data,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String data;
  final void Function()? onPressed;
  const SubmitButton({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 350; // Check for small screens

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? screenWidth * 0.25 : screenWidth * 0.35,
          vertical: isSmallScreen ? 10 : 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        data,
        style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.w600,
          fontSize: isSmallScreen ? 14 : 16,
        ),
      ),
    );
  }
}