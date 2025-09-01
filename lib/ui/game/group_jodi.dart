// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/widgets/add_button.dart';
// import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// import 'package:dmboss/widgets/date_container.dart';
// import 'package:dmboss/widgets/submit_button.dart';
// import 'package:flutter/material.dart';

// class GroupJodi extends StatefulWidget {
//   final String title;
//   final String gameName;
//   const GroupJodi({super.key, required this.title, required this.gameName});

//   @override
//   State<GroupJodi> createState() => _GroupJodiState();
// }

// class _GroupJodiState extends State<GroupJodi> {
//   final TextEditingController _digitController = TextEditingController();
//   final TextEditingController _pointsController = TextEditingController();
//   final GlobalKey<FormState> _globalKey = GlobalKey();

//   bool _digitError = false;
//   bool _pointsError = false;

//   List<Map<String, String>> bids = [];

//   // New variables for dropdown functionality
//   final FocusNode _digitFocusNode = FocusNode();
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;

//   List<String> _filteredNumbers = [];

//   @override
//   void initState() {
//     super.initState();
//     _digitController.addListener(_filterNumbers);
//     _digitFocusNode.addListener(_onFocusChange);
//     _filteredNumbers = jodiNumbers;
//   }

//   @override
//   void dispose() {
//     _digitController.removeListener(_filterNumbers);
//     _digitFocusNode.removeListener(_onFocusChange);
//     _digitFocusNode.dispose();
//     _removeOverlay();
//     super.dispose();
//   }

//   void _onFocusChange() {
//     if (_digitFocusNode.hasFocus && _digitController.text.isNotEmpty) {
//       _showDropdownOverlay();
//     } else {
//       _removeOverlay();
//     }
//   }

//   void _filterNumbers() {
//     final input = _digitController.text;
//     setState(() {
//       if (input.isEmpty) {
//         _filteredNumbers = jodiNumbers;
//       } else {
//         try {
//           _filteredNumbers = jodiNumbers.where((number) {
//             return number.toString().contains(input);
//           }).toList();
//         } catch (e) {
//           _filteredNumbers = [];
//         }
//       }
//     });

//     if (_digitFocusNode.hasFocus && _digitController.text.isNotEmpty) {
//       if (_overlayEntry == null) {
//         _showDropdownOverlay();
//       } else {
//         _overlayEntry!.markNeedsBuild();
//       }
//     } else {
//       _removeOverlay();
//     }
//   }

//   void _showDropdownOverlay() {
//     _removeOverlay();

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: CompositedTransformFollower(
//           link: _layerLink,
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
//                 itemCount: _filteredNumbers.length,
//                 itemBuilder: (context, index) {
//                   final number = _filteredNumbers[index];
//                   return ListTile(
//                     title: Text(number.toString()),
//                     onTap: () {
//                       setState(() {
//                         _digitController.text = number.toString();
//                         _digitController.selection = TextSelection.fromPosition(
//                           TextPosition(offset: _digitController.text.length),
//                         );
//                       });
//                       _removeOverlay();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     if (_overlayEntry != null) {
//       _overlayEntry!.remove();
//       _overlayEntry = null;
//     }
//   }

//   void _addBid() {
//     if (_globalKey.currentState!.validate()) {
//       setState(() {
//         _digitError = _digitController.text.isEmpty;
//         _pointsError = _pointsController.text.isEmpty;

//         if (!_digitError && !_pointsError) {
//           bids.add({
//             'digit': _digitController.text,
//             'points': _pointsController.text,
//             'type': 'OPEN',
//           });
//           _digitController.clear();
//           _pointsController.clear();
//           _removeOverlay();
//         }
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
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.02,
//               vertical: MediaQuery.of(context).size.height * 0.006,
//             ),
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
//                 padding: EdgeInsets.all(
//                   MediaQuery.of(context).size.width * 0.04,
//                 ),
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

//                     // Bid Digits
//                     Form(
//                       key: _globalKey,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Bid Digits: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 50),
//                               Expanded(
//                                 child: CompositedTransformTarget(
//                                   link: _layerLink,
//                                   child: CustomTextfieldScreen1(
//                                     controller: _digitController,
//                                     focusNode: _digitFocusNode,
//                                     hintText: "Number",
//                                     onChanged: (value) {
//                                       // Limit input to single digit only
//                                       if (value.length > 2) {
//                                         _digitController.text = value[0];
//                                         _digitController.selection =
//                                             TextSelection.fromPosition(
//                                               TextPosition(offset: 1),
//                                             );
//                                       } else {
//                                         _digitController.text = value;
//                                       }
//                                     },
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty || !jodiNumbers.contains(value)) {
//                                         return "Input don't have any family \njodi";
//                                       }
//                                       if (value.length > 2) {
//                                         return "Only two digit allowed";
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),

