// // import 'package:dmboss/data/appdata.dart';
// // import 'package:dmboss/model/games_model/single_ank_model.dart';
// // import 'package:dmboss/provider/games_provider/group_jodi_provider.dart';
// // import 'package:dmboss/widgets/add_button.dart';
// // import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
// // import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// // import 'package:dmboss/widgets/game_app_bar.dart';
// // import 'package:dmboss/widgets/submit_button.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';

// // class GroupJodi extends StatefulWidget {
// //   final String title;
// //   final String gameName;
// //   final String marketId; // Added marketId parameter
// //   const GroupJodi({
// //     super.key,
// //     required this.title,
// //     required this.gameName,
// //     required this.marketId, // Added to constructor
// //   });

// //   @override
// //   State<GroupJodi> createState() => _GroupJodiState();
// // }

// // class _GroupJodiState extends State<GroupJodi> {
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
// //   bool _isDropdownVisible = false;

// //   // Function to generate cut types based on the selected digit
// //   List<Map<String, String>> _generateCutTypes(String originalDigit) {
// //     List<Map<String, String>> result = [];
// //     String currentDigit = originalDigit;
// //     int level = 0;

// //     // Check if the original digit has same numbers
// //     bool isSameDigit = originalDigit[0] == originalDigit[1];

// //     while (level < 8) {
// //       // Calculate both cut for the current digit
// //       int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
// //       int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
// //       String bothCut = '$tensDigit$unitsDigit';

// //       // Add both cut
// //       result.add({
// //         'digit': bothCut,
// //         'points': _pointsController.text,
// //         'type': 'OPEN',
// //       });
// //       level++;
// //       if (level >= 8) break;

// //       // For same digits, check if we've returned to the original digit
// //       if (isSameDigit && bothCut == originalDigit) {
// //         break;
// //       }

// //       // Calculate close cut (only add to units place of the both cut)
// //       int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
// //       String closeCut = '${bothCut[0]}$closeUnitsDigit';

// //       // Add close cut
// //       result.add({
// //         'digit': closeCut,
// //         'points': _pointsController.text,
// //         'type': 'OPEN',
// //       });
// //       level++;
// //       if (level >= 8) break;

// //       // For same digits, check if we've returned to the original digit
// //       if (isSameDigit && closeCut == originalDigit) {
// //         break;
// //       }

// //       // Check if close cut matches original digit
// //       if (closeCut == originalDigit && level < 8) {
// //         // Do palti (reverse the original digits)
// //         String reversed = '${originalDigit[1]}${originalDigit[0]}';
// //         result.add({
// //           'digit': reversed,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;

// //         // 🔹 Special condition for 50 → stop after palti
// //         if (originalDigit == "50") {
// //           break;
// //         }

// //         if (level >= 8) break;

// //         // For same digits, check if we've returned to the original digit
// //         if (isSameDigit && reversed == originalDigit) {
// //           break;
// //         }

// //         // After palti, we should do CLOSE CUT, not BOTH CUT
// //         int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
// //         String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

// //         result.add({
// //           'digit': paltiCloseCut,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;
// //         if (level >= 8) break;

// //         // For same digits, check if we've returned to the original digit
// //         if (isSameDigit && paltiCloseCut == originalDigit) {
// //           break;
// //         }

// //         // Then do both cut of the palti close cut
// //         int paltiBothTensDigit = (int.parse(paltiCloseCut[0]) + 5) % 10;
// //         int paltiBothUnitsDigit = (int.parse(paltiCloseCut[1]) + 5) % 10;
// //         String paltiBothCut = '$paltiBothTensDigit$paltiBothUnitsDigit';

// //         result.add({
// //           'digit': paltiBothCut,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;
// //         if (level >= 8) break;

// //         // For same digits, check if we've returned to the original digit
// //         if (isSameDigit && paltiBothCut == originalDigit) {
// //           break;
// //         }

// //         // Finally do close cut of the palti both cut
// //         int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
// //         String paltiFinalCloseCut =
// //             '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

// //         result.add({
// //           'digit': paltiFinalCloseCut,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;

// //         // For same digits, check if we've returned to the original digit
// //         if (isSameDigit && paltiFinalCloseCut == originalDigit) {
// //           break;
// //         }

// //         // Break the loop after palti to avoid extra iterations
// //         break;
// //       } else {
// //         // Set current digit to the close cut for the next iteration
// //         currentDigit = closeCut;
// //       }
// //     }

// //     return result;
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _digitController.addListener(_filterNumbers);
// //     _digitFocusNode.addListener(_onFocusChange);
// //     _filteredNumbers = jodiNumbers;

