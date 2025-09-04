// import 'package:dmboss/widgets/current_date.dart';
// import 'package:flutter/material.dart';

// class GameDetailScreen3 extends StatefulWidget {
//   final String title;
//   const GameDetailScreen3({super.key, required this.title});

//   @override
//   State<GameDetailScreen3> createState() => _GameDetailScreen3State();
// }

// class _GameDetailScreen3State extends State<GameDetailScreen3> {
//   final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
//   int? selectedPoint; // Selected betting point

//   // Digits for both sections
//   final List<int> digits1 = [
//     128,
//     137,
//     146,
//     236,
//     245,
//     290,
//     380,
//     470,
//     489,
//     560,
//     579,
//     678,
//   ];
//   final List<int> digits2 = [
//     129,
//     138,
//     147,
//     156,
//     237,
//     246,
//     345,
//     390,
//     480,
//     570,
//     589,
//     679,
//   ];

//   // Map to store selected digits and their assigned value
//   Map<int, int> selectedDigits = {};

//   void resetBid() {
//     setState(() {
//       selectedDigits.clear();
//     });
//   }

//   void selectPoint(int point) {
//     setState(() {
//       selectedPoint = point;
//     });
//   }

//   void incrementDigitValue(int digit) {
//     if (selectedPoint == null) return; // Do nothing if no point selected

//     setState(() {
//       if (selectedDigits.containsKey(digit)) {
//         // If digit already has a value, increment it by selectedPoint
//         selectedDigits[digit] = selectedDigits[digit]! + selectedPoint!;
//       } else {
//         // If digit is not selected yet, assign the selectedPoint as initial value
//         selectedDigits[digit] = selectedPoint!;
//       }
//     });
//   }

//   Widget buildPointsSelector() {
//     return Wrap(
//       spacing: 15,
//       runSpacing: 10,
//       children: pointsList.map((point) {
//         bool isSelected = selectedPoint == point;
//         return GestureDetector(
//           onTap: () => selectPoint(point),
//           child: Container(
//             height: 40,
//             width: 80,
//             decoration: BoxDecoration(
//               color: Colors.amber.shade100,
//               border: Border.all(color: Colors.deepOrangeAccent, width: 3),
//             ),
//             child: Padding(
//               // padding: const EdgeInsets.all(2.0),
//               padding: EdgeInsets.all(
//                 MediaQuery.of(context).size.width * 0.005,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.circle,
//                     color: isSelected ? Colors.red : Colors.green.shade800,
//                     size: 5,
//                   ),
//                   ClipOval(
//                     child: Container(
//                       height: 27,
//                       width: 55,
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.red : Colors.green.shade800,
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "₹ $point",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12.5,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     Icons.circle,
//                     color: isSelected ? Colors.red : Colors.green.shade800,
//                     size: 5,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget buildDigitsGrid(List<int> digits) {
//     return Wrap(
//       spacing: 20,
//       runSpacing: 12,
//       children: digits.map((digit) {
//         bool isSelected = selectedDigits.containsKey(digit);
//         return GestureDetector(
//           onTap: () => incrementDigitValue(digit),
//           child: Column(
//             children: [
//               Text(
//                 "$digit",
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 width: 60,
//                 height: 35,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Colors.grey.shade200
//                       : Colors.grey.shade300,
//                   border: Border.all(
//                     color: isSelected
//                         ? Colors.orangeAccent
//                         : Colors.grey.shade300,
//                     width: isSelected ? 3 : 0,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   isSelected ? "${selectedDigits[digit]}" : "",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           widget.title,
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.all(10),
//             // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.02,
//               vertical: MediaQuery.of(context).size.height * 0.01,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               children: const [
//                 Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
//                 SizedBox(width: 5),
//                 Icon(Icons.wallet, color: Colors.black),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         // padding: const EdgeInsets.all(15),
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Date Container
//             Container(
//               // padding: const EdgeInsets.all(12),
//               padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.orange, width: 2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.calendar_today, color: Colors.black),
//                   SizedBox(width: 5),
//                   CurrentDateWidget(),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),