//                           // Bid Points
//                           Row(
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Bid Points: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 47),
//                               Expanded(
//                                 child: CustomTextfieldScreen1(
//                                   controller: _pointsController,
//                                   hintText: "Point",
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _pointsController.text = value;
//                                     });
//                                   },
//                                   validator: (value) {
//                                     if (value == null ||
//                                         value.isEmpty ||
//                                         int.parse(value) < 10 ||
//                                         int.parse(value) > 10000) {
//                                       return "Enter amount between \n10 - 10000";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 15),

//                           // Add Bid Button
//                           AddButton(data: "ADD BID", onPressed: _addBid),
//                           const SizedBox(height: 15),
//                         ],
//                       ),
//                     ),

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
//                                       "Digit",
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
//                             padding: EdgeInsets.all(
//                               MediaQuery.of(context).size.width * 0.02,
//                             ),
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
//                                               bids[index]['digit']!,
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

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/widgets/add_button.dart';
// import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// import 'package:dmboss/widgets/date_container.dart';
// import 'package:dmboss/widgets/submit_button.dart';
// import 'package:flutter/material.dart';

// class GroupJodi extends StatefulWidget {
//   final String title;
//   final String gameName;
//   const GroupJodi({super.key, required this.title, required this.gameName});

//   @override
//   State<GroupJodi> createState() => _GroupJodiState();
// }

// class _GroupJodiState extends State<GroupJodi> {
//   final TextEditingController _digitController = TextEditingController();
//   final TextEditingController _pointsController = TextEditingController();
//   final GlobalKey<FormState> _globalKey = GlobalKey();

//   bool _digitError = false;
//   bool _pointsError = false;

//   List<Map<String, String>> bids = [];

//   // New variables for dropdown functionality
//   final FocusNode _digitFocusNode = FocusNode();
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;

//   List<String> _filteredNumbers = [];
//   bool _isDropdownVisible = false;

//   // Function to generate cut types based on the selected digit
//   List<Map<String, String>> _generateCutTypes(String originalDigit) {
//     List<Map<String, String>> result = [];
//     String currentDigit = originalDigit;
//     int level = 0;

//     // Check if the original digit has same numbers
//     bool isSameDigit = originalDigit[0] == originalDigit[1];

//     while (level < 8) {
//       // Calculate both cut for the current digit
//       int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
//       int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
//       String bothCut = '$tensDigit$unitsDigit';

//       // Add both cut
//       result.add({
//         'digit': bothCut,
//         'points': _pointsController.text,
//         'type': 'OPEN',
//       });
//       level++;
//       if (level >= 8) break;

//       // For same digits, check if we've returned to the original digit
//       if (isSameDigit && bothCut == originalDigit) {
//         break;
//       }

//       // Calculate close cut (only add to units place of the both cut)
//       int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
//       String closeCut = '${bothCut[0]}$closeUnitsDigit';

//       // Add close cut
//       result.add({
//         'digit': closeCut,
//         'points': _pointsController.text,
//         'type': 'OPEN',
//       });
//       level++;
//       if (level >= 8) break;

//       // For same digits, check if we've returned to the original digit
//       if (isSameDigit && closeCut == originalDigit) {
//         break;
//       }

//       // Check if close cut matches original digit
//       if (closeCut == originalDigit && level < 8) {
//         // Do palti (reverse the original digits)
//         String reversed = '${originalDigit[1]}${originalDigit[0]}';
//         result.add({
//           'digit': reversed,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;

