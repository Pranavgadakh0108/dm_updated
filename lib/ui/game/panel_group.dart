// // import 'package:dmboss/data/appdata.dart';
// // import 'package:dmboss/widgets/add_button.dart';
// // import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// // import 'package:dmboss/widgets/date_container.dart';
// // import 'package:dmboss/widgets/submit_button.dart';
// // import 'package:flutter/material.dart';

// // class PanelGroup extends StatefulWidget {
// //   final String title;
// //   final String gameName;
// //   const PanelGroup({super.key, required this.title, required this.gameName});

// //   @override
// //   State<PanelGroup> createState() => _PanelGroupState();
// // }

// // class _PanelGroupState extends State<PanelGroup> {
// //   final TextEditingController _digitController = TextEditingController();
// //   final TextEditingController _pointsController = TextEditingController();
// //   final GlobalKey<FormState> _globalKey = GlobalKey();

// //   bool _digitError = false;
// //   bool _pointsError = false;

// //   List<Map<String, String>> bids = [];

// //   // New variables for dropdown functionality
// //   final FocusNode _digitFocusNode = FocusNode();
// //   final LayerLink _layerLink = LayerLink();
// //   OverlayEntry? _overlayEntry;

// //   List<String> _filteredNumbers = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _digitController.addListener(_filterNumbers);
// //     _digitFocusNode.addListener(_onFocusChange);
// //     _filteredNumbers = panelGroup;
// //   }

// //   @override
// //   void dispose() {
// //     _digitController.removeListener(_filterNumbers);
// //     _digitFocusNode.removeListener(_onFocusChange);
// //     _digitFocusNode.dispose();
// //     _removeOverlay();
// //     super.dispose();
// //   }

// //   void _onFocusChange() {
// //     if (_digitFocusNode.hasFocus && _digitController.text.isNotEmpty) {
// //       _showDropdownOverlay();
// //     } else {
// //       _removeOverlay();
// //     }
// //   }

// //   void _filterNumbers() {
// //     final input = _digitController.text;
// //     setState(() {
// //       if (input.isEmpty) {
// //         _filteredNumbers = panelGroup;
// //       } else {
// //         try {
// //           _filteredNumbers = panelGroup.where((number) {
// //             return number.toString().contains(input);
// //           }).toList();
// //         } catch (e) {
// //           _filteredNumbers = [];
// //         }
// //       }
// //     });

// //     if (_digitFocusNode.hasFocus && _digitController.text.isNotEmpty) {
// //       if (_overlayEntry == null) {
// //         _showDropdownOverlay();
// //       } else {
// //         _overlayEntry!.markNeedsBuild();
// //       }
// //     } else {
// //       _removeOverlay();
// //     }
// //   }

// //   void _showDropdownOverlay() {
// //     _removeOverlay();

// //     _overlayEntry = OverlayEntry(
// //       builder: (context) => Positioned(
// //         width: MediaQuery.of(context).size.width * 0.5,
// //         child: CompositedTransformFollower(
// //           link: _layerLink,
// //           showWhenUnlinked: false,
// //           offset: const Offset(0, 40),
// //           child: Material(
// //             elevation: 4,
// //             child: Container(
// //               constraints: const BoxConstraints(maxHeight: 200),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 border: Border.all(color: Colors.grey),
// //               ),
// //               child: ListView.builder(
// //                 padding: EdgeInsets.zero,
// //                 shrinkWrap: true,
// //                 itemCount: _filteredNumbers.length,
// //                 itemBuilder: (context, index) {
// //                   final number = _filteredNumbers[index];
// //                   return ListTile(
// //                     title: Text(number.toString()),
// //                     onTap: () {
// //                       setState(() {
// //                         _digitController.text = number.toString();
// //                         _digitController.selection = TextSelection.fromPosition(
// //                           TextPosition(offset: _digitController.text.length),
// //                         );
// //                       });
// //                       _removeOverlay();
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );

// //     Overlay.of(context).insert(_overlayEntry!);
// //   }

// //   void _removeOverlay() {
// //     if (_overlayEntry != null) {
// //       _overlayEntry!.remove();
// //       _overlayEntry = null;
// //     }
// //   }

// //   void _addBid() {
// //     if (_globalKey.currentState!.validate()) {
// //       setState(() {
// //         _digitError = _digitController.text.isEmpty;
// //         _pointsError = _pointsController.text.isEmpty;

