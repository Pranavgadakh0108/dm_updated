// // // import 'package:dmboss/ui/game/widgets/add_button.dart';
// // // import 'package:dmboss/ui/game/widgets/custom_textfield_screen1.dart';
// // // import 'package:dmboss/ui/game/widgets/date_container.dart';
// // // import 'package:dmboss/ui/game/widgets/submit_button.dart';
// // // import 'package:flutter/material.dart';

// // // class GameDetailScreen2 extends StatefulWidget {
// // //   final String title;
// // //   final String gameName;

// // //   const GameDetailScreen2({
// // //     super.key,
// // //     required this.title,
// // //     required this.gameName,
// // //   });
// // //   @override
// // //   State<GameDetailScreen2> createState() => _GameDetailScreen2State();
// // // }

// // // class _GameDetailScreen2State extends State<GameDetailScreen2> {
// // //   final TextEditingController _openController = TextEditingController();
// // //   final TextEditingController _closeController = TextEditingController();
// // //   final TextEditingController _pointsController = TextEditingController();

// // //   bool _openError = false;
// // //   bool _closeError = false;
// // //   bool _pointsError = false;

// // //   List<Map<String, String>> bids = [];

// // //   void _addBid() {
// // //     setState(() {
// // //       _openError = _openController.text.isEmpty;
// // //       _closeError = _openController.text.isEmpty;
// // //       _pointsError = _pointsController.text.isEmpty;

// // //       if (!_openError && !_closeError && !_pointsError) {
// // //         bids.add({
// // //           'digit': "${_openController.text}-${_closeController.text}",
// // //           'points': _pointsController.text,
// // //           'type': 'OPEN',
// // //         });
// // //         _openController.clear();
// // //         _closeController.clear();
// // //         _pointsController.clear();
// // //       }
// // //     });
// // //   }

// // //   void _deleteBid(int index) {
// // //     setState(() {
// // //       bids.removeAt(index);
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.orange,
// // //         title: Text(
// // //           widget.title,
// // //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
// // //         ),
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back_ios),
// // //           onPressed: () {
// // //             Navigator.pop(context);
// // //           },
// // //         ),
// // //         actions: [
// // //           Container(
// // //             margin: const EdgeInsets.all(10),
// // //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// // //             decoration: BoxDecoration(
// // //               color: Colors.white,
// // //               borderRadius: BorderRadius.circular(30),
// // //             ),
// // //             child: Row(
// // //               children: const [
// // //                 Icon(Icons.wallet, color: Colors.black),
// // //                 SizedBox(width: 5),
// // //                 Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(15),
// // //         child: Column(
// // //           children: [
// // //             // Date and Game Name
// // //             Row(
// // //               children: [
// // //                 Expanded(child: DateContainer()),
// // //                 const SizedBox(width: 10),
// // //                 Expanded(
// // //                   child: Container(
// // //                     padding: const EdgeInsets.all(12),
// // //                     decoration: BoxDecoration(
// // //                       border: Border.all(color: Colors.orange, width: 2),
// // //                       borderRadius: BorderRadius.circular(10),
// // //                     ),
// // //                     child: Center(
// // //                       child: Text(
// // //                         widget.gameName,
// // //                         style: const TextStyle(
// // //                           fontWeight: FontWeight.bold,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 15),

// // //             // open Digits
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 SizedBox(width: 10),
// // //                 Text(
// // //                   "Enter Open Digits: ",
// // //                   style: TextStyle(fontWeight: FontWeight.w600),
// // //                 ),
// // //                 SizedBox(width: 50),
// // //                 Expanded(
// // //                   child: CustomTextfieldScreen1(
// // //                     controller: _openController,
// // //                     hintText: "Enter Pana",
// // //                     suffixIcon: _openError
// // //                         ? Builder(
// // //                         builder: (context) {
// // //                           final GlobalKey<TooltipState> tooltipKey =
// // //                               GlobalKey<TooltipState>();
// // //                           return Tooltip(
// // //                             key: tooltipKey,
// // //                             message: "Enter valid Number",
// // //                             triggerMode: TooltipTriggerMode
// // //                                 .manual, // Disable automatic triggers
// // //                             child: IconButton(
// // //                               onPressed: () {
// // //                                 tooltipKey.currentState?.ensureTooltipVisible();
// // //                                 // Hide after 2 seconds
// // //                                 Future.delayed(const Duration(seconds: 2), () {
// // //                                   if (tooltipKey.currentState?.mounted ??
// // //                                       false) {
// // //                                     tooltipKey.currentState?.deactivate();
// // //                                   }
// // //                                 });
// // //                               },
// // //                               icon: const Icon(Icons.error, color: Colors.red),
// // //                             ),
// // //                           );
// // //                         },
// // //                       )
// // //                         : null,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 10),