// //     // You can now use widget.marketId for any initialization
// //     print("Market ID in GroupJodi: ${widget.marketId}");
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
// //         _filteredNumbers = jodiNumbers;
// //       } else {
// //         try {
// //           _filteredNumbers = jodiNumbers.where((number) {
// //             // return number.toString().contains(input);
// //             return number.toString().startsWith(input);
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
// //                   return SizedBox(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                         vertical: 7,
// //                         horizontal: 15,
// //                       ),
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           setState(() {
// //                             _digitController.text = number.toString();
// //                             _digitController.selection =
// //                                 TextSelection.fromPosition(
// //                                   TextPosition(
// //                                     offset: _digitController.text.length,
// //                                   ),
// //                                 );
// //                           });
// //                           _removeOverlay();
// //                         },
// //                         child: Text(
// //                           number.toString(),
// //                           style: TextStyle(fontSize: 16),
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                   // ListTile(
// //                   //   title: Text(number.toString()),
// //                   //   onTap: () {
// //                   //     setState(() {
// //                   //       _digitController.text = number.toString();
// //                   //       _digitController.selection = TextSelection.fromPosition(
// //                   //         TextPosition(offset: _digitController.text.length),
// //                   //       );
// //                   //     });
// //                   //     _removeOverlay();
// //                   //   },
// //                   // );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );

// //     Overlay.of(context).insert(_overlayEntry!);
// //     setState(() {
// //       _isDropdownVisible = true;
// //     });
// //   }

// //   void _removeOverlay() {
// //     if (_overlayEntry != null) {
// //       _overlayEntry!.remove();
// //       _overlayEntry = null;
// //       setState(() {
// //         _isDropdownVisible = false;
// //       });
// //     }
// //   }

// //   void _addBid() {
// //     FocusScope.of(context).unfocus();
// //     if (_globalKey.currentState!.validate()) {
// //       setState(() {
// //         _digitError = _digitController.text.isEmpty;
// //         _pointsError = _pointsController.text.isEmpty;

// //         if (!_digitError && !_pointsError) {
// //           // Add the main bid
// //           bids.add({
// //             'digit': _digitController.text,
// //             'points': _pointsController.text,
// //             'type': 'OPEN',
// //           });

// //           // Generate and add the cut types
// //           List<Map<String, String>> cutTypes = _generateCutTypes(
// //             _digitController.text,
// //           );
// //           bids.addAll(cutTypes);

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

// //   void _submitAllBids(BuildContext context, GroupJodiProvider provider) {
// //     FocusScope.of(context).unfocus();

// //     //final provider = Provider.of<GroupJodiProvider>(context, listen: false);

// //     // Convert digits list to single string
// //     String digitsString = bids.map((bid) => bid['digit']!).join(',');

// //     // Get the first amount from the list (all amounts should be the same)
// //     String amount = bids.isNotEmpty ? bids[0]['points']! : '0';

// //     final groupJodiModel = SingleAnkModel(
// //       gameId: widget.marketId,
// //       gameType: "GROUP_JODI",
// //       number: digitsString, // Send as comma-separated string
// //       amount: int.parse(amount), // Send as single amount
// //     );

// //     provider.placeSingleAnkBet(context, groupJodiModel);

// //     // Clear bids after submission
// //     setState(() {
// //       bids.clear();
// //     });
// //   }

// //   void _showConfirmationDialog(
// //     BuildContext context,
// //     GroupJodiProvider provider,
// //   ) {
// //     final totalBids = bids.length;
// //     final totalBidAmount = bids.fold<int>(
// //       0,
// //       (sum, bid) => sum + int.parse(bid['points']!),
// //     );

// //     showDialog(
// //       context: context,
// //       builder: (context) => BetSummaryDialog(
// //         title: widget.title,
// //         date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
// //         bids: bids,
// //         totalBids: totalBids,
// //         totalBidAmount: totalBidAmount,
// //         onConfirm: () {
// //           Navigator.pop(context);
// //           _submitAllBids(context, provider);
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (context) => GroupJodiProvider(),
// //       child: Consumer<GroupJodiProvider>(
// //         builder: (context, provider, child) {
// //           return Scaffold(
// //             backgroundColor: Colors.white,
// //             appBar: AppBar(
// //               backgroundColor: Colors.orange,
// //               title: Text(
// //                 widget.title,
// //                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
// //               ),
// //               leading: IconButton(
// //                 icon: const Icon(Icons.arrow_back_ios),
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                 },
// //               ),
// //               actions: [
// //                 Container(
// //                   margin: const EdgeInsets.all(10),
// //                   padding: EdgeInsets.symmetric(
// //                     horizontal: MediaQuery.of(context).size.width * 0.02,
// //                     vertical: MediaQuery.of(context).size.height * 0.006,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   child: Wallet(),
// //                 ),
// //               ],
// //             ),
// //             body: LayoutBuilder(
// //               builder: (context, constraints) {
// //                 return SingleChildScrollView(
// //                   child: ConstrainedBox(
// //                     constraints: BoxConstraints(
// //                       minHeight: constraints.maxHeight,
// //                     ),
// //                     child: Padding(
// //                       padding: EdgeInsets.all(
// //                         MediaQuery.of(context).size.width * 0.04,
// //                       ),
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           // Date and Game Name
// //                           Row(
// //                             children: [
// //                               Expanded(
// //                                 child: Container(
// //                                   padding: const EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     border: Border.all(
// //                                       color: Colors.orange,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(10),
// //                                   ),
// //                                   child: Center(
// //                                     child: Text(
// //                                       widget.gameName,
// //                                       style: const TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 14,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 10),
// //                               Expanded(
// //                                 child: Container(
// //                                   padding: const EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     border: Border.all(
// //                                       color: Colors.orange,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(10),
// //                                   ),
// //                                   child: Center(
// //                                     child: Text(
// //                                       "OPEN",
// //                                       style: const TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 14,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 15),

// //                           // Bid Digits
// //                           Form(
// //                             key: _globalKey,
// //                             child: Column(
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     SizedBox(width: 10),
// //                                     Text(
// //                                       "Enter Bid Digits: ",
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 50),
// //                                     Expanded(
// //                                       child: CompositedTransformTarget(
// //                                         link: _layerLink,
// //                                         child: GestureDetector(
// //                                           onTap: () {
// //                                             if (!_isDropdownVisible) {
// //                                               _digitFocusNode.requestFocus();
// //                                               _showDropdownOverlay();
// //                                             }
// //                                           },
// //                                           child: CustomTextfieldScreen1(
// //                                             controller: _digitController,
// //                                             focusNode: _digitFocusNode,
// //                                             hintText: "Number",
// //                                             onChanged: (value) {
// //                                               // Limit input to two digits only
// //                                               if (value.length > 2) {
// //                                                 _digitController.text = value
// //                                                     .substring(0, 2);
// //                                                 _digitController.selection =
// //                                                     TextSelection.fromPosition(
// //                                                       TextPosition(offset: 2),
// //                                                     );
// //                                               } else {
// //                                                 _digitController.text = value;
// //                                               }
// //                                             },
// //                                             validator: (value) {
// //                                               if (value == null ||
// //                                                   value.isEmpty ||
// //                                                   !jodiNumbers.contains(
// //                                                     value,
// //                                                   )) {
// //                                                 return "Input don't have any family \njodi";
// //                                               }
// //                                               if (value.length != 2) {
// //                                                 return "Exactly two digits required";
// //                                               }
// //                                               return null;
// //                                             },
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(height: 10),