// //         if (!_digitError && !_pointsError) {
// //           bids.add({
// //             'digit': _digitController.text,
// //             'points': _pointsController.text,
// //             'type': 'OPEN',
// //           });
// //           _digitController.clear();
// //           _pointsController.clear();
// //           _removeOverlay();
// //         }
// //       });
// //     }
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
// //             padding: EdgeInsets.symmetric(
// //               horizontal: MediaQuery.of(context).size.width * 0.02,
// //               vertical: MediaQuery.of(context).size.height * 0.006,
// //             ),
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
// //                 padding: EdgeInsets.all(
// //                   MediaQuery.of(context).size.width * 0.04,
// //                 ),
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

// //                     // Bid Digits
// //                     Form(
// //                       key: _globalKey,
// //                       child: Column(
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               SizedBox(width: 10),
// //                               Text(
// //                                 "Bid Digits: ",
// //                                 style: TextStyle(fontWeight: FontWeight.w600),
// //                               ),
// //                               SizedBox(width: 50),
// //                               Expanded(
// //                                 child: CompositedTransformTarget(
// //                                   link: _layerLink,
// //                                   child: CustomTextfieldScreen1(
// //                                     controller: _digitController,
// //                                     focusNode: _digitFocusNode,
// //                                     hintText: "Number",
// //                                     onChanged: (value) {
// //                                       // Limit input to single digit only
// //                                       if (value.length > 3) {
// //                                         _digitController.text = value[0];
// //                                         _digitController.selection =
// //                                             TextSelection.fromPosition(
// //                                               TextPosition(offset: 1),
// //                                             );
// //                                       } else {
// //                                         _digitController.text = value;
// //                                       }
// //                                     },
// //                                     validator: (value) {
// //                                       if (value == null || value.isEmpty || !panelGroup.contains(value)) {
// //                                         return "Input don't have any family \njodi";
// //                                       }
// //                                       if (value.length > 3) {
// //                                         return "Only two digit allowed";
// //                                       }
// //                                       return null;
// //                                     },
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 10),

// //                           // Bid Points
// //                           Row(
// //                             children: [
// //                               SizedBox(width: 10),
// //                               Text(
// //                                 "Bid Points: ",
// //                                 style: TextStyle(fontWeight: FontWeight.w600),
// //                               ),
// //                               SizedBox(width: 47),
// //                               Expanded(
// //                                 child: CustomTextfieldScreen1(
// //                                   controller: _pointsController,
// //                                   hintText: "Point",
// //                                   onChanged: (value) {
// //                                     setState(() {
// //                                       _pointsController.text = value;
// //                                     });
// //                                   },
// //                                   validator: (value) {
// //                                     if (value == null ||
// //                                         value.isEmpty ||
// //                                         int.parse(value) < 10 ||
// //                                         int.parse(value) > 10000) {
// //                                       return "Enter amount between \n10 - 10000";
// //                                     }
// //                                     return null;
// //                                   },
// //                                 ),
// //                               ),
// //                             ],
// //                           ),

// //                           const SizedBox(height: 15),

// //                           // Add Bid Button
// //                           AddButton(data: "ADD BID", onPressed: _addBid),
// //                           const SizedBox(height: 15),
// //                         ],
// //                       ),
// //                     ),

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
// //                             padding: EdgeInsets.all(
// //                               MediaQuery.of(context).size.width * 0.02,
// //                             ),
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

// // import 'package:dmboss/data/appdata.dart';
// // import 'package:dmboss/widgets/add_button.dart';
// // import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// // import 'package:dmboss/widgets/date_container.dart';
// // import 'package:dmboss/widgets/submit_button.dart';
// // import 'package:flutter/material.dart';

// // class PanelGroup extends StatefulWidget {
// //   final String title;
// //   final String gameName;
// //   const PanelGroup({super.key, required this.title, required this.gameName});

// //   @override
// //   State<PanelGroup> createState() => _PanelGroupState();
// // }

// // class _PanelGroupState extends State<PanelGroup> {
// //   final TextEditingController _digitController = TextEditingController();
// //   final TextEditingController _pointsController = TextEditingController();
// //   final GlobalKey<FormState> _globalKey = GlobalKey();

// //   bool _digitError = false;
// //   bool _pointsError = false;

// //   List<Map<String, String>> bids = [];