//         // 🔹 Special condition for 50 → stop after palti
//         if (originalDigit == "50") {
//           break;
//         }

//         if (level >= 8) break;

//         // For same digits, check if we've returned to the original digit
//         if (isSameDigit && reversed == originalDigit) {
//           break;
//         }

//         // After palti, we should do CLOSE CUT, not BOTH CUT
//         int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
//         String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

//         result.add({
//           'digit': paltiCloseCut,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;
//         if (level >= 8) break;

//         // For same digits, check if we've returned to the original digit
//         if (isSameDigit && paltiCloseCut == originalDigit) {
//           break;
//         }

//         // Then do both cut of the palti close cut
//         int paltiBothTensDigit = (int.parse(paltiCloseCut[0]) + 5) % 10;
//         int paltiBothUnitsDigit = (int.parse(paltiCloseCut[1]) + 5) % 10;
//         String paltiBothCut = '$paltiBothTensDigit$paltiBothUnitsDigit';

//         result.add({
//           'digit': paltiBothCut,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;
//         if (level >= 8) break;

//         // For same digits, check if we've returned to the original digit
//         if (isSameDigit && paltiBothCut == originalDigit) {
//           break;
//         }

//         // Finally do close cut of the palti both cut
//         int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
//         String paltiFinalCloseCut =
//             '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

//         result.add({
//           'digit': paltiFinalCloseCut,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;

//         // For same digits, check if we've returned to the original digit
//         if (isSameDigit && paltiFinalCloseCut == originalDigit) {
//           break;
//         }

//         // Break the loop after palti to avoid extra iterations
//         break;
//       } else {
//         // Set current digit to the close cut for the next iteration
//         currentDigit = closeCut;
//       }
//     }

//     return result;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _digitController.addListener(_filterNumbers);
//     _digitFocusNode.addListener(_onFocusChange);
//     _filteredNumbers = jodiNumbers;
//   }

//   @override
//   void dispose() {
//     _digitController.removeListener(_filterNumbers);
//     _digitFocusNode.removeListener(_onFocusChange);
//     _digitFocusNode.dispose();
//     _removeOverlay();
//     super.dispose();
//   }

//   void _onFocusChange() {
//     if (_digitFocusNode.hasFocus) {
//       _showDropdownOverlay();
//     } else {
//       _removeOverlay();
//     }
//   }

//   void _filterNumbers() {
//     final input = _digitController.text;
//     setState(() {
//       if (input.isEmpty) {
//         _filteredNumbers = jodiNumbers;
//       } else {
//         try {
//           _filteredNumbers = jodiNumbers.where((number) {
//             return number.toString().contains(input);
//           }).toList();
//         } catch (e) {
//           _filteredNumbers = [];
//         }
//       }
//     });

//     if (_digitFocusNode.hasFocus) {
//       if (_overlayEntry == null) {
//         _showDropdownOverlay();
//       } else {
//         _overlayEntry!.markNeedsBuild();
//       }
//     } else {
//       _removeOverlay();
//     }
//   }