// // //             //close Panna
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 SizedBox(width: 10),
// // //                 Text(
// // //                   "Enter Close Panna: ",
// // //                   style: TextStyle(fontWeight: FontWeight.w600),
// // //                 ),
// // //                 SizedBox(width: 43),
// // //                 Expanded(
// // //                   child: CustomTextfieldScreen1(
// // //                     controller: _closeController,
// // //                     hintText: "Enter Single",
// // //                     suffixIcon: _closeError
// // //                         ? Builder(
// // //                         builder: (context) {
// // //                           final GlobalKey<TooltipState> tooltipKey =
// // //                               GlobalKey<TooltipState>();
// // //                           return Tooltip(
// // //                             key: tooltipKey,
// // //                             message: "Enter Valid Number",
// // //                             triggerMode: TooltipTriggerMode
// // //                                 .manual, // Disable automatic triggers
// // //                             child: IconButton(
// // //                               onPressed: () {
// // //                                 tooltipKey.currentState?.ensureTooltipVisible();
// // //                                 // Hide after 2 seconds
// // //                                 Future.delayed(const Duration(seconds: 2), () {
// // //                                   if (tooltipKey.currentState?.mounted ??
// // //                                       false) {
// // //                                     tooltipKey.currentState?.deactivate();
// // //                                   }
// // //                                 });
// // //                               },
// // //                               icon: const Icon(Icons.error, color: Colors.red),
// // //                             ),
// // //                           );
// // //                         },
// // //                       )
// // //                         : null,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 10),

// // //             // Enter Points
// // //             Row(
// // //               children: [
// // //                 SizedBox(width: 10),
// // //                 Text(
// // //                   "Enter Points: ",
// // //                   style: TextStyle(fontWeight: FontWeight.w600),
// // //                 ),
// // //                 SizedBox(width: 95),
// // //                 Expanded(
// // //                   child: CustomTextfieldScreen1(
// // //                     controller: _pointsController,
// // //                     hintText: "Enter Points",
// // //                     suffixIcon: _pointsError
// // //                         ? Builder(
// // //                         builder: (context) {
// // //                           final GlobalKey<TooltipState> tooltipKey =
// // //                               GlobalKey<TooltipState>();
// // //                           return Tooltip(
// // //                             key: tooltipKey,
// // //                             message: "Please Enter Amount",
// // //                             triggerMode: TooltipTriggerMode
// // //                                 .manual, // Disable automatic triggers
// // //                             child: IconButton(
// // //                               onPressed: () {
// // //                                 tooltipKey.currentState?.ensureTooltipVisible();
// // //                                 // Hide after 2 seconds
// // //                                 Future.delayed(const Duration(seconds: 2), () {
// // //                                   if (tooltipKey.currentState?.mounted ??
// // //                                       false) {
// // //                                     tooltipKey.currentState?.deactivate();
// // //                                   }
// // //                                 });
// // //                               },
// // //                               icon: const Icon(Icons.error, color: Colors.red),
// // //                             ),
// // //                           );
// // //                         },
// // //                       )
// // //                         : null,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),

// // //             const SizedBox(height: 15),

// // //             // Add Bid Button
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 AddButton(data: "ADD BID", onPressed: _addBid),
// // //                 SizedBox(width: 20),
// // //                 AddButton(data: "FLIP GAME", onPressed: () {}),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 15),

// // //             // Bid List Table
// // //             Expanded(
// // //               child: Container(
// // //                 decoration: BoxDecoration(
// // //                   border: Border.all(color: Colors.orange, width: 2),
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //                 child: Column(
// // //                   children: [
// // //                     Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                         vertical: 8,
// // //                         horizontal: 10,
// // //                       ),
// // //                       child: Padding(
// // //                         padding: const EdgeInsets.only(top: 8),
// // //                         child: Row(
// // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                           children: const [
// // //                             Expanded(
// // //                               child: Text("Digit", textAlign: TextAlign.center),
// // //                             ),
// // //                             Expanded(
// // //                               child: Text(
// // //                                 "Amount",
// // //                                 textAlign: TextAlign.center,
// // //                               ),
// // //                             ),
// // //                             Expanded(
// // //                               child: Text(
// // //                                 "Game type",
// // //                                 textAlign: TextAlign.center,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Padding(
// // //                       padding: const EdgeInsets.all(8.0),
// // //                       child: const Divider(height: 1, color: Colors.black),
// // //                     ),
// // //                     Expanded(
// // //                       child: ListView.builder(
// // //                         itemCount: bids.length,
// // //                         itemBuilder: (context, index) {
// // //                           return Padding(
// // //                             padding: const EdgeInsets.all(8.0),
// // //                             child: Container(
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.white,
// // //                                 borderRadius: BorderRadius.circular(10),
// // //                                 boxShadow: [
// // //                                   BoxShadow(
// // //                                     color: Colors.grey,
// // //                                     blurRadius: 0.5,
// // //                                     spreadRadius: 1,
// // //                                     offset: Offset(0, 1),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               child: ListTile(
// // //                                 title: Row(
// // //                                   children: [
// // //                                     Expanded(
// // //                                       child: Text(
// // //                                         bids[index]['digit']!,
// // //                                         textAlign: TextAlign.center,
// // //                                       ),
// // //                                     ),
// // //                                     Text('|'),
// // //                                     Expanded(
// // //                                       child: Text(
// // //                                         bids[index]['points']!,
// // //                                         textAlign: TextAlign.center,
// // //                                       ),
// // //                                     ),
// // //                                     Text('|'),
// // //                                     Expanded(
// // //                                       child: Row(
// // //                                         mainAxisAlignment:
// // //                                             MainAxisAlignment.center,
// // //                                         children: [
// // //                                           SizedBox(width: 5),
// // //                                           Text(
// // //                                             bids[index]['type']!,
// // //                                             textAlign: TextAlign.center,
// // //                                           ),
// // //                                           const SizedBox(width: 8),
// // //                                           GestureDetector(
// // //                                             onTap: () => _deleteBid(index),
// // //                                             child: const Icon(
// // //                                               Icons.delete,
// // //                                               color: Colors.red,
// // //                                               size: 20,
// // //                                             ),
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                     ),
// // //                                   ],
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           );
// // //                         },
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),