// //   // New variables for dropdown functionality
// //   final FocusNode _digitFocusNode = FocusNode();
// //   final LayerLink _layerLink = LayerLink();
// //   OverlayEntry? _overlayEntry;

// //   List<String> _filteredNumbers = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _digitController.addListener(_filterNumbers);
// //     _digitFocusNode.addListener(_onFocusChange);
// //     _filteredNumbers = panelGroup;
// //   }

// //   @override
// //   void dispose() {
// //     _digitController.removeListener(_filterNumbers);
// //     _digitFocusNode.removeListener(_onFocusChange);
// //     _digitFocusNode.dispose();
// //     _removeOverlay();
// //     super.dispose();
// //   }

// //   void _onFocusChange() {
// //     if (_digitFocusNode.hasFocus) {
// //       _showDropdownOverlay();
// //     } else {
// //       _removeOverlay();
// //     }
// //   }

// //   void _filterNumbers() {
// //     final input = _digitController.text;
// //     setState(() {
// //       if (input.isEmpty) {
// //         _filteredNumbers = panelGroup;
// //       } else {
// //         try {
// //           _filteredNumbers = panelGroup.where((number) {
// //             return number.toString().contains(input);
// //           }).toList();
// //         } catch (e) {
// //           _filteredNumbers = [];
// //         }
// //       }
// //     });

// //     if (_digitFocusNode.hasFocus) {
// //       if (_overlayEntry == null) {
// //         _showDropdownOverlay();
// //       } else {
// //         _overlayEntry!.markNeedsBuild();
// //       }
// //     } else {
// //       _removeOverlay();
// //     }
// //   }

// //   void _showDropdownOverlay() {
// //     _removeOverlay();

// //     final renderBox = context.findRenderObject() as RenderBox;
// //     final size = renderBox.size;

// //     _overlayEntry = OverlayEntry(
// //       builder: (context) => Positioned(
// //         width: MediaQuery.of(context).size.width * 0.5,
// //         child: CompositedTransformFollower(
// //           link: _layerLink,
// //           showWhenUnlinked: false,
// //           offset: const Offset(0, 40),
// //           child: Material(
// //             elevation: 4,
// //             child: Container(
// //               constraints: const BoxConstraints(maxHeight: 200),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 border: Border.all(color: Colors.grey),
// //               ),
// //               child: _filteredNumbers.isEmpty
// //                   ? const Center(
// //                       child: Padding(
// //                         padding: EdgeInsets.all(16.0),
// //                         child: Text("No matching numbers"),
// //                       ),
// //                     )
// //                   : ListView.builder(
// //                       padding: EdgeInsets.zero,
// //                       shrinkWrap: true,
// //                       itemCount: _filteredNumbers.length,
// //                       itemBuilder: (context, index) {
// //                         final number = _filteredNumbers[index];
// //                         return ListTile(
// //                           title: Text(number.toString()),
// //                           onTap: () {
// //                             setState(() {
// //                               _digitController.text = number.toString();
// //                               _digitController.selection =
// //                                   TextSelection.fromPosition(
// //                                     TextPosition(
// //                                       offset: _digitController.text.length,
// //                                     ),
// //                                   );
// //                             });
// //                             _removeOverlay();
// //                             // Remove focus from the text field to hide keyboard
// //                             _digitFocusNode.unfocus();
// //                             // Move focus to next field
// //                             FocusScope.of(context).nextFocus();
// //                           },
// //                         );
// //                       },
// //                     ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );

// //     Overlay.of(context).insert(_overlayEntry!);
// //   }

// //   void _removeOverlay() {
// //     if (_overlayEntry != null) {
// //       _overlayEntry!.remove();
// //       _overlayEntry = null;
// //     }
// //   }

// //   // Function to generate levels based on the selected digit using panelLists
// //   List<Map<String, String>> _generateLevels(String digit, String points) {
// //     List<Map<String, String>> levels = [];

// //     if (digit.length != 3) {
// //       return levels;
// //     }

// //     // Check if the digit exists in panelLists
// //     if (panelLists.containsKey(digit)) {
// //       List<String> panelNumbers = panelLists[digit]!;

// //       // Add each panel number with the same points
// //       for (String panelDigit in panelNumbers) {
// //         levels.add({'digit': panelDigit, 'points': points, 'type': 'OPEN'});
// //       }
// //     }