//   void _showDropdownOverlay() {
//     _removeOverlay();

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: CompositedTransformFollower(
//           link: _layerLink,
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
//                 itemCount: _filteredNumbers.length,
//                 itemBuilder: (context, index) {
//                   final number = _filteredNumbers[index];
//                   return ListTile(
//                     title: Text(number.toString()),
//                     onTap: () {
//                       setState(() {
//                         _digitController.text = number.toString();
//                         _digitController.selection = TextSelection.fromPosition(
//                           TextPosition(offset: _digitController.text.length),
//                         );
//                       });
//                       _removeOverlay();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//     setState(() {
//       _isDropdownVisible = true;
//     });
//   }

//   void _removeOverlay() {
//     if (_overlayEntry != null) {
//       _overlayEntry!.remove();
//       _overlayEntry = null;
//       setState(() {
//         _isDropdownVisible = false;
//       });
//     }
//   }

//   void _addBid() {
//     if (_globalKey.currentState!.validate()) {
//       setState(() {
//         _digitError = _digitController.text.isEmpty;
//         _pointsError = _pointsController.text.isEmpty;

//         if (!_digitError && !_pointsError) {
//           // Add the main bid
//           bids.add({
//             'digit': _digitController.text,
//             'points': _pointsController.text,
//             'type': 'OPEN',
//           });

//           // Generate and add the cut types
//           List<Map<String, String>> cutTypes = _generateCutTypes(
//             _digitController.text,
//           );
//           bids.addAll(cutTypes);

//           _digitController.clear();
//           _pointsController.clear();
//           _removeOverlay();
//         }
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
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.02,
//               vertical: MediaQuery.of(context).size.height * 0.006,
//             ),
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
//                 padding: EdgeInsets.all(
//                   MediaQuery.of(context).size.width * 0.04,
//                 ),
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

//                     // Bid Digits
//                     Form(
//                       key: _globalKey,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Bid Digits: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 50),
//                               Expanded(
//                                 child: CompositedTransformTarget(
//                                   link: _layerLink,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       if (!_isDropdownVisible) {
//                                         _digitFocusNode.requestFocus();
//                                         _showDropdownOverlay();
//                                       }
//                                     },
//                                     child: CustomTextfieldScreen1(
//                                       controller: _digitController,
//                                       focusNode: _digitFocusNode,
//                                       hintText: "Number",
//                                       onChanged: (value) {
//                                         // Limit input to two digits only
//                                         if (value.length > 2) {
//                                           _digitController.text = value
//                                               .substring(0, 2);
//                                           _digitController.selection =
//                                               TextSelection.fromPosition(
//                                                 TextPosition(offset: 2),
//                                               );
//                                         } else {
//                                           _digitController.text = value;
//                                         }
//                                       },
//                                       validator: (value) {
//                                         if (value == null ||
//                                             value.isEmpty ||
//                                             !jodiNumbers.contains(value)) {
//                                           return "Input don't have any family \njodi";
//                                         }
//                                         if (value.length != 2) {
//                                           return "Exactly two digits required";
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),

//                           // Bid Points
//                           Row(
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 "Bid Points: ",
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 47),
//                               Expanded(
//                                 child: CustomTextfieldScreen1(
//                                   controller: _pointsController,
//                                   hintText: "Point",
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _pointsController.text = value;
//                                     });
//                                   },
//                                   validator: (value) {
//                                     if (value == null ||
//                                         value.isEmpty ||
//                                         int.parse(value) < 10 ||
//                                         int.parse(value) > 10000) {
//                                       return "Enter amount between \n10 - 10000";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 15),

//                           // Add Bid Button
//                           AddButton(data: "ADD BID", onPressed: _addBid),
//                           const SizedBox(height: 15),
//                         ],
//                       ),
//                     ),

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
//                                       "Digit",
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
//                             padding: EdgeInsets.all(
//                               MediaQuery.of(context).size.width * 0.02,
//                             ),
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
//                                               bids[index]['digit']!,
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
import 'package:dmboss/model/games_model/single_ank_model.dart';
import 'package:dmboss/provider/games_provider/group_jodi_provider.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/date_container.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Add these imports for the provider and model (create these if they don't exist)
// import 'package:dmboss/providers/group_jodi_bet_provider.dart';
// import 'package:dmboss/models/group_jodi_model.dart';

class GroupJodi extends StatefulWidget {
  final String title;
  final String gameName;
  final String marketId; // Added marketId parameter
  const GroupJodi({
    super.key, 
    required this.title, 
    required this.gameName,
    required this.marketId, // Added to constructor
  });

  @override
  State<GroupJodi> createState() => _GroupJodiState();
}

class _GroupJodiState extends State<GroupJodi> {
  final TextEditingController _digitController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  bool _digitError = false;
  bool _pointsError = false;

  List<Map<String, String>> bids = [];

  // New variables for dropdown functionality
  final FocusNode _digitFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<String> _filteredNumbers = [];
  bool _isDropdownVisible = false;