// //                                 // Bid Points
// //                                 Row(
// //                                   children: [
// //                                     SizedBox(width: 10),
// //                                     Text(
// //                                       "Enter Bid Points: ",
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 47),
// //                                     Expanded(
// //                                       child: CustomTextfieldScreen1(
// //                                         controller: _pointsController,
// //                                         hintText: "Point",
// //                                         onChanged: (value) {
// //                                           setState(() {
// //                                             _pointsController.text = value;
// //                                           });
// //                                         },
// //                                         validator: (value) {
// //                                           if (value == null ||
// //                                               value.isEmpty ||
// //                                               int.parse(value) < 10 ||
// //                                               int.parse(value) > 10000) {
// //                                             return "Enter amount between \n10 - 10000";
// //                                           }
// //                                           return null;
// //                                         },
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 const SizedBox(height: 15),

// //                                 // Add Bid Button
// //                                 AddButton(data: "ADD BID", onPressed: _addBid),
// //                                 const SizedBox(height: 15),
// //                               ],
// //                             ),
// //                           ),

// //                           // Bid List Table
// //                           Container(
// //                             constraints: BoxConstraints(
// //                               maxHeight:
// //                                   MediaQuery.of(context).size.height *
// //                                   0.4, // Reduced height
// //                             ),

// //                             child: Column(
// //                               children: [
// //                                 // Table header
// //                                 Container(
// //                                   // padding: const EdgeInsets.symmetric(
// //                                   //   vertical: 8,
// //                                   //   horizontal: 10,
// //                                   // ),
// //                                   child: Padding(
// //                                     padding: const EdgeInsets.only(top: 8),
// //                                     child: Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Digit",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Amount",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Type",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Delete",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Padding(
// //                                   padding: EdgeInsets.all(
// //                                     MediaQuery.of(context).size.width * 0.02,
// //                                   ),
// //                                   child: const Divider(
// //                                     height: 1,
// //                                     color: Colors.black,
// //                                   ),
// //                                 ),
// //                                 // Bid list
// //                                 Expanded(
// //                                   child: ListView.builder(
// //                                     itemCount: bids.length,
// //                                     itemBuilder: (context, index) {
// //                                       return Padding(
// //                                         padding: const EdgeInsets.symmetric(
// //                                           vertical: 4,
// //                                           horizontal: 8,
// //                                         ),
// //                                         child: Container(
// //                                           decoration: BoxDecoration(
// //                                             color: Colors
// //                                                 .grey[100], // Lighter background
// //                                             borderRadius: BorderRadius.circular(
// //                                               8,
// //                                             ),
// //                                           ),
// //                                           child: ListTile(
// //                                             contentPadding:
// //                                                 const EdgeInsets.symmetric(
// //                                                   horizontal: 8,
// //                                                 ),
// //                                             minVerticalPadding: 0,
// //                                             dense:
// //                                                 true, // Makes the list tile more compact
// //                                             title: Row(
// //                                               mainAxisAlignment:
// //                                                   MainAxisAlignment
// //                                                       .spaceBetween,
// //                                               children: [
// //                                                 Expanded(
// //                                                   child: Text(
// //                                                     bids[index]['digit']!,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 Expanded(
// //                                                   child: Text(
// //                                                     bids[index]['points']!,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 Expanded(
// //                                                   child: Text(
// //                                                     bids[index]['type']!,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 Expanded(
// //                                                   child: GestureDetector(
// //                                                     onTap: () =>
// //                                                         _deleteBid(index),
// //                                                     child: const Icon(
// //                                                       Icons.delete,
// //                                                       color: Colors.red,
// //                                                       size:
// //                                                           18, // Smaller delete icon
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),

// //                           const SizedBox(height: 10),

// //                           // Submit Button with Consumer
// //                           Consumer<GroupJodiProvider>(
// //                             builder: (context, provider, child) {
// //                               return provider.isLoading
// //                                   ? CircularProgressIndicator()
// //                                   : SubmitButton(
// //                                       data: "Submit",
// //                                       onPressed: () {
// //                                         if (bids.isNotEmpty) {
// //                                           _showConfirmationDialog(
// //                                             context,
// //                                             provider,
// //                                           );
// //                                         } else {
// //                                           ScaffoldMessenger.of(
// //                                             context,
// //                                           ).showSnackBar(
// //                                             SnackBar(
// //                                               content: Text(
// //                                                 "Please add at least one bid",
// //                                               ),
// //                                               backgroundColor: Colors.red,
// //                                             ),
// //                                           );
// //                                         }
// //                                       },
// //                                     );
// //                             },
// //                           ),
// //                           SizedBox(height: 40),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // import 'package:dmboss/data/appdata.dart';
// // import 'package:dmboss/model/games_model/single_ank_model.dart';
// // import 'package:dmboss/provider/games_provider/group_jodi_provider.dart';
// // import 'package:dmboss/widgets/add_button.dart';
// // import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
// // import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// // import 'package:dmboss/widgets/game_app_bar.dart';
// // import 'package:dmboss/widgets/submit_button.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';

// // class GroupJodi extends StatefulWidget {
// //   final String title;
// //   final String gameName;
// //   final String marketId;
// //   const GroupJodi({
// //     super.key,
// //     required this.title,
// //     required this.gameName,
// //     required this.marketId,
// //   });

// //   @override
// //   State<GroupJodi> createState() => _GroupJodiState();
// // }

// // class _GroupJodiState extends State<GroupJodi> {
// //   final TextEditingController _digitController = TextEditingController();
// //   final TextEditingController _pointsController = TextEditingController();
// //   final GlobalKey<FormState> _globalKey = GlobalKey();

// //   bool _digitError = false;
// //   bool _pointsError = false;

// //   List<Map<String, String>> bids = [];

// //   final FocusNode _digitFocusNode = FocusNode();
// //   final LayerLink _layerLink = LayerLink();
// //   OverlayEntry? _overlayEntry;

// //   List<String> _filteredNumbers = [];
// //   bool _isDropdownVisible = false;

// //   // List<Map<String, String>> _generateCutTypes(String originalDigit) {
// //   //   List<Map<String, String>> result = [];
// //   //   String currentDigit = originalDigit;
// //   //   int level = 0;