// //     return levels;
// //   }

// //   void _addBid() {
// //     if (_globalKey.currentState!.validate()) {
// //       setState(() {
// //         _digitError = _digitController.text.isEmpty;
// //         _pointsError = _pointsController.text.isEmpty;

// //         if (!_digitError && !_pointsError) {
// //           // Generate all panel numbers for the selected digit
// //           List<Map<String, String>> levels = _generateLevels(
// //             _digitController.text,
// //             _pointsController.text,
// //           );

// //           // Add all levels to bids
// //           bids.addAll(levels);

// //           _digitController.clear();
// //           _pointsController.clear();
// //           _removeOverlay();
// //         }
// //       });
// //     }
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
// //             padding: EdgeInsets.symmetric(
// //               horizontal: MediaQuery.of(context).size.width * 0.02,
// //               vertical: MediaQuery.of(context).size.height * 0.006,
// //             ),
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
// //                 padding: EdgeInsets.all(
// //                   MediaQuery.of(context).size.width * 0.04,
// //                 ),
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

// //                     // Bid Digits
// //                     Form(
// //                       key: _globalKey,
// //                       child: Column(
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               SizedBox(width: 10),
// //                               Text(
// //                                 "Bid Digits: ",
// //                                 style: TextStyle(fontWeight: FontWeight.w600),
// //                               ),
// //                               SizedBox(width: 50),
// //                               Expanded(
// //                                 child: CompositedTransformTarget(
// //                                   link: _layerLink,
// //                                   child: GestureDetector(
// //                                     onTap: () {
// //                                       // Request focus and show dropdown when text field is tapped
// //                                       FocusScope.of(
// //                                         context,
// //                                       ).requestFocus(_digitFocusNode);
// //                                       _showDropdownOverlay();
// //                                     },
// //                                     child: CustomTextfieldScreen1(
// //                                       controller: _digitController,
// //                                       focusNode: _digitFocusNode,
// //                                       hintText: "Number",
// //                                       onChanged: (value) {
// //                                         // Limit input to 3 digits only
// //                                         if (value.length > 3) {
// //                                           _digitController.text = value
// //                                               .substring(0, 3);
// //                                           _digitController.selection =
// //                                               TextSelection.fromPosition(
// //                                                 TextPosition(offset: 3),
// //                                               );
// //                                         } else {
// //                                           _digitController.text = value;
// //                                         }
// //                                       },
// //                                       validator: (value) {
// //                                         if (value == null ||
// //                                             value.isEmpty ||
// //                                             value.length != 3) {
// //                                           return "Please enter a 3-digit number";
// //                                         }
// //                                         return null;
// //                                       },
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 10),

// //                           // Bid Points
// //                           Row(
// //                             children: [
// //                               SizedBox(width: 10),
// //                               Text(
// //                                 "Bid Points: ",
// //                                 style: TextStyle(fontWeight: FontWeight.w600),
// //                               ),
// //                               SizedBox(width: 47),
// //                               Expanded(
// //                                 child: CustomTextfieldScreen1(
// //                                   controller: _pointsController,
// //                                   hintText: "Point",
// //                                   onChanged: (value) {
// //                                     setState(() {
// //                                       _pointsController.text = value;
// //                                     });
// //                                   },
// //                                   validator: (value) {
// //                                     if (value == null ||
// //                                         value.isEmpty ||
// //                                         int.parse(value) < 10 ||
// //                                         int.parse(value) > 10000) {
// //                                       return "Enter amount between \n10 - 10000";
// //                                     }
// //                                     return null;
// //                                   },
// //                                 ),
// //                               ),
// //                             ],
// //                           ),

// //                           const SizedBox(height: 15),

// //                           // Add Bid Button
// //                           AddButton(data: "ADD BID", onPressed: _addBid),
// //                           const SizedBox(height: 15),
// //                         ],
// //                       ),
// //                     ),

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
// //                             padding: EdgeInsets.all(
// //                               MediaQuery.of(context).size.width * 0.02,
// //                             ),
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
// import 'package:dmboss/model/games_model/single_ank_model.dart';
// import 'package:dmboss/provider/games_provider/panel_group_provider.dart';
// import 'package:dmboss/widgets/add_button.dart';
// import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
// import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// import 'package:dmboss/widgets/game_app_bar.dart';
// import 'package:dmboss/widgets/game_status.dart';
// import 'package:dmboss/widgets/submit_button.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class PanelGroup extends StatefulWidget {
//   final String title;
//   final String gameName;
//   final String marketId; // Added marketId parameter
//   final String openTime;
//   const PanelGroup({
//     super.key,
//     required this.title,
//     required this.gameName,
//     required this.marketId, // Added to constructor
//     required this.openTime,
//   });

