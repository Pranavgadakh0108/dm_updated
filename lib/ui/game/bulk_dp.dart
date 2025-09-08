

// // ignore_for_file: camel_case_types

// import 'package:dmboss/model/games_model/bulk_dp_model.dart';
// import 'package:dmboss/provider/games_provider/bulk_dp_provider.dart';
// import 'package:dmboss/widgets/bulk_sp_dp_dialogue.dart';
// import 'package:dmboss/widgets/game_app_bar.dart';
// import 'package:dmboss/widgets/game_status.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class Bulk_Dp extends StatefulWidget {
//   final String title;
//   final String marketId;
//   final String gameName;
//   final String openTime;
//   const Bulk_Dp({
//     super.key,
//     required this.title,
//     required this.marketId,
//     required this.gameName,
//     required this.openTime,
//   });

//   @override
//   State<Bulk_Dp> createState() => _BulkDpState();
// }

// class _BulkDpState extends State<Bulk_Dp> {
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

//   // Added list to store selected digits with total points/amount
//   List<Map<String, String>> bids = [];

//   void resetBid() {
//     setState(() {
//       selectedDigits.clear();
//       bids.clear(); // Clear the bids list when resetting
//     });
//     // Also reset the provider's data
//     final provider = Provider.of<BulkDpBetProvider>(context, listen: false);
//     provider.clearBulkDpItems();
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

//       // Update the bids list
//       final digitStr = digit.toString();
//       final amountStr = selectedDigits[digit]!.toString();

//       // Check if this digit already exists in bids
//       final existingIndex = bids.indexWhere((bid) => bid['digit'] == digitStr);

//       if (existingIndex != -1) {
//         // Update existing bid
//         bids[existingIndex] = {'digit': digitStr, 'amount': amountStr};
//       } else {
//         // Add new bid
//         bids.add({'digit': digitStr, 'amount': amountStr});
//       }
//     });

//     // Update the provider with the new digit selection
//     final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

//     // Check if this digit already exists in the provider's list
//     final existingIndex = provider.bulkDpModel.bulkDp.indexWhere(
//       (item) => item.number == digit.toString(),
//     );

//     if (existingIndex != -1) {
//       // Update existing item
//       final newItem = BulkDp(
//         number: digit.toString(),
//         amount: selectedDigits[digit]!,
//       );
//       provider.updateBulkDpItem(existingIndex, newItem);
//     } else {
//       // Add new item
//       final newItem = BulkDp(number: digit.toString(), amount: selectedPoint!);
//       provider.addBulkDpItem(newItem);
//     }
//   }

//   void submitBid() {
//     if (selectedDigits.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select at least one digit to place a bet"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }

//     final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

//     // Set game ID and type (you might want to get these from somewhere)
//     provider.setGameId(widget.marketId); // Replace with actual game ID
//     provider.setGameType("BULK_DP"); // Changed to bulk_dp for this screen

//     // Place the bet
//     provider.placeBulkDpBet(context, provider.bulkDpModel);

//     resetBid();
//     Navigator.pop(context);
//   }

//   void _showConfirmationDialog(BuildContext context) {
//     final totalBids = bids.length;
//     final totalBidAmount = bids.fold<int>(
//       0,
//       (sum, bid) => sum + int.parse(bid['amount']!),
//     );