// // //             const SizedBox(height: 10),

// // //             // Submit Button
// // //             SubmitButton(data: "Submit", onPressed: () {}),
// // //             SizedBox(height: 40),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:dmboss/widgets/add_button.dart';
// // import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// // import 'package:dmboss/widgets/date_container.dart';
// // import 'package:dmboss/widgets/submit_button.dart';
// // import 'package:flutter/material.dart';

// // class GameDetailScreen2 extends StatefulWidget {
// //   final String title;
// //   final String gameName;

// //   const GameDetailScreen2({
// //     super.key,
// //     required this.title,
// //     required this.gameName,
// //   });
// //   @override
// //   State<GameDetailScreen2> createState() => _GameDetailScreen2State();
// // }

// // class _GameDetailScreen2State extends State<GameDetailScreen2> {
// //   final TextEditingController _openController = TextEditingController();
// //   final TextEditingController _closeController = TextEditingController();
// //   final TextEditingController _pointsController = TextEditingController();

// //   bool _openError = false;
// //   bool _closeError = false;
// //   bool _pointsError = false;

// //   List<Map<String, String>> bids = [];

// //   void _addBid() {
// //     setState(() {
// //       _openError = _openController.text.isEmpty;
// //       _closeError = _openController.text.isEmpty;
// //       _pointsError = _pointsController.text.isEmpty;

// //       if (!_openError && !_closeError && !_pointsError) {
// //         bids.add({
// //           'digit': "${_openController.text}-${_closeController.text}",
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         _openController.clear();
// //         _closeController.clear();
// //         _pointsController.clear();
// //       }
// //     });
// //   }

// //   void _deleteBid(int index) {
// //     setState(() {
// //       bids.removeAt(index);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.orange,
// //         title: Text(
// //           widget.title,
// //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
// //         ),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //         actions: [
// //           Container(
// //             margin: const EdgeInsets.all(10),
// //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(30),
// //             ),
// //             child: Row(
// //               children: const [
// //                 Icon(Icons.wallet, color: Colors.black),
// //                 SizedBox(width: 5),
// //                 Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           return SingleChildScrollView(
// //             child: ConstrainedBox(
// //               constraints: BoxConstraints(minHeight: constraints.maxHeight),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(15),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     // Date and Game Name
// //                     Row(
// //                       children: [
// //                         Expanded(child: DateContainer()),
// //                         const SizedBox(width: 10),
// //                         Expanded(
// //                           child: Container(
// //                             padding: const EdgeInsets.all(12),
// //                             decoration: BoxDecoration(
// //                               border: Border.all(
// //                                 color: Colors.orange,
// //                                 width: 2,
// //                               ),
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             child: Center(
// //                               child: Text(
// //                                 widget.gameName,
// //                                 style: const TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 15),

// //                     // Open Digits
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         SizedBox(width: 10),
// //                         Text(
// //                           "Enter Open Digits: ",
// //                           style: TextStyle(fontWeight: FontWeight.w600),
// //                         ),
// //                         SizedBox(width: 50),
// //                         Expanded(
// //                           child: CustomTextfieldScreen1(
// //                             controller: _openController,
// //                             hintText: "Enter Pana",
// //                             suffixIcon: _openError
// //                                 ? Builder(
// //                                     builder: (context) {
// //                                       final GlobalKey<TooltipState> tooltipKey =
// //                                           GlobalKey<TooltipState>();
// //                                       return Tooltip(
// //                                         key: tooltipKey,
// //                                         message: "Enter valid Number",
// //                                         triggerMode: TooltipTriggerMode.manual,
// //                                         child: IconButton(
// //                                           onPressed: () {
// //                                             tooltipKey.currentState
// //                                                 ?.ensureTooltipVisible();
// //                                             Future.delayed(
// //                                               const Duration(seconds: 2),
// //                                               () {
// //                                                 if (tooltipKey
// //                                                         .currentState
// //                                                         ?.mounted ??
// //                                                     false) {
// //                                                   tooltipKey.currentState
// //                                                       ?.deactivate();
// //                                                 }
// //                                               },
// //                                             );
// //                                           },
// //                                           icon: const Icon(
// //                                             Icons.error,
// //                                             color: Colors.red,
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                   )
// //                                 : null,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 10),