//             // Points Selection
//             const Text(
//               "Select Points for Betting",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.orange,
//               ),
//             ),
//             const SizedBox(height: 10),
//             buildPointsSelector(),
//             const SizedBox(height: 15),

//             // Digits Selection
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: const Text(
//                         "Select Digits",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ),
//                     const Divider(color: Colors.orange),
//                     const SizedBox(height: 5),
//                     const Text(
//                       "Select All Digits 1",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     buildDigitsGrid(digits1),
//                     const SizedBox(height: 15),
//                     const Divider(color: Colors.orange),
//                     const Text(
//                       "Select All Digits 2",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     buildDigitsGrid(digits2),
//                     const Divider(color: Colors.orange),
//                     const Text(
//                       "Select All Digits 3",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     buildDigitsGrid(digits1),
//                     const SizedBox(height: 15),
//                     const Divider(color: Colors.orange),
//                     const Text(
//                       "Select All Digits 4",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     buildDigitsGrid(digits2),
//                     const Divider(color: Colors.orange),
//                     const Text(
//                       "Select All Digits 5",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     buildDigitsGrid(digits1),
//                     const SizedBox(height: 15),
//                     const Divider(color: Colors.orange),
//                     const Text(
//                       "Select All Digits 6",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     buildDigitsGrid(digits2),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: resetBid,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 25,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     "RESET BID",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 25,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     "SUBMIT BID",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:dmboss/widgets/current_date.dart';
// import 'package:flutter/material.dart';

// class BulkDp extends StatefulWidget {
//   final String title;
//   const BulkDp({super.key, required this.title});

//   @override
//   State<BulkDp> createState() => _BulkDpState();
// }

// class _BulkDpState extends State<BulkDp> {
//   final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
//   int? selectedPoint;

//   final List<int> digits1 = [100, 119, 155, 227, 335, 344, 399, 588, 669];
//   final List<int> digits2 = [110, 200, 228, 255, 336, 499, 660, 688, 778];
//   final List<int> digits3 = [166, 229, 300, 337, 355, 445, 599, 779, 788];
//   final List<int> digits4 = [112, 220, 266, 338, 400, 446, 455, 699, 770];
//   final List<int> digits5 = [113, 122, 177, 339, 366, 447, 500, 799, 889];
//   final List<int> digits6 = [600, 114, 277, 330, 448, 466, 556, 880, 899];
//   final List<int> digits7 = [115, 133, 188, 223, 377, 449, 557, 566, 700];
//   final List<int> digits8 = [116, 224, 233, 288, 440, 477, 558, 800, 990];
//   final List<int> digits9 = [117, 144, 199, 225, 388, 559, 577, 667, 900];
//   final List<int> digits0 = [118, 226, 244, 299, 334, 488, 550, 668, 677];

//   Map<int, int> selectedDigits = {};

//   void resetBid() {
//     setState(() {
//       selectedDigits.clear();
//     });
//   }

//   void selectPoint(int point) {
//     setState(() {
//       selectedPoint = point;
//     });
//   }

//   void incrementDigitValue(int digit) {
//     if (selectedPoint == null) return;

//     setState(() {
//       selectedDigits[digit] = (selectedDigits[digit] ?? 0) + selectedPoint!;
//     });
//   }

//   Widget buildPointsSelector() {
//     return Wrap(
//       spacing: 15,
//       runSpacing: 10,
//       children: pointsList.map((point) {
//         bool isSelected = selectedPoint == point;
//         return GestureDetector(
//           onTap: () => selectPoint(point),
//           child: Container(
//             height: 40,
//             width: 80,
//             decoration: BoxDecoration(
//               color: Colors.amber.shade100,
//               border: Border.all(color: Colors.deepOrangeAccent, width: 3),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(
//                 MediaQuery.of(context).size.width * 0.005,
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.circle,
//                     color: isSelected ? Colors.red : Colors.green.shade800,
//                     size: 5,
//                   ),
//                   Flexible(
//                     child: ClipOval(
//                       child: Container(
//                         height: 27,
//                         width: 55,
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? Colors.red
//                               : Colors.green.shade800,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           "₹ $point",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.5,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     Icons.circle,
//                     color: isSelected ? Colors.red : Colors.green.shade800,
//                     size: 5,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget buildDigitsGrid(List<int> digits) {
//     return Wrap(
//       spacing: 20,
//       runSpacing: 12,
//       children: digits.map((digit) {
//         bool isSelected = selectedDigits.containsKey(digit);
//         return GestureDetector(
//           onTap: () => incrementDigitValue(digit),
//           child: Column(
//             children: [
//               Text(
//                 "$digit",
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 width: 60,
//                 height: 35,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Colors.grey.shade200
//                       : Colors.grey.shade300,
//                   border: Border.all(
//                     color: isSelected
//                         ? Colors.orangeAccent
//                         : Colors.grey.shade300,
//                     width: isSelected ? 3 : 0,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   isSelected ? "${selectedDigits[digit]}" : "",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           widget.title,
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.all(10),
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.02,
//               vertical: MediaQuery.of(context).size.height * 0.01,
//             ),
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 0.4,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
//                 SizedBox(width: 5),
//                 Icon(Icons.wallet, color: Colors.black),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Padding(
//             padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
//             child: Column(
//               children: [
//                 // Top Content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Date Container
//                         Container(
//                           padding: EdgeInsets.all(
//                             MediaQuery.of(context).size.width * 0.02,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.orange, width: 2),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               Icon(Icons.calendar_today, color: Colors.black),
//                               SizedBox(width: 5),
//                               CurrentDateWidget(),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 15),

//                         // Points Selection
//                         const Text(
//                           "Select Points for Betting",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.orange,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         buildPointsSelector(),
//                         const SizedBox(height: 15),

//                         // Digits Selection
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Center(
//                               child: Text(
//                                 "Select Digits",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.orange,
//                                 ),
//                               ),
//                             ),
//                             const Divider(color: Colors.orange),
//                             const SizedBox(height: 5),
//                             const Text(
//                               "Select All Digits 1",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits1),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 2",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits2),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 3",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits3),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 4",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits4),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 5",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits5),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 6",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits6),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 7",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits7),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 8",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits8),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 9",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits9),
//                             const SizedBox(height: 15),
//                             const Divider(color: Colors.orange),
//                             const Text(
//                               "Select All Digits 0",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(digits0),
//                             const SizedBox(height: 15),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Buttons (fixed at bottom)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Flexible(
//                         child: ElevatedButton(
//                           onPressed: resetBid,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   MediaQuery.of(context).size.width * 0.06,
//                               vertical: 12,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: const Text(
//                             "RESET BID",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Flexible(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   MediaQuery.of(context).size.width * 0.06,
//                               vertical: 12,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: const Text(
//                             "SUBMIT BID",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:dmboss/model/games_model/bulk_dp_model.dart';

import 'package:dmboss/provider/games_provider/bulk_dp_provider.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/game_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Bulk_Dp extends StatefulWidget {
  final String title;
  final String marketId;
  final String gameName;
  final String openTime;
  const Bulk_Dp({
    super.key,
    required this.title,
    required this.marketId,
    required this.gameName,
    required this.openTime,
  });

  @override
  State<Bulk_Dp> createState() => _BulkDpState();
}

class _BulkDpState extends State<Bulk_Dp> {
  final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
  int? selectedPoint;

  final List<int> digits1 = [100, 119, 155, 227, 335, 344, 399, 588, 669];
  final List<int> digits2 = [110, 200, 228, 255, 336, 499, 660, 688, 778];
  final List<int> digits3 = [166, 229, 300, 337, 355, 445, 599, 779, 788];
  final List<int> digits4 = [112, 220, 266, 338, 400, 446, 455, 699, 770];
  final List<int> digits5 = [113, 122, 177, 339, 366, 447, 500, 799, 889];
  final List<int> digits6 = [600, 114, 277, 330, 448, 466, 556, 880, 899];
  final List<int> digits7 = [115, 133, 188, 223, 377, 449, 557, 566, 700];
  final List<int> digits8 = [116, 224, 233, 288, 440, 477, 558, 800, 990];
  final List<int> digits9 = [117, 144, 199, 225, 388, 559, 577, 667, 900];
  final List<int> digits0 = [118, 226, 244, 299, 334, 488, 550, 668, 677];

  Map<int, int> selectedDigits = {};

  void resetBid() {
    setState(() {
      selectedDigits.clear();
    });
    // Also reset the provider's data
    final provider = Provider.of<BulkDpBetProvider>(context, listen: false);
    provider.clearBulkDpItems();
  }

  void selectPoint(int point) {
    setState(() {
      selectedPoint = point;
    });
  }

  void incrementDigitValue(int digit) {
    if (selectedPoint == null) return;

    setState(() {
      selectedDigits[digit] = (selectedDigits[digit] ?? 0) + selectedPoint!;
    });

    // Update the provider with the new digit selection
    final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

    // Check if this digit already exists in the provider's list
    final existingIndex = provider.bulkDpModel.bulkDp.indexWhere(
      (item) => item.number == digit.toString(),
    );

    if (existingIndex != -1) {
      // Update existing item
      final newItem = BulkDp(
        number: digit.toString(),
        amount: selectedDigits[digit]!,
      );
      provider.updateBulkDpItem(existingIndex, newItem);
    } else {
      // Add new item
      final newItem = BulkDp(number: digit.toString(), amount: selectedPoint!);
      provider.addBulkDpItem(newItem);
    }
  }

  void submitBid() {
    if (selectedDigits.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one digit to place a bet"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    print("--------------");
    print(selectedDigits);

    final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

    // Set game ID and type (you might want to get these from somewhere)
    provider.setGameId(widget.marketId); // Replace with actual game ID
    provider.setGameType("BULK_DP"); // Changed to bulk_dp for this screen

    // Place the bet
    provider.placeBulkDpBet(context, provider.bulkDpModel);

    resetBid();
  }

  Widget buildPointsSelector() {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      children: pointsList.map((point) {
        bool isSelected = selectedPoint == point;
        return GestureDetector(
          onTap: () => selectPoint(point),
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              border: Border.all(color: Colors.deepOrangeAccent, width: 3),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.005,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: isSelected ? Colors.red : Colors.green.shade800,
                    size: 5,
                  ),
                  Flexible(
                    child: ClipOval(
                      child: Container(
                        height: 27,
                        width: 55,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.red
                              : Colors.green.shade800,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "₹ $point",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: isSelected ? Colors.red : Colors.green.shade800,
                    size: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildDigitsGrid(List<int> digits) {
    return Wrap(
      spacing: 20,
      runSpacing: 12,
      children: digits.map((digit) {
        bool isSelected = selectedDigits.containsKey(digit);
        return GestureDetector(
          onTap: () => incrementDigitValue(digit),
          child: Column(
            children: [
              Text(
                "$digit",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 60,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.grey.shade200
                      : Colors.grey.shade300,
                  border: Border.all(
                    color: isSelected
                        ? Colors.orangeAccent
                        : Colors.grey.shade300,
                    width: isSelected ? 3 : 0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isSelected ? "${selectedDigits[digit]}" : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameStatus = getGameStatus(widget.openTime);
    return Consumer<BulkDpBetProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Wallet()],
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.04,
                ),
                child: Column(
                  children: [
                    // Top Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Date Container
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.gameName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        gameStatus,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Points Selection
                            const Text(
                              "Select Points for Betting",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 10),
                            buildPointsSelector(),
                            const SizedBox(height: 15),

                            // Digits Selection
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "Select Digits",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                const Divider(color: Colors.orange),
                                const SizedBox(height: 5),
                                const Text(
                                  "Select All Digits 1",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits1),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 2",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits2),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 3",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits3),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 4",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits4),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 5",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits5),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 6",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits6),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 7",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits7),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 8",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits8),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 9",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits9),
                                const SizedBox(height: 15),
                                const Divider(color: Colors.orange),
                                const Text(
                                  "Select All Digits 0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildDigitsGrid(digits0),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Buttons (fixed at bottom)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: resetBid,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "RESET BID",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: provider.isLoading ? null : submitBid,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: provider.isLoading
                                    ? Colors.grey
                                    : Colors.orange,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: provider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "SUBMIT BID",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