// //   //   bool isSameDigit = originalDigit[0] == originalDigit[1];

// //   //   while (level < 8) {
// //   //     int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
// //   //     int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
// //   //     String bothCut = '$tensDigit$unitsDigit';

// //   //     result.add({
// //   //       'digit': bothCut,
// //   //       'points': _pointsController.text,
// //   //       'type': 'OPEN',
// //   //     });
// //   //     level++;
// //   //     if (level >= 8) break;

// //   //     if (isSameDigit && bothCut == originalDigit) {
// //   //       break;
// //   //     }

// //   //     int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
// //   //     String closeCut = '${bothCut[0]}$closeUnitsDigit';

// //   //     result.add({
// //   //       'digit': closeCut,
// //   //       'points': _pointsController.text,
// //   //       'type': 'OPEN',
// //   //     });
// //   //     level++;
// //   //     if (level >= 8) break;

// //   //     if (isSameDigit && closeCut == originalDigit) {
// //   //       break;
// //   //     }

// //   //     if (closeCut == originalDigit && level < 8) {
// //   //       String reversed = '${originalDigit[1]}${originalDigit[0]}';
// //   //       result.add({
// //   //         'digit': reversed,
// //   //         'points': _pointsController.text,
// //   //         'type': 'OPEN',
// //   //       });
// //   //       level++;

// //   //       if (originalDigit == "50" ||
// //   //           originalDigit == "16" ||
// //   //           originalDigit == "27" ||
// //   //           originalDigit == "38" ||
// //   //           originalDigit == "49" ||
// //   //           originalDigit == "61" ||
// //   //           originalDigit == "72" ||
// //   //           originalDigit == "83" ||
// //   //           originalDigit == "94") {
// //   //         break;
// //   //       }

// //   //       if (level >= 8) break;

// //   //       if (isSameDigit && reversed == originalDigit) {
// //   //         break;
// //   //       }

// //   //       int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
// //   //       String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

// //   //       result.add({
// //   //         'digit': paltiCloseCut,
// //   //         'points': _pointsController.text,
// //   //         'type': 'OPEN',
// //   //       });
// //   //       level++;
// //   //       if (level >= 8) break;

// //   //       if (isSameDigit && paltiCloseCut == originalDigit) {
// //   //         break;
// //   //       }

// //   //       int paltiBothTensDigit = (int.parse(paltiCloseCut[0]) + 5) % 10;
// //   //       int paltiBothUnitsDigit = (int.parse(paltiCloseCut[1]) + 5) % 10;
// //   //       String paltiBothCut = '$paltiBothTensDigit$paltiBothUnitsDigit';

// //   //       result.add({
// //   //         'digit': paltiBothCut,
// //   //         'points': _pointsController.text,
// //   //         'type': 'OPEN',
// //   //       });
// //   //       level++;
// //   //       if (level >= 8) break;

// //   //       if (isSameDigit && paltiBothCut == originalDigit) {
// //   //         break;
// //   //       }

// //   //       int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
// //   //       String paltiFinalCloseCut =
// //   //           '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

// //   //       result.add({
// //   //         'digit': paltiFinalCloseCut,
// //   //         'points': _pointsController.text,
// //   //         'type': 'OPEN',
// //   //       });
// //   //       level++;

// //   //       if (isSameDigit && paltiFinalCloseCut == originalDigit) {
// //   //         break;
// //   //       }

// //   //       break;
// //   //     } else {
// //   //       currentDigit = closeCut;
// //   //     }
// //   //   }

// //   //   return result;
// //   // }

// //   List<Map<String, String>> _generateCutTypes(String originalDigit) {
// //     List<Map<String, String>> result = [];
// //     String currentDigit = originalDigit;
// //     int level = 0;

// //     bool isSameDigit = originalDigit[0] == originalDigit[1];

// //     // Check if it's one of the special numbers that should stop further processing
// //     bool isSpecialNumber = [
// //       "50",
// //       "16",
// //       "27",
// //       "38",
// //       "49",
// //       "61",
// //       "72",
// //       "83",
// //       "94",
// //     ].contains(originalDigit);

// //     while (level < 8) {
// //       int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
// //       int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
// //       String bothCut = '$tensDigit$unitsDigit';

// //       result.add({
// //         'digit': bothCut,
// //         'points': _pointsController.text,
// //         'type': 'OPEN',
// //       });
// //       level++;
// //       if (level >= 8) break;

// //       // If we hit a special number in the process, stop further generation
// //       if (isSpecialNumber && bothCut == originalDigit) {
// //         break;
// //       }

// //       if (isSameDigit && bothCut == originalDigit) {
// //         break;
// //       }

// //       int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
// //       String closeCut = '${bothCut[0]}$closeUnitsDigit';

// //       result.add({
// //         'digit': closeCut,
// //         'points': _pointsController.text,
// //         'type': 'OPEN',
// //       });
// //       level++;
// //       if (level >= 8) break;

// //       // If we hit a special number in the process, stop further generation
// //       if (isSpecialNumber && closeCut == originalDigit) {
// //         break;
// //       }

// //       if (isSameDigit && closeCut == originalDigit) {
// //         break;
// //       }

// //       // For special numbers, don't proceed to palti logic
// //       if (isSpecialNumber) {
// //         break;
// //       }

// //       if (closeCut == originalDigit && level < 8) {
// //         String reversed = '${originalDigit[1]}${originalDigit[0]}';
// //         result.add({
// //           'digit': reversed,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;

// //         if (level >= 8) break;

// //         if (isSameDigit && reversed == originalDigit) {
// //           break;
// //         }

// //         int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
// //         String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

// //         result.add({
// //           'digit': paltiCloseCut,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;
// //         if (level >= 8) break;

// //         if (isSameDigit && paltiCloseCut == originalDigit) {
// //           break;
// //         }

// //         int paltiBothTensDigit = (int.parse(paltiCloseCut[0]) + 5) % 10;
// //         int paltiBothUnitsDigit = (int.parse(paltiCloseCut[1]) + 5) % 10;
// //         String paltiBothCut = '$paltiBothTensDigit$paltiBothUnitsDigit';