// //                     // Close Panna
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         SizedBox(width: 10),
// //                         Text(
// //                           "Enter Close Panna: ",
// //                           style: TextStyle(fontWeight: FontWeight.w600),
// //                         ),
// //                         SizedBox(width: 43),
// //                         Expanded(
// //                           child: CustomTextfieldScreen1(
// //                             controller: _closeController,
// //                             hintText: "Enter Single",
// //                             suffixIcon: _closeError
// //                                 ? Builder(
// //                                     builder: (context) {
// //                                       final GlobalKey<TooltipState> tooltipKey =
// //                                           GlobalKey<TooltipState>();
// //                                       return Tooltip(
// //                                         key: tooltipKey,
// //                                         message: "Enter Valid Number",
// //                                         triggerMode: TooltipTriggerMode.manual,
// //                                         child: IconButton(
// //                                           onPressed: () {
// //                                             tooltipKey.currentState
// //                                                 ?.ensureTooltipVisible();
// //                                             Future.delayed(
// //                                               const Duration(seconds: 2),
// //                                               () {
// //                                                 if (tooltipKey
// //                                                         .currentState
// //                                                         ?.mounted ??
// //                                                     false) {
// //                                                   tooltipKey.currentState
// //                                                       ?.deactivate();
// //                                                 }
// //                                               },
// //                                             );
// //                                           },
// //                                           icon: const Icon(
// //                                             Icons.error,
// //                                             color: Colors.red,
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                   )
// //                                 : null,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 10),

// //                     // Enter Points
// //                     Row(
// //                       children: [
// //                         SizedBox(width: 10),
// //                         Text(
// //                           "Enter Points: ",
// //                           style: TextStyle(fontWeight: FontWeight.w600),
// //                         ),
// //                         SizedBox(width: 95),
// //                         Expanded(
// //                           child: CustomTextfieldScreen1(
// //                             controller: _pointsController,
// //                             hintText: "Enter Points",
// //                             suffixIcon: _pointsError
// //                                 ? Builder(
// //                                     builder: (context) {
// //                                       final GlobalKey<TooltipState> tooltipKey =
// //                                           GlobalKey<TooltipState>();
// //                                       return Tooltip(
// //                                         key: tooltipKey,
// //                                         message: "Please Enter Amount",
// //                                         triggerMode: TooltipTriggerMode.manual,
// //                                         child: IconButton(
// //                                           onPressed: () {
// //                                             tooltipKey.currentState
// //                                                 ?.ensureTooltipVisible();
// //                                             Future.delayed(
// //                                               const Duration(seconds: 2),
// //                                               () {
// //                                                 if (tooltipKey
// //                                                         .currentState
// //                                                         ?.mounted ??
// //                                                     false) {
// //                                                   tooltipKey.currentState
// //                                                       ?.deactivate();
// //                                                 }
// //                                               },
// //                                             );
// //                                           },
// //                                           icon: const Icon(
// //                                             Icons.error,
// //                                             color: Colors.red,
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                   )
// //                                 : null,
// //                           ),
// //                         ),
// //                       ],
// //                     ),

// //                     const SizedBox(height: 15),

// //                     // Add Bid Button
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         AddButton(data: "ADD BID", onPressed: _addBid),
// //                         SizedBox(width: 20),
// //                         AddButton(data: "FLIP GAME", onPressed: () {}),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 15),