  // Function to generate cut types based on the selected digit
  List<Map<String, String>> _generateCutTypes(String originalDigit) {
    List<Map<String, String>> result = [];
    String currentDigit = originalDigit;
    int level = 0;

    // Check if the original digit has same numbers
    bool isSameDigit = originalDigit[0] == originalDigit[1];

    while (level < 8) {
      // Calculate both cut for the current digit
      int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
      int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
      String bothCut = '$tensDigit$unitsDigit';

      // Add both cut
      result.add({
        'digit': bothCut,
        'points': _pointsController.text,
        'type': 'OPEN',
      });
      level++;
      if (level >= 8) break;

      // For same digits, check if we've returned to the original digit
      if (isSameDigit && bothCut == originalDigit) {
        break;
      }

      // Calculate close cut (only add to units place of the both cut)
      int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
      String closeCut = '${bothCut[0]}$closeUnitsDigit';

      // Add close cut
      result.add({
        'digit': closeCut,
        'points': _pointsController.text,
        'type': 'OPEN',
      });
      level++;
      if (level >= 8) break;

      // For same digits, check if we've returned to the original digit
      if (isSameDigit && closeCut == originalDigit) {
        break;
      }

      // Check if close cut matches original digit
      if (closeCut == originalDigit && level < 8) {
        // Do palti (reverse the original digits)
        String reversed = '${originalDigit[1]}${originalDigit[0]}';
        result.add({
          'digit': reversed,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;

        // 🔹 Special condition for 50 → stop after palti
        if (originalDigit == "50") {
          break;
        }

        if (level >= 8) break;

        // For same digits, check if we've returned to the original digit
        if (isSameDigit && reversed == originalDigit) {
          break;
        }

        // After palti, we should do CLOSE CUT, not BOTH CUT
        int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
        String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

        result.add({
          'digit': paltiCloseCut,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;
        if (level >= 8) break;

        // For same digits, check if we've returned to the original digit
        if (isSameDigit && paltiCloseCut == originalDigit) {
          break;
        }

        // Then do both cut of the palti close cut
        int paltiBothTensDigit = (int.parse(paltiCloseCut[0]) + 5) % 10;
        int paltiBothUnitsDigit = (int.parse(paltiCloseCut[1]) + 5) % 10;
        String paltiBothCut = '$paltiBothTensDigit$paltiBothUnitsDigit';

        result.add({
          'digit': paltiBothCut,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;
        if (level >= 8) break;

        // For same digits, check if we've returned to the original digit
        if (isSameDigit && paltiBothCut == originalDigit) {
          break;
        }

        // Finally do close cut of the palti both cut
        int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
        String paltiFinalCloseCut =
            '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

        result.add({
          'digit': paltiFinalCloseCut,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;

        // For same digits, check if we've returned to the original digit
        if (isSameDigit && paltiFinalCloseCut == originalDigit) {
          break;
        }

        // Break the loop after palti to avoid extra iterations
        break;
      } else {
        // Set current digit to the close cut for the next iteration
        currentDigit = closeCut;
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _digitController.addListener(_filterNumbers);
    _digitFocusNode.addListener(_onFocusChange);
    _filteredNumbers = jodiNumbers;
    
    // You can now use widget.marketId for any initialization
    print("Market ID in GroupJodi: ${widget.marketId}");
  }

  @override
  void dispose() {
    _digitController.removeListener(_filterNumbers);
    _digitFocusNode.removeListener(_onFocusChange);
    _digitFocusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_digitFocusNode.hasFocus) {
      _showDropdownOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _filterNumbers() {
    final input = _digitController.text;
    setState(() {
      if (input.isEmpty) {
        _filteredNumbers = jodiNumbers;
      } else {
        try {
          _filteredNumbers = jodiNumbers.where((number) {
            return number.toString().contains(input);
          }).toList();
        } catch (e) {
          _filteredNumbers = [];
        }
      }
    });

    if (_digitFocusNode.hasFocus) {
      if (_overlayEntry == null) {
        _showDropdownOverlay();
      } else {
        _overlayEntry!.markNeedsBuild();
      }
    } else {
      _removeOverlay();
    }
  }

  void _showDropdownOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.5,
        child: CompositedTransformFollower(
          link: _layerLink,
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
                itemCount: _filteredNumbers.length,
                itemBuilder: (context, index) {
                  final number = _filteredNumbers[index];
                  return ListTile(
                    title: Text(number.toString()),
                    onTap: () {
                      setState(() {
                        _digitController.text = number.toString();
                        _digitController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _digitController.text.length),
                        );
                      });
                      _removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownVisible = true;
    });
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {
        _isDropdownVisible = false;
      });
    }
  }

  void _addBid() {
    if (_globalKey.currentState!.validate()) {
      setState(() {
        _digitError = _digitController.text.isEmpty;
        _pointsError = _pointsController.text.isEmpty;

        if (!_digitError && !_pointsError) {
          // Add the main bid
          bids.add({
            'digit': _digitController.text,
            'points': _pointsController.text,
            'type': 'OPEN',
          });

          // Generate and add the cut types
          List<Map<String, String>> cutTypes = _generateCutTypes(
            _digitController.text,
          );
          bids.addAll(cutTypes);

          _digitController.clear();
          _pointsController.clear();
          _removeOverlay();
        }
      });
    }
  }

  void _deleteBid(int index) {
    setState(() {
      bids.removeAt(index);
    });
  }

  void _submitAllBids(BuildContext context) {
    final provider = Provider.of<GroupJodiProvider>(context, listen: false);
    
    // Convert digits list to single string
    String digitsString = bids.map((bid) => bid['digit']!).join(',');
    
    // Get the first amount from the list (all amounts should be the same)
    String amount = bids.isNotEmpty ? bids[0]['points']! : '0';
    
    final groupJodiModel = SingleAnkModel(
      gameId: widget.marketId,
      gameType: "GROUP_JODI", 
      number: digitsString, // Send as comma-separated string
      amount: int.parse(amount), // Send as single amount
    );
    
    provider.placeSingleAnkBet(context, groupJodiModel);
    
    // Clear bids after submission
    setState(() {
      bids.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupJodiProvider(),
      child: Consumer<GroupJodiProvider>(
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
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.006,
                  ),
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
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04,
                      ),
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

                          // Bid Digits
                          Form(
                            key: _globalKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Bid Digits: ",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: CompositedTransformTarget(
                                        link: _layerLink,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (!_isDropdownVisible) {
                                              _digitFocusNode.requestFocus();
                                              _showDropdownOverlay();
                                            }
                                          },
                                          child: CustomTextfieldScreen1(
                                            controller: _digitController,
                                            focusNode: _digitFocusNode,
                                            hintText: "Number",
                                            onChanged: (value) {
                                              // Limit input to two digits only
                                              if (value.length > 2) {
                                                _digitController.text = value
                                                    .substring(0, 2);
                                                _digitController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(offset: 2),
                                                    );
                                              } else {
                                                _digitController.text = value;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !jodiNumbers.contains(value)) {
                                                return "Input don't have any family \njodi";
                                              }
                                              if (value.length != 2) {
                                                return "Exactly two digits required";
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

                                // Bid Points
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Bid Points: ",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 47),
                                    Expanded(
                                      child: CustomTextfieldScreen1(
                                        controller: _pointsController,
                                        hintText: "Point",
                                        onChanged: (value) {
                                          setState(() {
                                            _pointsController.text = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              int.parse(value) < 10 ||
                                              int.parse(value) > 10000) {
                                            return "Enter amount between \n10 - 10000";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                // Add Bid Button
                                AddButton(data: "ADD BID", onPressed: _addBid),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),

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
                                            "Digit",
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
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02,
                                  ),
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
                                                    bids[index]['digit']!,
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

                          // Submit Button with Consumer
                          Consumer<GroupJodiProvider>(
                            builder: (context, provider, child) {
                              return provider.isLoading
                                  ? CircularProgressIndicator()
                                  : SubmitButton(
                                      data: "Submit",
                                      onPressed: () {
                                        if (bids.isNotEmpty) {
                                          _submitAllBids(context);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Please add at least one bid"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                    );
                            },
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