// //         result.add({
// //           'digit': paltiBothCut,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;
// //         if (level >= 8) break;

// //         if (isSameDigit && paltiBothCut == originalDigit) {
// //           break;
// //         }

// //         int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
// //         String paltiFinalCloseCut =
// //             '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

// //         result.add({
// //           'digit': paltiFinalCloseCut,
// //           'points': _pointsController.text,
// //           'type': 'OPEN',
// //         });
// //         level++;

// //         if (isSameDigit && paltiFinalCloseCut == originalDigit) {
// //           break;
// //         }

// //         break;
// //       } else {
// //         currentDigit = closeCut;
// //       }
// //     }

// //     return result;
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _digitController.addListener(_filterNumbers);
// //     _digitFocusNode.addListener(_onFocusChange);
// //     _filteredNumbers = jodiNumbers;
// //     print("Market ID in GroupJodi: ${widget.marketId}");
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
// //         _filteredNumbers = jodiNumbers;
// //       } else {
// //         try {
// //           _filteredNumbers = jodiNumbers.where((number) {
// //             return number.toString().startsWith(input);
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
// //                   return SizedBox(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                         vertical: 7,
// //                         horizontal: 15,
// //                       ),
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           setState(() {
// //                             _digitController.text = number.toString();
// //                             _digitController.selection =
// //                                 TextSelection.fromPosition(
// //                                   TextPosition(
// //                                     offset: _digitController.text.length,
// //                                   ),
// //                                 );
// //                           });
// //                           _removeOverlay();
// //                         },
// //                         child: Text(
// //                           number.toString(),
// //                           style: TextStyle(fontSize: 16),
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );

// //     Overlay.of(context).insert(_overlayEntry!);
// //     setState(() {
// //       _isDropdownVisible = true;
// //     });
// //   }

// //   void _removeOverlay() {
// //     if (_overlayEntry != null) {
// //       _overlayEntry!.remove();
// //       _overlayEntry = null;
// //       setState(() {
// //         _isDropdownVisible = false;
// //       });
// //     }
// //   }

// //   void _addBid() {
// //     FocusScope.of(context).unfocus();
// //     if (_globalKey.currentState!.validate()) {
// //       setState(() {
// //         _digitError = _digitController.text.isEmpty;
// //         _pointsError = _pointsController.text.isEmpty;

// //         if (!_digitError && !_pointsError) {
// //           // Generate cut types (excluding the original digit)
// //           List<Map<String, String>> cutTypes = _generateCutTypes(
// //             _digitController.text,
// //           );

// //           // Only add the generated cut types, NOT the original digit
// //           bids.addAll(cutTypes);

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

// //   void _submitAllBids(BuildContext context, GroupJodiProvider provider) {
// //     FocusScope.of(context).unfocus();

// //     // Convert digits list to single string (only the generated cut types)
// //     String digitsString = bids.map((bid) => bid['digit']!).join(',');

// //     // Get the first amount from the list
// //     String amount = bids.isNotEmpty ? bids[0]['points']! : '0';

// //     final groupJodiModel = SingleAnkModel(
// //       gameId: widget.marketId,
// //       gameType: "GROUP_JODI",
// //       number: digitsString,
// //       amount: int.parse(amount),
// //     );

// //     provider.placeSingleAnkBet(context, groupJodiModel);

// //     setState(() {
// //       bids.clear();
// //     });
// //   }

// //   void _showConfirmationDialog(
// //     BuildContext context,
// //     GroupJodiProvider provider,
// //   ) {
// //     final totalBids = bids.length;
// //     final totalBidAmount = bids.fold<int>(
// //       0,
// //       (sum, bid) => sum + int.parse(bid['points']!),
// //     );

// //     showDialog(
// //       context: context,
// //       builder: (context) => BetSummaryDialog(
// //         title: widget.title,
// //         date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
// //         bids: bids,
// //         totalBids: totalBids,
// //         totalBidAmount: totalBidAmount,
// //         onConfirm: () {
// //           Navigator.pop(context);
// //           _submitAllBids(context, provider);
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (context) => GroupJodiProvider(),
// //       child: Consumer<GroupJodiProvider>(
// //         builder: (context, provider, child) {
// //           return Scaffold(
// //             backgroundColor: Colors.white,
// //             appBar: AppBar(
// //               backgroundColor: Colors.orange,
// //               title: Text(
// //                 widget.title,
// //                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
// //               ),
// //               leading: IconButton(
// //                 icon: const Icon(Icons.arrow_back_ios),
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                 },
// //               ),
// //               actions: [
// //                 Container(
// //                   margin: const EdgeInsets.all(10),
// //                   padding: EdgeInsets.symmetric(
// //                     horizontal: MediaQuery.of(context).size.width * 0.02,
// //                     vertical: MediaQuery.of(context).size.height * 0.006,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   child: Wallet(),
// //                 ),
// //               ],
// //             ),
// //             body: LayoutBuilder(
// //               builder: (context, constraints) {
// //                 return SingleChildScrollView(
// //                   child: ConstrainedBox(
// //                     constraints: BoxConstraints(
// //                       minHeight: constraints.maxHeight,
// //                     ),
// //                     child: Padding(
// //                       padding: EdgeInsets.all(
// //                         MediaQuery.of(context).size.width * 0.04,
// //                       ),
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Expanded(
// //                                 child: Container(
// //                                   padding: const EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     border: Border.all(
// //                                       color: Colors.orange,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(10),
// //                                   ),
// //                                   child: Center(
// //                                     child: Text(
// //                                       widget.gameName,
// //                                       style: const TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 14,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 10),
// //                               Expanded(
// //                                 child: Container(
// //                                   padding: const EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     border: Border.all(
// //                                       color: Colors.orange,
// //                                       width: 2,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(10),
// //                                   ),
// //                                   child: Center(
// //                                     child: Text(
// //                                       "OPEN",
// //                                       style: const TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 14,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 15),

// //                           Form(
// //                             key: _globalKey,
// //                             child: Column(
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     SizedBox(width: 10),
// //                                     Text(
// //                                       "Enter Bid Digits: ",
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 50),
// //                                     Expanded(
// //                                       child: CompositedTransformTarget(
// //                                         link: _layerLink,
// //                                         child: GestureDetector(
// //                                           onTap: () {
// //                                             if (!_isDropdownVisible) {
// //                                               _digitFocusNode.requestFocus();
// //                                               _showDropdownOverlay();
// //                                             }
// //                                           },
// //                                           child: CustomTextfieldScreen1(
// //                                             controller: _digitController,
// //                                             focusNode: _digitFocusNode,
// //                                             hintText: "Number",
// //                                             onChanged: (value) {
// //                                               if (value.length > 2) {
// //                                                 _digitController.text = value
// //                                                     .substring(0, 2);
// //                                                 _digitController.selection =
// //                                                     TextSelection.fromPosition(
// //                                                       TextPosition(offset: 2),
// //                                                     );
// //                                               } else {
// //                                                 _digitController.text = value;
// //                                               }
// //                                             },
// //                                             validator: (value) {
// //                                               if (value == null ||
// //                                                   value.isEmpty ||
// //                                                   !jodiNumbers.contains(
// //                                                     value,
// //                                                   )) {
// //                                                 return "Input don't have any family \njodi";
// //                                               }
// //                                               if (value.length != 2) {
// //                                                 return "Exactly two digits required";
// //                                               }
// //                                               return null;
// //                                             },
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(height: 10),