// //                     // Bid List Table
// //                     Container(
// //                       constraints: BoxConstraints(
// //                         maxHeight: MediaQuery.of(context).size.height * 0.4,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         border: Border.all(color: Colors.orange, width: 2),
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Column(
// //                         children: [
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                               vertical: 8,
// //                               horizontal: 10,
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsets.only(top: 8),
// //                               child: Row(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceBetween,
// //                                 children: const [
// //                                   Expanded(
// //                                     child: Text(
// //                                       "Digit",
// //                                       textAlign: TextAlign.center,
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       "Amount",
// //                                       textAlign: TextAlign.center,
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       "Game type",
// //                                       textAlign: TextAlign.center,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                           Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: const Divider(
// //                               height: 1,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                           Expanded(
// //                             child: ListView.builder(
// //                               itemCount: bids.length,
// //                               itemBuilder: (context, index) {
// //                                 return Padding(
// //                                   padding: const EdgeInsets.all(8.0),
// //                                   child: Container(
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.white,
// //                                       borderRadius: BorderRadius.circular(10),
// //                                       boxShadow: [
// //                                         BoxShadow(
// //                                           color: Colors.grey,
// //                                           blurRadius: 0.5,
// //                                           spreadRadius: 1,
// //                                           offset: Offset(0, 1),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     child: ListTile(
// //                                       title: Row(
// //                                         children: [
// //                                           Expanded(
// //                                             child: Text(
// //                                               bids[index]['digit']!,
// //                                               textAlign: TextAlign.center,
// //                                             ),
// //                                           ),
// //                                           Text('|'),
// //                                           Expanded(
// //                                             child: Text(
// //                                               bids[index]['points']!,
// //                                               textAlign: TextAlign.center,
// //                                             ),
// //                                           ),
// //                                           Text('|'),
// //                                           Expanded(
// //                                             child: Row(
// //                                               mainAxisAlignment:
// //                                                   MainAxisAlignment.center,
// //                                               children: [
// //                                                 SizedBox(width: 5),
// //                                                 Text(
// //                                                   bids[index]['type']!,
// //                                                   textAlign: TextAlign.center,
// //                                                 ),
// //                                                 const SizedBox(width: 8),
// //                                                 GestureDetector(
// //                                                   onTap: () =>
// //                                                       _deleteBid(index),
// //                                                   child: const Icon(
// //                                                     Icons.delete,
// //                                                     color: Colors.red,
// //                                                     size: 20,
// //                                                   ),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),

// //                     const SizedBox(height: 10),

// //                     // Submit Button
// //                     SubmitButton(data: "Submit", onPressed: () {}),
// //                     SizedBox(height: 40),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/widgets/add_button.dart';
// import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// import 'package:dmboss/widgets/date_container.dart';
// import 'package:dmboss/widgets/submit_button.dart';
// import 'package:flutter/material.dart';

// class FullSangam extends StatefulWidget {
//   final String title;
//   final String gameName;

//   const FullSangam({
//     super.key,
//     required this.title,
//     required this.gameName,
//   });
//   @override
//   State<FullSangam> createState() => _FullSangamState();
// }

// class _FullSangamState extends State<FullSangam> {
//   // Controllers for panna fields
//   final TextEditingController _openPannaController = TextEditingController();
//   final TextEditingController _closePannaController = TextEditingController();
//   final TextEditingController _pointsController = TextEditingController();
//   final GlobalKey<FormState> _globalKey = GlobalKey();

//   List<Map<String, String>> bids = [];

//   // Dropdown functionality for open panna field
//   final FocusNode _openPannaFocusNode = FocusNode();
//   final LayerLink _openPannaLayerLink = LayerLink();
//   OverlayEntry? _openPannaOverlayEntry;
//   List<String> _filteredOpenPannaNumbers = [];

//   // Dropdown functionality for close panna field
//   final FocusNode _closePannaFocusNode = FocusNode();
//   final LayerLink _closePannaLayerLink = LayerLink();
//   OverlayEntry? _closePannaOverlayEntry;
//   List<String> _filteredClosePannaNumbers = [];

//   @override
//   void initState() {
//     super.initState();
    
//     // Initialize dropdowns
//     _openPannaController.addListener(() => _filterOpenPannaNumbers());
//     _openPannaFocusNode.addListener(() => _onOpenPannaFocusChange());
//     _filteredOpenPannaNumbers = halfSangam;
    
//     _closePannaController.addListener(() => _filterClosePannaNumbers());
//     _closePannaFocusNode.addListener(() => _onClosePannaFocusChange());
//     _filteredClosePannaNumbers = halfSangam;
//   }

//   @override
//   void dispose() {
//     // Clean up all controllers and focus nodes
//     _openPannaController.dispose();
//     _closePannaController.dispose();
//     _pointsController.dispose();
    
//     _openPannaFocusNode.dispose();
//     _closePannaFocusNode.dispose();
    
//     _removeOpenPannaOverlay();
//     _removeClosePannaOverlay();
    
//     super.dispose();
//   }

//   void _onOpenPannaFocusChange() {
//     if (_openPannaFocusNode.hasFocus && _openPannaController.text.isNotEmpty) {
//       _showOpenPannaDropdownOverlay();
//     } else {
//       _removeOpenPannaOverlay();
//     }
//   }

//   void _filterOpenPannaNumbers() {
//     final input = _openPannaController.text;
//     setState(() {
//       if (input.isEmpty) {
//         _filteredOpenPannaNumbers = halfSangam;
//       } else {
//         try {
//           _filteredOpenPannaNumbers = halfSangam.where((number) {
//             return number.toString().contains(input);
//           }).toList();
//         } catch (e) {
//           _filteredOpenPannaNumbers = [];
//         }
//       }
//     });

//     if (_openPannaFocusNode.hasFocus && _openPannaController.text.isNotEmpty) {
//       if (_openPannaOverlayEntry == null) {
//         _showOpenPannaDropdownOverlay();
//       } else {
//         _openPannaOverlayEntry!.markNeedsBuild();
//       }
//     } else {
//       _removeOpenPannaOverlay();
//     }
//   }

//   void _showOpenPannaDropdownOverlay() {
//     _removeOpenPannaOverlay();

//     _openPannaOverlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: CompositedTransformFollower(
//           link: _openPannaLayerLink,
//           showWhenUnlinked: false,
//           offset: const Offset(0, 40),
//           child: Material(
//             elevation: 4,
//             child: Container(
//               constraints: const BoxConstraints(maxHeight: 200),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: _filteredOpenPannaNumbers.length,
//                 itemBuilder: (context, index) {
//                   final number = _filteredOpenPannaNumbers[index];
//                   return ListTile(
//                     title: Text(number.toString()),
//                     onTap: () {
//                       setState(() {
//                         _openPannaController.text = number.toString();
//                         _openPannaController.selection = TextSelection.fromPosition(
//                           TextPosition(offset: _openPannaController.text.length),
//                         );
//                       });
//                       _removeOpenPannaOverlay();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_openPannaOverlayEntry!);
//   }

//   void _removeOpenPannaOverlay() {
//     if (_openPannaOverlayEntry != null) {
//       _openPannaOverlayEntry!.remove();
//       _openPannaOverlayEntry = null;
//     }
//   }

//   // Close Panna methods
//   void _onClosePannaFocusChange() {
//     if (_closePannaFocusNode.hasFocus && _closePannaController.text.isNotEmpty) {
//       _showClosePannaDropdownOverlay();
//     } else {
//       _removeClosePannaOverlay();
//     }
//   }

//   void _filterClosePannaNumbers() {
//     final input = _closePannaController.text;
//     setState(() {
//       if (input.isEmpty) {
//         _filteredClosePannaNumbers = halfSangam;
//       } else {
//         try {
//           _filteredClosePannaNumbers = halfSangam.where((number) {
//             return number.toString().contains(input);
//           }).toList();
//         } catch (e) {
//           _filteredClosePannaNumbers = [];
//         }
//       }
//     });

//     if (_closePannaFocusNode.hasFocus && _closePannaController.text.isNotEmpty) {
//       if (_closePannaOverlayEntry == null) {
//         _showClosePannaDropdownOverlay();
//       } else {
//         _closePannaOverlayEntry!.markNeedsBuild();
//       }
//     } else {
//       _removeClosePannaOverlay();
//     }
//   }

//   void _showClosePannaDropdownOverlay() {
//     _removeClosePannaOverlay();

//     _closePannaOverlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: CompositedTransformFollower(
//           link: _closePannaLayerLink,
//           showWhenUnlinked: false,
//           offset: const Offset(0, 40),
//           child: Material(
//             elevation: 4,
//             child: Container(
//               constraints: const BoxConstraints(maxHeight: 200),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: _filteredClosePannaNumbers.length,
//                 itemBuilder: (context, index) {
//                   final number = _filteredClosePannaNumbers[index];
//                   return ListTile(
//                     title: Text(number.toString()),
//                     onTap: () {
//                       setState(() {
//                         _closePannaController.text = number.toString();
//                         _closePannaController.selection = TextSelection.fromPosition(
//                           TextPosition(offset: _closePannaController.text.length),
//                         );
//                       });
//                       _removeClosePannaOverlay();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_closePannaOverlayEntry!);
//   }

//   void _removeClosePannaOverlay() {
//     if (_closePannaOverlayEntry != null) {
//       _closePannaOverlayEntry!.remove();
//       _closePannaOverlayEntry = null;
//     }
//   }

//   void _addBid() {
//     if (_globalKey.currentState!.validate()) {
//       setState(() {
//         // Store both the original values and the combined display value
//         bids.add({
//           'openPanna': _openPannaController.text,
//           'closePanna': _closePannaController.text,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//           'displayDigit': "${_openPannaController.text}-${_closePannaController.text}",
//         });
        
//         // Clear all fields
//         _openPannaController.clear();
//         _closePannaController.clear();
//         _pointsController.clear();
        
//         // Remove any active overlays
//         _removeOpenPannaOverlay();
//         _removeClosePannaOverlay();
//       });
//     }
//   }

//   void _deleteBid(int index) {
//     setState(() {
//       bids.removeAt(index);
//     });
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
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               children: const [
//                 Icon(Icons.wallet, color: Colors.black),
//                 SizedBox(width: 5),
//                 Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Date and Game Name
//                     Row(
//                       children: [
//                         Expanded(child: DateContainer()),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.orange,
//                                 width: 2,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 widget.gameName,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 15),

//                     Form(
//                       key: _globalKey,
//                       child: Column(
//                         children: [
//                           // Open Panna field
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Enter Open Pana: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 50),
//                               Expanded(
//                                 child: CompositedTransformTarget(
//                                   link: _openPannaLayerLink,
//                                   child: CustomTextfieldScreen1(
//                                     controller: _openPannaController,
//                                     focusNode: _openPannaFocusNode,
//                                     hintText: "Enter Pana",
//                                     onChanged: (value) {
//                                       // For Panna - limit to 3 digits
//                                       if (value.length > 3) {
//                                         _openPannaController.text = value.substring(0, 3);
//                                         _openPannaController.selection = TextSelection.fromPosition(
//                                           TextPosition(offset: 3),
//                                         );
//                                       } else {
//                                         _openPannaController.text = value;
//                                       }
//                                     },
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty || !halfSangam.contains(value)) {
//                                         return "Enter valid pana";
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),