//   @override
//   State<PanelGroup> createState() => _PanelGroupState();
// }

// class _PanelGroupState extends State<PanelGroup> {
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
//     _filteredNumbers = panelGroup;

//     // You can now use widget.marketId for any initialization
//     print("Market ID in PanelGroup: ${widget.marketId}");
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
//         _filteredNumbers = panelGroup;
//       } else {
//         try {
//           _filteredNumbers = panelGroup.where((number) {
//             //return number.toString().contains(input);
//             return number.toString().startsWith(input);
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

//     final renderBox = context.findRenderObject() as RenderBox;
//     final size = renderBox.size;

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
//               child: _filteredNumbers.isEmpty
//                   ? const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text("No matching numbers"),
//                       ),
//                     )
//                   : ListView.builder(
//                       padding: EdgeInsets.zero,
//                       shrinkWrap: true,
//                       itemCount: _filteredNumbers.length,
//                       itemBuilder: (context, index) {
//                         final number = _filteredNumbers[index];
//                         return SizedBox(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 7,
//                               horizontal: 15,
//                             ),
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _digitController.text = number.toString();
//                                   _digitController.selection =
//                                       TextSelection.fromPosition(
//                                         TextPosition(
//                                           offset: _digitController.text.length,
//                                         ),
//                                       );
//                                 });
//                                 _removeOverlay();
//                                 // Remove focus from the text field to hide keyboard
//                                 _digitFocusNode.unfocus();
//                                 // Move focus to next field
//                                 FocusScope.of(context).nextFocus();
//                               },
//                               child: Text(
//                                 number.toString(),
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
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

//   // Function to generate levels based on the selected digit using panelLists
//   List<Map<String, String>> _generateLevels(String digit, String points) {
//     List<Map<String, String>> levels = [];

//     if (digit.length != 3) {
//       return levels;
//     }

//     // Check if the digit exists in panelLists
//     if (panelLists.containsKey(digit)) {
//       List<String> panelNumbers = panelLists[digit]!;

//       // Use the function to determine game status
//       final gameStatus = getGameStatus(widget.openTime);

//       // Add each panel number with the same points
//       for (String panelDigit in panelNumbers) {
//         levels.add({'digit': panelDigit, 'points': points, 'type': gameStatus});
//       }
//     }

//     return levels;
//   }

//   void _addBid() {
//     FocusScope.of(context).unfocus();
//     if (_globalKey.currentState!.validate()) {
//       setState(() {
//         _digitError = _digitController.text.isEmpty;
//         _pointsError = _pointsController.text.isEmpty;

//         if (!_digitError && !_pointsError) {
//           // Generate all panel numbers for the selected digit
//           List<Map<String, String>> levels = _generateLevels(
//             _digitController.text,
//             _pointsController.text,
//           );

//           // Add all levels to bids
//           bids.addAll(levels);

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

//   // void _submitAllBids(BuildContext context, JodiProvider provider) {
//   //   FocusScope.of(context).unfocus();

//   //   for (var bid in bids) {
//   //     final singleAnkModel = SingleAnkModel(
//   //       gameId: widget.marketId,
//   //       gameType: "JODI",
//   //       number: bid['digit']!,
//   //       amount: int.parse(bid['points']!),
//   //     );

//   //     provider.placeSingleAnkBet(context, singleAnkModel);
//   //   }

//   //   setState(() {
//   //     bids.clear();
//   //   });
//   // }

//   void _submitAllBids(BuildContext context, PanelGroupProvider provider) {
//     //final provider = Provider.of<PanelGroupProvider>(context, listen: false);
//     FocusScope.of(context).unfocus();

//     // Convert digits list to single string
//     String digitsString = bids.map((bid) => bid['digit']!).join(',');

//     // Get the first amount from the list (all amounts should be the same)
//     String amount = bids.isNotEmpty ? bids[0]['points']! : '0';