// //                                 Row(
// //                                   children: [
// //                                     SizedBox(width: 10),
// //                                     Text(
// //                                       "Enter Bid Points: ",
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 47),
// //                                     Expanded(
// //                                       child: CustomTextfieldScreen1(
// //                                         controller: _pointsController,
// //                                         hintText: "Point",
// //                                         onChanged: (value) {
// //                                           setState(() {
// //                                             _pointsController.text = value;
// //                                           });
// //                                         },
// //                                         validator: (value) {
// //                                           if (value == null ||
// //                                               value.isEmpty ||
// //                                               int.parse(value) < 10 ||
// //                                               int.parse(value) > 10000) {
// //                                             return "Enter amount between \n10 - 10000";
// //                                           }
// //                                           return null;
// //                                         },
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 const SizedBox(height: 15),

// //                                 AddButton(data: "ADD BID", onPressed: _addBid),
// //                                 const SizedBox(height: 15),
// //                               ],
// //                             ),
// //                           ),

// //                           Container(
// //                             constraints: BoxConstraints(
// //                               maxHeight:
// //                                   MediaQuery.of(context).size.height * 0.4,
// //                             ),
// //                             child: Column(
// //                               children: [
// //                                 Container(
// //                                   child: Padding(
// //                                     padding: const EdgeInsets.only(top: 8),
// //                                     child: Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Digit",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Amount",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Type",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Expanded(
// //                                           child: Text(
// //                                             "Delete",
// //                                             textAlign: TextAlign.center,
// //                                             style: TextStyle(
// //                                               fontSize: 14,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Padding(
// //                                   padding: EdgeInsets.all(
// //                                     MediaQuery.of(context).size.width * 0.02,
// //                                   ),
// //                                   child: const Divider(
// //                                     height: 1,
// //                                     color: Colors.black,
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: ListView.builder(
// //                                     itemCount: bids.length,
// //                                     itemBuilder: (context, index) {
// //                                       return Padding(
// //                                         padding: const EdgeInsets.symmetric(
// //                                           vertical: 4,
// //                                           horizontal: 8,
// //                                         ),
// //                                         child: Container(
// //                                           decoration: BoxDecoration(
// //                                             color: Colors.grey[100],
// //                                             borderRadius: BorderRadius.circular(
// //                                               8,
// //                                             ),
// //                                           ),
// //                                           child: ListTile(
// //                                             contentPadding:
// //                                                 const EdgeInsets.symmetric(
// //                                                   horizontal: 8,
// //                                                 ),
// //                                             minVerticalPadding: 0,
// //                                             dense: true,
// //                                             title: Row(
// //                                               mainAxisAlignment:
// //                                                   MainAxisAlignment
// //                                                       .spaceBetween,
// //                                               children: [
// //                                                 Expanded(
// //                                                   child: Text(
// //                                                     bids[index]['digit']!,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 Expanded(
// //                                                   child: Text(
// //                                                     bids[index]['points']!,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 Expanded(
// //                                                   child: Text(
// //                                                     bids[index]['type']!,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 Expanded(
// //                                                   child: GestureDetector(
// //                                                     onTap: () =>
// //                                                         _deleteBid(index),
// //                                                     child: const Icon(
// //                                                       Icons.delete,
// //                                                       color: Colors.red,
// //                                                       size: 18,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),

// //                           const SizedBox(height: 10),

// //                           Consumer<GroupJodiProvider>(
// //                             builder: (context, provider, child) {
// //                               return provider.isLoading
// //                                   ? CircularProgressIndicator()
// //                                   : SubmitButton(
// //                                       data: "Submit",
// //                                       onPressed: () {
// //                                         if (bids.isNotEmpty) {
// //                                           _showConfirmationDialog(
// //                                             context,
// //                                             provider,
// //                                           );
// //                                         } else {
// //                                           ScaffoldMessenger.of(
// //                                             context,
// //                                           ).showSnackBar(
// //                                             SnackBar(
// //                                               content: Text(
// //                                                 "Please add at least one bid",
// //                                               ),
// //                                               backgroundColor: Colors.red,
// //                                             ),
// //                                           );
// //                                         }
// //                                       },
// //                                     );
// //                             },
// //                           ),
// //                           SizedBox(height: 40),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/games_model/single_ank_model.dart';
// import 'package:dmboss/provider/games_provider/group_jodi_provider.dart';
// import 'package:dmboss/widgets/add_button.dart';
// import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
// import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// import 'package:dmboss/widgets/game_app_bar.dart';
// import 'package:dmboss/widgets/submit_button.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class GroupJodi extends StatefulWidget {
//   final String title;
//   final String gameName;
//   final String marketId;
//   const GroupJodi({
//     super.key,
//     required this.title,
//     required this.gameName,
//     required this.marketId,
//   });

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

//   final FocusNode _digitFocusNode = FocusNode();
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;

//   List<String> _filteredNumbers = [];
//   bool _isDropdownVisible = false;

//   List<Map<String, String>> _generateCutTypes(String originalDigit) {
//     List<Map<String, String>> result = [];
//     String currentDigit = originalDigit;
//     int level = 0;

//     bool isSameDigit = originalDigit[0] == originalDigit[1];

//     // Check if it's one of the special numbers
//     bool isSpecialNumber = [
//       "50",
//       "16",
//       "27",
//       "38",
//       "49",
//       "61",
//       "72",
//       "83",
//       "94",
//     ].contains(originalDigit);

//     while (level < 8) {
//       int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
//       int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
//       String bothCut = '$tensDigit$unitsDigit';

//       result.add({
//         'digit': bothCut,
//         'points': _pointsController.text,
//         'type': 'OPEN',
//       });
//       level++;

//       // For special numbers, check if we reached the original digit
//       if (isSpecialNumber && bothCut == originalDigit) {
//         break;
//       }

//       if (level >= 8) break;

//       if (isSameDigit && bothCut == originalDigit) {
//         break;
//       }

//       int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
//       String closeCut = '${bothCut[0]}$closeUnitsDigit';

//       result.add({
//         'digit': closeCut,
//         'points': _pointsController.text,
//         'type': 'OPEN',
//       });
//       level++;

//       // For special numbers, check if we reached the original digit
//       if (isSpecialNumber && closeCut == originalDigit) {
//         break;
//       }

//       if (level >= 8) break;

//       if (isSameDigit && closeCut == originalDigit) {
//         break;
//       }

//       // For special numbers, don't proceed to palti logic
//       // They will naturally break when they reach the original digit
//       if (isSpecialNumber) {
//         currentDigit = closeCut;
//         continue;
//       }

//       if (closeCut == originalDigit && level < 8) {
//         String reversed = '${originalDigit[1]}${originalDigit[0]}';
//         result.add({
//           'digit': reversed,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;

//         if (level >= 8) break;

//         if (isSameDigit && reversed == originalDigit) {
//           break;
//         }

//         int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
//         String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

//         result.add({
//           'digit': paltiCloseCut,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;
//         if (level >= 8) break;

//         if (isSameDigit && paltiCloseCut == originalDigit) {
//           break;
//         }

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

//         if (isSameDigit && paltiBothCut == originalDigit) {
//           break;
//         }

//         int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
//         String paltiFinalCloseCut =
//             '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

//         result.add({
//           'digit': paltiFinalCloseCut,
//           'points': _pointsController.text,
//           'type': 'OPEN',
//         });
//         level++;

//         if (isSameDigit && paltiFinalCloseCut == originalDigit) {
//           break;
//         }

//         break;
//       } else {
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
//     print("Market ID in GroupJodi: ${widget.marketId}");
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
//                   return SizedBox(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 7,
//                         horizontal: 15,
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _digitController.text = number.toString();
//                             _digitController.selection =
//                                 TextSelection.fromPosition(
//                                   TextPosition(
//                                     offset: _digitController.text.length,
//                                   ),
//                                 );
//                           });
//                           _removeOverlay();
//                         },
//                         child: Text(
//                           number.toString(),
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
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
//     FocusScope.of(context).unfocus();
//     if (_globalKey.currentState!.validate()) {
//       setState(() {
//         _digitError = _digitController.text.isEmpty;
//         _pointsError = _pointsController.text.isEmpty;

//         if (!_digitError && !_pointsError) {
//           // Generate cut types (excluding the original digit)
//           List<Map<String, String>> cutTypes = _generateCutTypes(
//             _digitController.text,
//           );

//           // Only add the generated cut types, NOT the original digit
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

//   void _submitAllBids(BuildContext context, GroupJodiProvider provider) {
//     FocusScope.of(context).unfocus();

//     // Convert digits list to single string (only the generated cut types)
//     String digitsString = bids.map((bid) => bid['digit']!).join(',');

//     // Get the first amount from the list
//     String amount = bids.isNotEmpty ? bids[0]['points']! : '0';

//     final groupJodiModel = SingleAnkModel(
//       gameId: widget.marketId,
//       gameType: "GROUP_JODI",
//       number: digitsString,
//       amount: int.parse(amount),
//     );

//     provider.placeSingleAnkBet(context, groupJodiModel);

//     setState(() {
//       bids.clear();
//     });

//     Navigator.pop(context);
//   }

//   void _showConfirmationDialog(
//     BuildContext context,
//     GroupJodiProvider provider,
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
//     return ChangeNotifierProvider(
//       create: (context) => GroupJodiProvider(),
//       child: Consumer<GroupJodiProvider>(
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
//                                       "OPEN",
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
//                                             if (!_isDropdownVisible) {
//                                               _digitFocusNode.requestFocus();
//                                               _showDropdownOverlay();
//                                             }
//                                           },
//                                           child: CustomTextfieldScreen1(
//                                             controller: _digitController,
//                                             focusNode: _digitFocusNode,
//                                             hintText: "Number",
//                                             onChanged: (value) {
//                                               if (value.length > 2) {
//                                                 _digitController.text = value
//                                                     .substring(0, 2);
//                                                 _digitController.selection =
//                                                     TextSelection.fromPosition(
//                                                       TextPosition(offset: 2),
//                                                     );
//                                               } else {
//                                                 _digitController.text = value;
//                                               }
//                                             },
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty ||
//                                                   !jodiNumbers.contains(
//                                                     value,
//                                                   )) {
//                                                 return "Input don't have any family \njodi";
//                                               }
//                                               if (value.length != 2) {
//                                                 return "Exactly two digits required";
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

//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     AddButton(
//                                       data: "ADD BID",
//                                       onPressed: _addBid,
//                                     ),
//                                     SizedBox(width: 9)
//                                   ],
//                                 ),
//                                 const SizedBox(height: 15),
//                               ],
//                             ),
//                           ),

//                           Container(
//                             constraints: BoxConstraints(
//                               maxHeight:
//                                   MediaQuery.of(context).size.height * 0.4,
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
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
//                                             color: Colors.grey[100],
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
//                                             dense: true,
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

//                           Consumer<GroupJodiProvider>(
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
import 'package:dmboss/provider/games_provider/group_jodi_provider.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GroupJodi extends StatefulWidget {
  final String title;
  final String gameName;
  final String marketId;
  const GroupJodi({
    super.key,
    required this.title,
    required this.gameName,
    required this.marketId,
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

  final FocusNode _digitFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<String> _filteredNumbers = [];
  bool _isDropdownVisible = false;

  List<Map<String, String>> _generateCutTypes(String originalDigit) {
    List<Map<String, String>> result = [];
    String currentDigit = originalDigit;
    int level = 0;

    bool isSameDigit = originalDigit[0] == originalDigit[1];

    // Check if it's one of the special numbers
    bool isSpecialNumber = [
      "50",
      "16",
      "27",
      "38",
      "49",
      "61",
      "72",
      "83",
      "94",
    ].contains(originalDigit);

    while (level < 8) {
      int tensDigit = (int.parse(currentDigit[0]) + 5) % 10;
      int unitsDigit = (int.parse(currentDigit[1]) + 5) % 10;
      String bothCut = '$tensDigit$unitsDigit';

      result.add({
        'digit': bothCut,
        'points': _pointsController.text,
        'type': 'OPEN',
      });
      level++;

      // For special numbers, check if we reached the original digit
      if (isSpecialNumber && bothCut == originalDigit) {
        break;
      }

      if (level >= 8) break;

      if (isSameDigit && bothCut == originalDigit) {
        break;
      }

      int closeUnitsDigit = (int.parse(bothCut[1]) + 5) % 10;
      String closeCut = '${bothCut[0]}$closeUnitsDigit';

      result.add({
        'digit': closeCut,
        'points': _pointsController.text,
        'type': 'OPEN',
      });
      level++;

      // For special numbers, check if we reached the original digit
      if (isSpecialNumber && closeCut == originalDigit) {
        break;
      }

      if (level >= 8) break;

      if (isSameDigit && closeCut == originalDigit) {
        break;
      }

      // For special numbers, don't proceed to palti logic
      // They will naturally break when they reach the original digit
      if (isSpecialNumber) {
        currentDigit = closeCut;
        continue;
      }

      if (closeCut == originalDigit && level < 8) {
        String reversed = '${originalDigit[1]}${originalDigit[0]}';
        result.add({
          'digit': reversed,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;

        if (level >= 8) break;

        if (isSameDigit && reversed == originalDigit) {
          break;
        }

        int paltiCloseUnitsDigit = (int.parse(reversed[1]) + 5) % 10;
        String paltiCloseCut = '${reversed[0]}$paltiCloseUnitsDigit';

        result.add({
          'digit': paltiCloseCut,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;
        if (level >= 8) break;

        if (isSameDigit && paltiCloseCut == originalDigit) {
          break;
        }

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

        if (isSameDigit && paltiBothCut == originalDigit) {
          break;
        }

        int paltiFinalCloseUnitsDigit = (int.parse(paltiBothCut[1]) + 5) % 10;
        String paltiFinalCloseCut =
            '${paltiBothCut[0]}$paltiFinalCloseUnitsDigit';

        result.add({
          'digit': paltiFinalCloseCut,
          'points': _pointsController.text,
          'type': 'OPEN',
        });
        level++;

        if (isSameDigit && paltiFinalCloseCut == originalDigit) {
          break;
        }

        break;
      } else {
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
          offset: const Offset(0, 40),
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredNumbers.length,
                itemBuilder: (context, index) {
                  final number = _filteredNumbers[index];
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.007,
                        horizontal: MediaQuery.of(context).size.width * 0.04,
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
                        },
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
    FocusScope.of(context).unfocus();
    if (_globalKey.currentState!.validate()) {
      setState(() {
        _digitError = _digitController.text.isEmpty;
        _pointsError = _pointsController.text.isEmpty;

        if (!_digitError && !_pointsError) {
          // Generate cut types (excluding the original digit)
          List<Map<String, String>> cutTypes = _generateCutTypes(
            _digitController.text,
          );

          // Only add the generated cut types, NOT the original digit
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

  void _submitAllBids(BuildContext context, GroupJodiProvider provider) {
    FocusScope.of(context).unfocus();

    // Convert digits list to single string (only the generated cut types)
    String digitsString = bids.map((bid) => bid['digit']!).join(',');

    // Get the first amount from the list
    String amount = bids.isNotEmpty ? bids[0]['points']! : '0';

    final groupJodiModel = SingleAnkModel(
      gameId: widget.marketId,
      gameType: "GROUP_JODI",
      number: digitsString,
      amount: int.parse(amount),
    );

    provider.placeSingleAnkBet(context, groupJodiModel);

    setState(() {
      bids.clear();
    });

    Navigator.pop(context);
  }

  void _showConfirmationDialog(
    BuildContext context,
    GroupJodiProvider provider,
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
                                    borderRadius: BorderRadius.circular(10),
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
                              SizedBox(width: screenWidth * 0.025),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "OPEN",
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

                          Form(
                            key: _globalKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  !jodiNumbers.contains(
                                                    value,
                                                  )) {
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
                                SizedBox(height: screenHeight * 0.015),

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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AddButton(
                                      data: "ADD BID",
                                      onPressed: _addBid,
                                    ),
                                    SizedBox(width: screenWidth * 0.02)
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                              ],
                            ),
                          ),

                          Container(
                            constraints: BoxConstraints(
                              maxHeight: screenHeight * 0.38,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  padding: EdgeInsets.all(screenWidth * 0.015),
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
                                        padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.005,
                                          horizontal: screenWidth * 0.02,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.02,
                                            ),
                                            minVerticalPadding: 0,
                                            dense: true,
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    bids[index]['digit']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.032,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    bids[index]['points']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.032,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    bids[index]['type']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.032,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => _deleteBid(index),
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

                          SizedBox(height: screenHeight * 0.015),

                          Consumer<GroupJodiProvider>(
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
                          SizedBox(height: screenHeight * 0.04),
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