//                           // Close Panna field
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Enter Close Pana: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 43),
//                               Expanded(
//                                 child: CompositedTransformTarget(
//                                   link: _closePannaLayerLink,
//                                   child: CustomTextfieldScreen1(
//                                     controller: _closePannaController,
//                                     focusNode: _closePannaFocusNode,
//                                     hintText: "Enter Pana",
//                                     onChanged: (value) {
//                                       // For Panna - limit to 3 digits
//                                       if (value.length > 3) {
//                                         _closePannaController.text = value.substring(0, 3);
//                                         _closePannaController.selection = TextSelection.fromPosition(
//                                           TextPosition(offset: 3),
//                                         );
//                                       } else {
//                                         _closePannaController.text = value;
//                                       }
//                                     },
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty || !halfSangam.contains(value)) {
//                                         return "Enter valid pana";
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
                          
//                           // Enter Points
//                           Row(
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Enter Points: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 95),
//                               Expanded(
//                                 child: CustomTextfieldScreen1(
//                                   controller: _pointsController,
//                                   hintText: "Enter Points",
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _pointsController.text = value;
//                                     });
//                                   },
//                                   validator: (value) {
//                                     if (value == null ||
//                                         value.isEmpty ||
//                                         int.parse(value) < 10 ||
//                                         int.parse(value) > 1000) {
//                                       return "Enter amount \nbetween 10 - 1000";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 15),