//     showDialog(
//       context: context,
//       builder: (context) => BulkSpBetSummaryDialog(
//         title: widget.title,
//         date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
//         bids: bids,
//         totalBids: totalBids,
//         totalBidAmount: totalBidAmount,
//         onConfirm: () {
//           Navigator.pop(context);
//           submitBid();
//         },
//       ),
//     );
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
//     final gameStatus = getGameStatus(widget.openTime);
//     return Consumer<BulkDpBetProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.orange,
//             title: Text(
//               widget.title,
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               Container(
//                 margin: const EdgeInsets.all(10),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width * 0.02,
//                   vertical: MediaQuery.of(context).size.height * 0.01,
//                 ),
//                 constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [Wallet()],
//                 ),
//               ),
//             ],
//           ),
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               return Padding(
//                 padding: EdgeInsets.all(
//                   MediaQuery.of(context).size.width * 0.04,
//                 ),
//                 child: Column(
//                   children: [
//                     // Top Content
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             // Date Container
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     padding: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.orange,
//                                         width: 2,
//                                       ),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         widget.gameName,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: Container(
//                                     padding: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.orange,
//                                         width: 2,
//                                       ),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         gameStatus,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 15),

//                             // Points Selection
//                             const Text(
//                               "Select Points for Betting",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             buildPointsSelector(),
//                             const SizedBox(height: 15),

//                             // Digits Selection
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Center(
//                                   child: Text(
//                                     "Select Digits",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.orange,
//                                     ),
//                                   ),
//                                 ),
//                                 const Divider(color: Colors.orange),
//                                 const SizedBox(height: 5),
//                                 const Text(
//                                   "Select All Digits 1",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits1),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 2",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits2),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 3",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits3),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 4",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits4),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 5",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits5),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 6",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits6),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 7",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits7),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 8",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits8),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 9",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits9),
//                                 const SizedBox(height: 15),
//                                 const Divider(color: Colors.orange),
//                                 const Text(
//                                   "Select All Digits 0",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 buildDigitsGrid(digits0),
//                                 const SizedBox(height: 15),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Buttons (fixed at bottom)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0, top: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Flexible(
//                             child: ElevatedButton(
//                               onPressed: resetBid,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.orange,
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal:
//                                       MediaQuery.of(context).size.width * 0.06,
//                                   vertical: 12,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "RESET BID",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Flexible(
//                             child: ElevatedButton(
//                               onPressed: provider.isLoading
//                                   ? null
//                                   : () => _showConfirmationDialog(context),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: provider.isLoading
//                                     ? Colors.grey
//                                     : Colors.orange,
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal:
//                                       MediaQuery.of(context).size.width * 0.06,
//                                   vertical: 12,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: provider.isLoading
//                                   ? const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         color: Colors.white,
//                                         strokeWidth: 2,
//                                       ),
//                                     )
//                                   : const Text(
//                                       "SUBMIT BID",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// ignore_for_file: camel_case_types

// import 'package:dmboss/model/games_model/bulk_dp_model.dart';
// import 'package:dmboss/provider/games_provider/bulk_dp_provider.dart';
// import 'package:dmboss/widgets/bulk_sp_dp_dialogue.dart';
// import 'package:dmboss/widgets/game_app_bar.dart';
// import 'package:dmboss/widgets/game_status.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class Bulk_Dp extends StatefulWidget {
//   final String title;
//   final String marketId;
//   final String gameName;
//   final String openTime;
//   const Bulk_Dp({
//     super.key,
//     required this.title,
//     required this.marketId,
//     required this.gameName,
//     required this.openTime,
//   });

//   @override
//   State<Bulk_Dp> createState() => _BulkDpState();
// }

// class _BulkDpState extends State<Bulk_Dp> {
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

//   // Added list to store selected digits with total points/amount
//   List<Map<String, String>> bids = [];

//   void resetBid() {
//     setState(() {
//       selectedDigits.clear();
//       bids.clear(); // Clear the bids list when resetting
//     });
//     // Also reset the provider's data
//     final provider = Provider.of<BulkDpBetProvider>(context, listen: false);
//     provider.clearBulkDpItems();
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

//       // Update the bids list
//       final digitStr = digit.toString();
//       final amountStr = selectedDigits[digit]!.toString();

//       // Check if this digit already exists in bids
//       final existingIndex = bids.indexWhere((bid) => bid['digit'] == digitStr);

//       if (existingIndex != -1) {
//         // Update existing bid
//         bids[existingIndex] = {'digit': digitStr, 'amount': amountStr};
//       } else {
//         // Add new bid
//         bids.add({'digit': digitStr, 'amount': amountStr});
//       }
//     });

//     // Update the provider with the new digit selection
//     final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

//     // Check if this digit already exists in the provider's list
//     final existingIndex = provider.bulkDpModel.bulkDp.indexWhere(
//       (item) => item.number == digit.toString(),
//     );

//     if (existingIndex != -1) {
//       // Update existing item
//       final newItem = BulkDp(
//         number: digit.toString(),
//         amount: selectedDigits[digit]!,
//       );
//       provider.updateBulkDpItem(existingIndex, newItem);
//     } else {
//       // Add new item
//       final newItem = BulkDp(number: digit.toString(), amount: selectedPoint!);
//       provider.addBulkDpItem(newItem);
//     }
//   }

//   void submitBid() {
//     if (selectedDigits.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select at least one digit to place a bet"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }

//     final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

//     // Set game ID and type (you might want to get these from somewhere)
//     provider.setGameId(widget.marketId); // Replace with actual game ID
//     provider.setGameType("BULK_DP"); // Changed to bulk_dp for this screen

//     // Place the bet
//     provider.placeBulkDpBet(context, provider.bulkDpModel);

//     resetBid();
//     Navigator.pop(context);
//   }

//   void _showConfirmationDialog(BuildContext context) {
//     final totalBids = bids.length;
//     final totalBidAmount = bids.fold<int>(
//       0,
//       (sum, bid) => sum + int.parse(bid['amount']!),
//     );

//     showDialog(
//       context: context,
//       builder: (context) => BulkSpBetSummaryDialog(
//         title: widget.title,
//         date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
//         bids: bids,
//         totalBids: totalBids,
//         totalBidAmount: totalBidAmount,
//         onConfirm: () {
//           Navigator.pop(context);
//           submitBid();
//         },
//       ),
//     );
//   }

//   // Widget buildPointsSelector() {
//   //   final screenWidth = MediaQuery.of(context).size.width;
//   //   final pointItemWidth = screenWidth * 0.22;
//   //   final pointItemHeight = screenWidth * 0.1;
    
//   //   return Wrap(
//   //     spacing: screenWidth * 0.03,
//   //     runSpacing: screenWidth * 0.02,
//   //     children: pointsList.map((point) {
//   //       bool isSelected = selectedPoint == point;
//   //       return GestureDetector(
//   //         onTap: () => selectPoint(point),
//   //         child: Container(
//   //           height: pointItemHeight,
//   //           width: pointItemWidth,
//   //           decoration: BoxDecoration(
//   //             color: Colors.amber.shade100,
//   //             border: Border.all(color: Colors.deepOrangeAccent, width: 1.5),
//   //           ),
//   //           child: Padding(
//   //             padding: EdgeInsets.all(screenWidth * 0.005),
//   //             child: Row(
//   //               mainAxisSize: MainAxisSize.min,
//   //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //               children: [
//   //                 Icon(
//   //                   Icons.circle,
//   //                   color: isSelected ? Colors.red : Colors.green.shade800,
//   //                   size: screenWidth * 0.012,
//   //                 ),
//   //                 Flexible(
//   //                   child: ClipOval(
//   //                     child: Container(
//   //                       height: pointItemHeight * 0.7,
//   //                       width: pointItemWidth * 0.7,
//   //                       decoration: BoxDecoration(
//   //                         color: isSelected
//   //                             ? Colors.red
//   //                             : Colors.green.shade800,
//   //                       ),
//   //                       alignment: Alignment.center,
//   //                       child: Text(
//   //                         "₹ $point",
//   //                         style: TextStyle(
//   //                           color: Colors.white,
//   //                           fontWeight: FontWeight.bold,
//   //                           fontSize: screenWidth * 0.03,
//   //                         ),
//   //                         overflow: TextOverflow.ellipsis,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 Icon(
//   //                   Icons.circle,
//   //                   color: isSelected ? Colors.red : Colors.green.shade800,
//   //                   size: screenWidth * 0.012,
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     }).toList(),
//   //   );
//   // }

//   Widget buildPointsSelector() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenWidth < 360;
    
//     return Wrap(
//       spacing: screenWidth * 0.04,
//       runSpacing: screenWidth * 0.03,
//       children: pointsList.map((point) {
//         bool isSelected = selectedPoint == point;
//         return GestureDetector(
//           onTap: () => selectPoint(point),
//           child: Container(
//             height: screenWidth * 0.1,
//             width: screenWidth * 0.2,
//             decoration: BoxDecoration(
//               color: Colors.amber.shade100,
//               border: Border.all(color: Colors.deepOrangeAccent, width: 1.5),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(screenWidth * 0.005),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.circle,
//                     color: isSelected ? Colors.red : Colors.green.shade800,
//                     size: screenWidth * 0.012,
//                   ),
//                   Flexible(
//                     child: ClipOval(
//                       child: Container(
//                         height: screenWidth * 0.07,
//                         width: screenWidth * 0.15,
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
//                             fontSize: isSmallScreen ? 10 : 12.5,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     Icons.circle,
//                     color: isSelected ? Colors.red : Colors.green.shade800,
//                     size: screenWidth * 0.012,
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
//     final screenWidth = MediaQuery.of(context).size.width;
//     final digitItemWidth = screenWidth * 0.15;
//     final digitItemHeight = screenWidth * 0.09;
    
//     return Wrap(
//       spacing: screenWidth * 0.04,
//       runSpacing: screenWidth * 0.03,
//       children: digits.map((digit) {
//         bool isSelected = selectedDigits.containsKey(digit);
//         return GestureDetector(
//           onTap: () => incrementDigitValue(digit),
//           child: Column(
//             children: [
//               Text(
//                 "$digit",
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.03, 
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               SizedBox(height: screenWidth * 0.005),
//               Container(
//                 width: digitItemWidth,
//                 height: digitItemHeight,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Colors.grey.shade200
//                       : Colors.grey.shade300,
//                   border: Border.all(
//                     color: isSelected
//                         ? Colors.orangeAccent
//                         : Colors.grey.shade300,
//                     width: isSelected ? screenWidth * 0.008 : 0,
//                   ),
//                   borderRadius: BorderRadius.circular(screenWidth * 0.05),
//                 ),
//                 child: Text(
//                   isSelected ? "${selectedDigits[digit]}" : "",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: screenWidth * 0.03,
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
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final gameStatus = getGameStatus(widget.openTime);
    
//     return Consumer<BulkDpBetProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.orange,
//             title: Text(
//               widget.title,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600, 
//                 fontSize: screenWidth * 0.045
//               ),
//             ),
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 size: screenWidth * 0.05,
//               ),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               Container(
//                 margin: EdgeInsets.all(screenWidth * 0.02),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.02,
//                   vertical: screenHeight * 0.01,
//                 ),
//                 constraints: BoxConstraints(
//                   maxWidth: screenWidth * 0.4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(screenWidth * 0.1),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [Wallet()],
//                 ),
//               ),
//             ],
//           ),
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               return Padding(
//                 padding: EdgeInsets.all(screenWidth * 0.04),
//                 child: Column(
//                   children: [
//                     // Top Content
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             // Date Container
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.all(screenWidth * 0.03),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.orange,
//                                         width: screenWidth * 0.005,
//                                       ),
//                                       borderRadius: BorderRadius.circular(screenWidth * 0.02),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         widget.gameName,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: screenWidth * 0.035,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.02),
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.all(screenWidth * 0.03),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.orange,
//                                         width: screenWidth * 0.005,
//                                       ),
//                                       borderRadius: BorderRadius.circular(screenWidth * 0.02),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         gameStatus,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: screenWidth * 0.035,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: screenHeight * 0.02),

//                             // Points Selection
//                             Text(
//                               "Select Points for Betting",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                                 fontSize: screenWidth * 0.04,
//                               ),
//                             ),
//                             SizedBox(height: screenHeight * 0.015),
//                             buildPointsSelector(),
//                             SizedBox(height: screenHeight * 0.02),

//                             // Digits Selection
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     "Select Digits",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.orange,
//                                       fontSize: screenWidth * 0.04,
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 Text(
//                                   "Select All Digits 1",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits1),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 2",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits2),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 3",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits3),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 4",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits4),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 5",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits5),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 6",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits6),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 7",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits7),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 8",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits8),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 9",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits9),
//                                 SizedBox(height: screenHeight * 0.02),
//                                 Divider(color: Colors.orange, thickness: screenWidth * 0.003),
//                                 Text(
//                                   "Select All Digits 0",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                     fontSize: screenWidth * 0.035,
//                                   ),
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 buildDigitsGrid(digits0),
//                                 SizedBox(height: screenHeight * 0.02),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Buttons (fixed at bottom)
//                     Padding(
//                       padding: EdgeInsets.only(
//                         bottom: screenHeight * 0.02, 
//                         top: screenHeight * 0.01
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Flexible(
//                             child: ElevatedButton(
//                               onPressed: resetBid,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.orange,
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: screenWidth * 0.06,
//                                   vertical: screenHeight * 0.015,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(screenWidth * 0.1),
//                                 ),
//                               ),
//                               child: Text(
//                                 "RESET BID",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: screenWidth * 0.035,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: screenWidth * 0.02),
//                           Flexible(
//                             child: ElevatedButton(
//                               onPressed: provider.isLoading
//                                   ? null
//                                   : () => _showConfirmationDialog(context),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: provider.isLoading
//                                     ? Colors.grey
//                                     : Colors.orange,
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: screenWidth * 0.06,
//                                   vertical: screenHeight * 0.015,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(screenWidth * 0.1),
//                                 ),
//                               ),
//                               child: provider.isLoading
//                                   ? SizedBox(
//                                       width: screenWidth * 0.05,
//                                       height: screenWidth * 0.05,
//                                       child: CircularProgressIndicator(
//                                         color: Colors.white,
//                                         strokeWidth: screenWidth * 0.005,
//                                       ),
//                                     )
//                                   : Text(
//                                       "SUBMIT BID",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: screenWidth * 0.035,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:dmboss/model/games_model/bulk_dp_model.dart';
import 'package:dmboss/provider/games_provider/bulk_dp_provider.dart';
import 'package:dmboss/widgets/bulk_sp_dp_dialogue.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/game_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  // Added list to store selected digits with total points/amount
  List<Map<String, String>> bids = [];

  void resetBid() {
    setState(() {
      selectedDigits.clear();
      bids.clear(); // Clear the bids list when resetting
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

      // Update the bids list
      final digitStr = digit.toString();
      final amountStr = selectedDigits[digit]!.toString();

      // Check if this digit already exists in bids
      final existingIndex = bids.indexWhere((bid) => bid['digit'] == digitStr);

      if (existingIndex != -1) {
        // Update existing bid
        bids[existingIndex] = {'digit': digitStr, 'amount': amountStr};
      } else {
        // Add new bid
        bids.add({'digit': digitStr, 'amount': amountStr});
      }
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

    final provider = Provider.of<BulkDpBetProvider>(context, listen: false);

    // Set game ID and type (you might want to get these from somewhere)
    provider.setGameId(widget.marketId); // Replace with actual game ID
    provider.setGameType("BULK_DP"); // Changed to bulk_dp for this screen

    // Place the bet
    provider.placeBulkDpBet(context, provider.bulkDpModel);

    resetBid();
    Navigator.pop(context);
  }

  void _showConfirmationDialog(BuildContext context) {
    final totalBids = bids.length;
    final totalBidAmount = bids.fold<int>(
      0,
      (sum, bid) => sum + int.parse(bid['amount']!),
    );

    showDialog(
      context: context,
      builder: (context) => BulkSpBetSummaryDialog(
        title: widget.title,
        date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        bids: bids,
        totalBids: totalBids,
        totalBidAmount: totalBidAmount,
        onConfirm: () {
          Navigator.pop(context);
          submitBid();
        },
      ),
    );
  }

  // Widget buildPointsSelector() {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   final isSmallScreen = screenWidth < 360;
    
  //   return Wrap(
  //     spacing: screenWidth * 0.04,
  //     runSpacing: screenWidth * 0.03,
  //     children: pointsList.map((point) {
  //       bool isSelected = selectedPoint == point;
  //       return GestureDetector(
  //         onTap: () => selectPoint(point),
  //         child: Container(
  //           height: screenWidth * 0.1,
  //           width: screenWidth * 0.2,
  //           decoration: BoxDecoration(
  //             color: Colors.amber.shade100,
  //             border: Border.all(color: Colors.deepOrangeAccent, width: 1.5),
  //           ),
  //           child: Padding(
  //             padding: EdgeInsets.all(screenWidth * 0.005),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Icon(
  //                   Icons.circle,
  //                   color: isSelected ? Colors.red : Colors.green.shade800,
  //                   size: screenWidth * 0.012,
  //                 ),
  //                 Flexible(
  //                   child: ClipOval(
  //                     child: Container(
  //                       height: screenWidth * 0.07,
  //                       width: screenWidth * 0.15,
  //                       decoration: BoxDecoration(
  //                         color: isSelected
  //                             ? Colors.red
  //                             : Colors.green.shade800,
  //                       ),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "₹ $point",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: isSmallScreen ? 10 : 12.5,
  //                         ),
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Icon(
  //                   Icons.circle,
  //                   color: isSelected ? Colors.red : Colors.green.shade800,
  //                   size: screenWidth * 0.012,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
  Widget buildPointsSelector() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Wrap(
      spacing: screenWidth * 0.04,
      runSpacing: screenWidth * 0.03,
      children: pointsList.map((point) {
        bool isSelected = selectedPoint == point;
        return GestureDetector(
          onTap: () => selectPoint(point),
          child: Container(
            height: screenWidth * 0.1,
            width: screenWidth * 0.2,
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              border: Border.all(color: Colors.deepOrangeAccent, width: 1.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.005),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: isSelected ? Colors.red : Colors.green.shade800,
                    size: screenWidth * 0.012,
                  ),
                  Flexible(
                    child: ClipOval(
                      child: Container(
                        height: screenWidth * 0.07,
                        width: screenWidth * 0.15,
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
                            fontSize: isSmallScreen ? 10 : 12.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: isSelected ? Colors.red : Colors.green.shade800,
                    size: screenWidth * 0.012,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final digitItemWidth = screenWidth * 0.15;
    final digitItemHeight = screenWidth * 0.09;
    
    return Wrap(
      spacing: screenWidth * 0.04,
      runSpacing: screenWidth * 0.03,
      children: digits.map((digit) {
        bool isSelected = selectedDigits.containsKey(digit);
        return GestureDetector(
          onTap: () => incrementDigitValue(digit),
          child: Column(
            children: [
              Text(
                "$digit",
                style: TextStyle(
                  fontSize: screenWidth * 0.03, 
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: screenWidth * 0.005),
              Container(
                width: digitItemWidth,
                height: digitItemHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.grey.shade200
                      : Colors.grey.shade300,
                  border: Border.all(
                    color: isSelected
                        ? Colors.orangeAccent
                        : Colors.grey.shade300,
                    width: isSelected ? screenWidth * 0.008 : 0,
                  ),
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: Text(
                  isSelected ? "${selectedDigits[digit]}" : "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.03,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gameStatus = getGameStatus(widget.openTime);
    
    return Consumer<BulkDpBetProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w600, 
                fontSize: screenWidth * 0.045
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: screenWidth * 0.05,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(screenWidth * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.01,
                ),
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Wallet()],
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Fixed top section
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Date Container
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orange,
                                width: screenWidth * 0.005,
                              ),
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                            child: Center(
                              child: Text(
                                widget.gameName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orange,
                                width: screenWidth * 0.005,
                              ),
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                            child: Center(
                              child: Text(
                                gameStatus,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Points Selection
                    Text(
                      "Select Points for Betting",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    buildPointsSelector(),
                    SizedBox(height: screenHeight * 0.02),

                    // Digits Selection Header
                    Center(
                      child: Text(
                        "Select Digits",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                    Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                  ],
                ),
              ),
              
              // Scrollable digits section
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Select All Digits 1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits1),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits2),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits3),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 4",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits4),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits5),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 6",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits6),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 7",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits7),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 8",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits8),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 9",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits9),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: screenWidth * 0.003),
                      Text(
                        "Select All Digits 0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits0),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),

              // Fixed bottom buttons
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: resetBid,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.1),
                          ),
                        ),
                        child: Text(
                          "RESET BID",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () => _showConfirmationDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.isLoading
                              ? Colors.grey
                              : Colors.orange,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.1),
                          ),
                        ),
                        child: provider.isLoading
                            ? SizedBox(
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: screenWidth * 0.005,
                                ),
                              )
                            : Text(
                                "SUBMIT BID",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        );
      },
    );
  }
}