//     final panelGroupModel = SingleAnkModel(
//       gameId: widget.marketId,
//       gameType: "PANEL_GROUP",
//       number: digitsString, // Send as comma-separated string
//       amount: int.parse(amount), // Send as single amount
//     );

//     provider.placeSingleAnkBet(context, panelGroupModel);

//     // Clear bids after submission
//     setState(() {
//       bids.clear();
//     });

//     Navigator.pop(context);
//   }

//   void _showConfirmationDialog(
//     BuildContext context,
//     PanelGroupProvider provider,
//   ) {
//     final totalBids = bids.length;
//     final totalBidAmount = bids.fold<int>(
//       0,
//       (sum, bid) => sum + int.parse(bid['points']!),
//     );

//     showDialog(
//       context: context,
//       builder: (context) => BetSummaryDialog(
//         title: widget.title,
//         date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
//         bids: bids,
//         totalBids: totalBids,
//         totalBidAmount: totalBidAmount,
//         onConfirm: () {
//           Navigator.pop(context);
//           _submitAllBids(context, provider);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final gameStatus = getGameStatus(widget.openTime);
//     return ChangeNotifierProvider(
//       create: (context) => PanelGroupProvider(),
//       child: Consumer<PanelGroupProvider>(
//         builder: (context, provider, child) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.orange,
//               title: Text(
//                 widget.title,
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//               ),
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               actions: [
//                 Container(
//                   margin: const EdgeInsets.all(10),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width * 0.02,
//                     vertical: MediaQuery.of(context).size.height * 0.006,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Wallet(),
//                 ),
//               ],
//             ),
//             body: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(
//                         MediaQuery.of(context).size.width * 0.04,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Date and Game Name
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.orange,
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       widget.gameName,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.orange,
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       gameStatus,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 15),

//                           // Bid Digits
//                           Form(
//                             key: _globalKey,
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Enter Bid Digits: ",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(width: 55),
//                                     Expanded(
//                                       child: CompositedTransformTarget(
//                                         link: _layerLink,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             // Request focus and show dropdown when text field is tapped
//                                             FocusScope.of(
//                                               context,
//                                             ).requestFocus(_digitFocusNode);
//                                             _showDropdownOverlay();
//                                           },
//                                           child: CustomTextfieldScreen1(
//                                             controller: _digitController,
//                                             focusNode: _digitFocusNode,
//                                             hintText: "Number",
//                                             onChanged: (value) {
//                                               // Limit input to 3 digits only
//                                               if (value.length > 3) {
//                                                 _digitController.text = value
//                                                     .substring(0, 3);
//                                                 _digitController.selection =
//                                                     TextSelection.fromPosition(
//                                                       TextPosition(offset: 3),
//                                                     );
//                                               } else {
//                                                 _digitController.text = value;
//                                               }
//                                             },
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty ||
//                                                   value.length != 3) {
//                                                 return "Please enter a 3-digit number";
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 10),

//                                 // Bid Points
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Enter Bid Points: ",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(width: 50),
//                                     Expanded(
//                                       child: CustomTextfieldScreen1(
//                                         controller: _pointsController,
//                                         hintText: "Point",
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _pointsController.text = value;
//                                           });
//                                         },
//                                         validator: (value) {
//                                           if (value == null ||
//                                               value.isEmpty ||
//                                               int.parse(value) < 10 ||
//                                               int.parse(value) > 10000) {
//                                             return "Enter amount between \n10 - 10000";
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 const SizedBox(height: 15),