//                           // Add Bid Button
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               AddButton(data: "ADD BID", onPressed: _addBid),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 15),

//                     // Bid List Table
//                     Container(
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.4,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.orange, width: 2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8,
//                               horizontal: 10,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: const [
//                                   Expanded(
//                                     child: Text(
//                                       "Pana",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "Amount",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "Game type",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: const Divider(
//                               height: 1,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: bids.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 0.5,
//                                           spreadRadius: 1,
//                                           offset: Offset(0, 1),
//                                         ),
//                                       ],
//                                     ),
//                                     child: ListTile(
//                                       title: Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               bids[index]['displayDigit']!,
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                           Text('|'),
//                                           Expanded(
//                                             child: Text(
//                                               bids[index]['points']!,
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                           Text('|'),
//                                           Expanded(
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 SizedBox(width: 5),
//                                                 Text(
//                                                   bids[index]['type']!,
//                                                   textAlign: TextAlign.center,
//                                                 ),
//                                                 const SizedBox(width: 8),
//                                                 GestureDetector(
//                                                   onTap: () =>
//                                                       _deleteBid(index),
//                                                   child: const Icon(
//                                                     Icons.delete,
//                                                     color: Colors.red,
//                                                     size: 20,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     // Submit Button
//                     SubmitButton(data: "Submit", onPressed: () {}),
//                     SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/date_container.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class FullSangam extends StatefulWidget {
  final String title;
  final String gameName;

  const FullSangam({
    super.key,
    required this.title,
    required this.gameName,
  });
  @override
  State<FullSangam> createState() => _FullSangamState();
}

class _FullSangamState extends State<FullSangam> {
  // Controllers for panna fields
  final TextEditingController _openPannaController = TextEditingController();
  final TextEditingController _closePannaController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  List<Map<String, String>> bids = [];

  // Dropdown functionality for open panna field
  final FocusNode _openPannaFocusNode = FocusNode();
  final LayerLink _openPannaLayerLink = LayerLink();
  OverlayEntry? _openPannaOverlayEntry;
  List<String> _filteredOpenPannaNumbers = [];

  // Dropdown functionality for close panna field
  final FocusNode _closePannaFocusNode = FocusNode();
  final LayerLink _closePannaLayerLink = LayerLink();
  OverlayEntry? _closePannaOverlayEntry;
  List<String> _filteredClosePannaNumbers = [];

  @override
  void initState() {
    super.initState();
    
    // Initialize dropdowns
    _openPannaController.addListener(() => _filterOpenPannaNumbers());
    _openPannaFocusNode.addListener(() => _onOpenPannaFocusChange());
    _filteredOpenPannaNumbers = halfSangam;
    
    _closePannaController.addListener(() => _filterClosePannaNumbers());
    _closePannaFocusNode.addListener(() => _onClosePannaFocusChange());
    _filteredClosePannaNumbers = halfSangam;
  }

  @override
  void dispose() {
    // Clean up all controllers and focus nodes
    _openPannaController.dispose();
    _closePannaController.dispose();
    _pointsController.dispose();
    
    _openPannaFocusNode.dispose();
    _closePannaFocusNode.dispose();
    
    _removeOpenPannaOverlay();
    _removeClosePannaOverlay();
    
    super.dispose();
  }

  void _onOpenPannaFocusChange() {
    if (_openPannaFocusNode.hasFocus) {
      _showOpenPannaDropdownOverlay();
    } else {
      _removeOpenPannaOverlay();
    }
  }

  void _filterOpenPannaNumbers() {
    final input = _openPannaController.text;
    setState(() {
      if (input.isEmpty) {
        _filteredOpenPannaNumbers = halfSangam;
      } else {
        try {
          _filteredOpenPannaNumbers = halfSangam.where((number) {
            return number.toString().contains(input);
          }).toList();
        } catch (e) {
          _filteredOpenPannaNumbers = [];
        }
      }
    });

    if (_openPannaFocusNode.hasFocus) {
      if (_openPannaOverlayEntry == null) {
        _showOpenPannaDropdownOverlay();
      } else {
        _openPannaOverlayEntry!.markNeedsBuild();
      }
    } else {
      _removeOpenPannaOverlay();
    }
  }

  void _showOpenPannaDropdownOverlay() {
    _removeOpenPannaOverlay();

    _openPannaOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.5,
        child: CompositedTransformFollower(
          link: _openPannaLayerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 40),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredOpenPannaNumbers.length,
                itemBuilder: (context, index) {
                  final number = _filteredOpenPannaNumbers[index];
                  return ListTile(
                    title: Text(number.toString()),
                    onTap: () {
                      setState(() {
                        _openPannaController.text = number.toString();
                        _openPannaController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _openPannaController.text.length),
                        );
                      });
                      _removeOpenPannaOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_openPannaOverlayEntry!);
  }

  void _removeOpenPannaOverlay() {
    if (_openPannaOverlayEntry != null) {
      _openPannaOverlayEntry!.remove();
      _openPannaOverlayEntry = null;
    }
  }

  // Close Panna methods
  void _onClosePannaFocusChange() {
    if (_closePannaFocusNode.hasFocus) {
      _showClosePannaDropdownOverlay();
    } else {
      _removeClosePannaOverlay();
    }
  }

  void _filterClosePannaNumbers() {
    final input = _closePannaController.text;
    setState(() {
      if (input.isEmpty) {
        _filteredClosePannaNumbers = halfSangam;
      } else {
        try {
          _filteredClosePannaNumbers = halfSangam.where((number) {
            return number.toString().contains(input);
          }).toList();
        } catch (e) {
          _filteredClosePannaNumbers = [];
        }
      }
    });

    if (_closePannaFocusNode.hasFocus) {
      if (_closePannaOverlayEntry == null) {
        _showClosePannaDropdownOverlay();
      } else {
        _closePannaOverlayEntry!.markNeedsBuild();
      }
    } else {
      _removeClosePannaOverlay();
    }
  }

  void _showClosePannaDropdownOverlay() {
    _removeClosePannaOverlay();

    _closePannaOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.5,
        child: CompositedTransformFollower(
          link: _closePannaLayerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 40),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredClosePannaNumbers.length,
                itemBuilder: (context, index) {
                  final number = _filteredClosePannaNumbers[index];
                  return ListTile(
                    title: Text(number.toString()),
                    onTap: () {
                      setState(() {
                        _closePannaController.text = number.toString();
                        _closePannaController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _closePannaController.text.length),
                        );
                      });
                      _removeClosePannaOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_closePannaOverlayEntry!);
  }

  void _removeClosePannaOverlay() {
    if (_closePannaOverlayEntry != null) {
      _closePannaOverlayEntry!.remove();
      _closePannaOverlayEntry = null;
    }
  }

  void _addBid() {
    if (_globalKey.currentState!.validate()) {
      setState(() {
        // Store both the original values and the combined display value
        bids.add({
          'openPanna': _openPannaController.text,
          'closePanna': _closePannaController.text,
          'points': _pointsController.text,
          'type': 'OPEN',
          'displayDigit': "${_openPannaController.text}-${_closePannaController.text}",
        });
        
        // Clear all fields
        _openPannaController.clear();
        _closePannaController.clear();
        _pointsController.clear();
        
        // Remove any active overlays
        _removeOpenPannaOverlay();
        _removeClosePannaOverlay();
      });
    }
  }

  void _deleteBid(int index) {
    setState(() {
      bids.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: const [
                Icon(Icons.wallet, color: Colors.black),
                SizedBox(width: 5),
                Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Date and Game Name
                    Row(
                      children: [
                        Expanded(child: DateContainer()),
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
                                widget.gameName,
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

                    Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          // Open Panna field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "Enter Open Pana: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 50),
                              Expanded(
                                child: CompositedTransformTarget(
                                  link: _openPannaLayerLink,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(_openPannaFocusNode);
                                      _showOpenPannaDropdownOverlay();
                                    },
                                    child: CustomTextfieldScreen1(
                                      controller: _openPannaController,
                                      focusNode: _openPannaFocusNode,
                                      hintText: "Enter Pana",
                                      onChanged: (value) {
                                        // For Panna - limit to 3 digits
                                        if (value.length > 3) {
                                          _openPannaController.text = value.substring(0, 3);
                                          _openPannaController.selection = TextSelection.fromPosition(
                                            TextPosition(offset: 3),
                                          );
                                        } else {
                                          _openPannaController.text = value;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty || !halfSangam.contains(value)) {
                                          return "Enter valid pana";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Close Panna field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "Enter Close Pana: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 43),
                              Expanded(
                                child: CompositedTransformTarget(
                                  link: _closePannaLayerLink,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(_closePannaFocusNode);
                                      _showClosePannaDropdownOverlay();
                                    },
                                    child: CustomTextfieldScreen1(
                                      controller: _closePannaController,
                                      focusNode: _closePannaFocusNode,
                                      hintText: "Enter Pana",
                                      onChanged: (value) {
                                        // For Panna - limit to 3 digits
                                        if (value.length > 3) {
                                          _closePannaController.text = value.substring(0, 3);
                                          _closePannaController.selection = TextSelection.fromPosition(
                                            TextPosition(offset: 3),
                                          );
                                        } else {
                                          _closePannaController.text = value;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty || !halfSangam.contains(value)) {
                                          return "Enter valid pana";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          
                          // Enter Points
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "Enter Points: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 95),
                              Expanded(
                                child: CustomTextfieldScreen1(
                                  controller: _pointsController,
                                  hintText: "Enter Points",
                                  onChanged: (value) {
                                    setState(() {
                                      _pointsController.text = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.parse(value) < 10 ||
                                        int.parse(value) > 1000) {
                                      return "Enter amount \nbetween 10 - 1000";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // Add Bid Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AddButton(data: "ADD BID", onPressed: _addBid),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Bid List Table
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                    child: Text(
                                      "Pana",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Amount",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Game type",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Divider(
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: bids.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.5,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              bids[index]['displayDigit']!,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Text('|'),
                                          Expanded(
                                            child: Text(
                                              bids[index]['points']!,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Text('|'),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 5),
                                                Text(
                                                  bids[index]['type']!,
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(width: 8),
                                                GestureDetector(
                                                  onTap: () =>
                                                      _deleteBid(index),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Submit Button
                    SubmitButton(data: "Submit", onPressed: () {}),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}