//                                 // Add Bid Button
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     AddButton(
//                                       data: "ADD BID",
//                                       onPressed: _addBid,
//                                     ),
//                                     SizedBox(width: 9),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 15),
//                               ],
//                             ),
//                           ),

//                           // Bid List Table
//                           Container(
//                             constraints: BoxConstraints(
//                               maxHeight:
//                                   MediaQuery.of(context).size.height *
//                                   0.4, // Reduced height
//                             ),

//                             child: Column(
//                               children: [
//                                 // Table header
//                                 Container(
//                                   // padding: const EdgeInsets.symmetric(
//                                   //   vertical: 8,
//                                   //   horizontal: 10,
//                                   // ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: const [
//                                         Expanded(
//                                           child: Text(
//                                             "Digit",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             "Amount",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             "Type",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             "Delete",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(
//                                     MediaQuery.of(context).size.width * 0.02,
//                                   ),
//                                   child: const Divider(
//                                     height: 1,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 // Bid list
//                                 Expanded(
//                                   child: ListView.builder(
//                                     itemCount: bids.length,
//                                     itemBuilder: (context, index) {
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 4,
//                                           horizontal: 8,
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors
//                                                 .grey[100], // Lighter background
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                           child: ListTile(
//                                             contentPadding:
//                                                 const EdgeInsets.symmetric(
//                                                   horizontal: 8,
//                                                 ),
//                                             minVerticalPadding: 0,
//                                             dense:
//                                                 true, // Makes the list tile more compact
//                                             title: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Expanded(
//                                                   child: Text(
//                                                     bids[index]['digit']!,
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     bids[index]['points']!,
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     bids[index]['type']!,
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: GestureDetector(
//                                                     onTap: () =>
//                                                         _deleteBid(index),
//                                                     child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 20,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           // Submit Button with Consumer
//                           Consumer<PanelGroupProvider>(
//                             builder: (context, provider, child) {
//                               return provider.isLoading
//                                   ? CircularProgressIndicator()
//                                   : SubmitButton(
//                                       data: "Submit",
//                                       onPressed: () {
//                                         if (bids.isNotEmpty) {
//                                           _showConfirmationDialog(
//                                             context,
//                                             provider,
//                                           );
//                                         } else {
//                                           ScaffoldMessenger.of(
//                                             context,
//                                           ).showSnackBar(
//                                             SnackBar(
//                                               content: Text(
//                                                 "Please add at least one bid",
//                                               ),
//                                               backgroundColor: Colors.red,
//                                             ),
//                                           );
//                                         }
//                                       },
//                                     );
//                             },
//                           ),
//                           SizedBox(height: 40),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/single_ank_model.dart';
import 'package:dmboss/provider/games_provider/panel_group_provider.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/game_status.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PanelGroup extends StatefulWidget {
  final String title;
  final String gameName;
  final String marketId;
  final String openTime;
  const PanelGroup({
    super.key,
    required this.title,
    required this.gameName,
    required this.marketId,
    required this.openTime,
  });

  @override
  State<PanelGroup> createState() => _PanelGroupState();
}

class _PanelGroupState extends State<PanelGroup> {
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

  @override
  void initState() {
    super.initState();
    _digitController.addListener(_filterNumbers);
    _digitFocusNode.addListener(_onFocusChange);
    _filteredNumbers = panelGroup;

    // You can now use widget.marketId for any initialization
    print("Market ID in PanelGroup: ${widget.marketId}");
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
        _filteredNumbers = panelGroup;
      } else {
        try {
          _filteredNumbers = panelGroup.where((number) {
            return number.toString().startsWith(input);
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
          offset: Offset(0, MediaQuery.of(context).size.height * 0.05),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.25,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: _filteredNumbers.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No matching numbers"),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredNumbers.length,
                      itemBuilder: (context, index) {
                        final number = _filteredNumbers[index];
                        return SizedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _digitController.text = number.toString();
                                  _digitController.selection =
                                      TextSelection.fromPosition(
                                        TextPosition(
                                          offset: _digitController.text.length,
                                        ),
                                      );
                                });
                                _removeOverlay();
                                // Remove focus from the text field to hide keyboard
                                _digitFocusNode.unfocus();
                                // Move focus to next field
                                FocusScope.of(context).nextFocus();
                              },
                              child: Text(
                                number.toString(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  // Function to generate levels based on the selected digit using panelLists
  List<Map<String, String>> _generateLevels(String digit, String points) {
    List<Map<String, String>> levels = [];

    if (digit.length != 3) {
      return levels;
    }

    // Check if the digit exists in panelLists
    if (panelLists.containsKey(digit)) {
      List<String> panelNumbers = panelLists[digit]!;

      // Use the function to determine game status
      final gameStatus = getGameStatus(widget.openTime);

      // Add each panel number with the same points
      for (String panelDigit in panelNumbers) {
        levels.add({'digit': panelDigit, 'points': points, 'type': gameStatus});
      }
    }

    return levels;
  }

  void _addBid() {
    FocusScope.of(context).unfocus();
    if (_globalKey.currentState!.validate()) {
      setState(() {
        _digitError = _digitController.text.isEmpty;
        _pointsError = _pointsController.text.isEmpty;

        if (!_digitError && !_pointsError) {
          // Generate all panel numbers for the selected digit
          List<Map<String, String>> levels = _generateLevels(
            _digitController.text,
            _pointsController.text,
          );

          // Add all levels to bids
          bids.addAll(levels);

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

  void _submitAllBids(BuildContext context, PanelGroupProvider provider) {
    FocusScope.of(context).unfocus();

    // Convert digits list to single string
    String digitsString = bids.map((bid) => bid['digit']!).join(',');

    // Get the first amount from the list (all amounts should be the same)
    String amount = bids.isNotEmpty ? bids[0]['points']! : '0';

    final panelGroupModel = SingleAnkModel(
      gameId: widget.marketId,
      gameType: "PANEL_GROUP",
      number: digitsString, // Send as comma-separated string
      amount: int.parse(amount), // Send as single amount
    );

    provider.placeSingleAnkBet(context, panelGroupModel);

    // Clear bids after submission
    setState(() {
      bids.clear();
    });

    Navigator.pop(context);
  }

  void _showConfirmationDialog(
    BuildContext context,
    PanelGroupProvider provider,
  ) {
    final totalBids = bids.length;
    final totalBidAmount = bids.fold<int>(
      0,
      (sum, bid) => sum + int.parse(bid['points']!),
    );

    showDialog(
      context: context,
      builder: (context) => BetSummaryDialog(
        title: widget.title,
        date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        bids: bids,
        totalBids: totalBids,
        totalBidAmount: totalBidAmount,
        onConfirm: () {
          Navigator.pop(context);
          _submitAllBids(context, provider);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gameStatus = getGameStatus(widget.openTime);

    return ChangeNotifierProvider(
      create: (context) => PanelGroupProvider(),
      child: Consumer<PanelGroupProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.045,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.05),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Container(
                  margin: EdgeInsets.all(screenWidth * 0.02),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.006,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Wallet(),
                ),
              ],
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Date and Game Name
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.02,
                                    ),
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
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.02,
                                    ),
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

                          // Bid Digits
                          Form(
                            key: _globalKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      "Enter Bid Digits: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: screenWidth * 0.035,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.12),
                                    Expanded(
                                      child: CompositedTransformTarget(
                                        link: _layerLink,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Request focus and show dropdown when text field is tapped
                                            FocusScope.of(
                                              context,
                                            ).requestFocus(_digitFocusNode);
                                            _showDropdownOverlay();
                                          },
                                          child: CustomTextfieldScreen1(
                                            controller: _digitController,
                                            focusNode: _digitFocusNode,
                                            hintText: "Number",
                                            onChanged: (value) {
                                              // Limit input to 3 digits only
                                              if (value.length > 3) {
                                                _digitController.text = value
                                                    .substring(0, 3);
                                                _digitController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(offset: 3),
                                                    );
                                              } else {
                                                _digitController.text = value;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value.length != 3) {
                                                return "Please enter a 3-digit number";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.015),

                                // Bid Points
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      "Enter Bid Points: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: screenWidth * 0.035,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.12),
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

                                SizedBox(height: screenHeight * 0.02),

                                // Add Bid Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AddButton(
                                      data: "ADD BID",
                                      onPressed: _addBid,
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                              ],
                            ),
                          ),

                          // Bid List Table
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: screenHeight * 0.38,
                            ),
                            child: Column(
                              children: [
                                // Table header
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Digit",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Amount",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Type",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Delete",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.01),
                                  child: const Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                // Bid list
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: bids.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.005,
                                          horizontal: screenWidth * 0.02,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.02,
                                            ),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenWidth * 0.02,
                                                ),
                                            minVerticalPadding: 0,
                                            dense: true,
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    bids[index]['digit']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.03,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    bids[index]['points']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.03,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    bids[index]['type']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.03,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () =>
                                                        _deleteBid(index),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: screenWidth * 0.05,
                                                    ),
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

                          SizedBox(height: screenHeight * 0.02),

                          // Submit Button with Consumer
                          Consumer<PanelGroupProvider>(
                            builder: (context, provider, child) {
                              return provider.isLoading
                                  ? CircularProgressIndicator()
                                  : SubmitButton(
                                      data: "Submit",
                                      onPressed: () {
                                        if (bids.isNotEmpty) {
                                          _showConfirmationDialog(
                                            context,
                                            provider,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Please add at least one bid",
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                    );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.05),
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
