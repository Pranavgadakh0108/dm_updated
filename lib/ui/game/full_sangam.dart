// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/games_model/single_ank_model.dart';
// import 'package:dmboss/provider/games_provider/full_sangam_provider.dart';
// import 'package:dmboss/widgets/add_button.dart';
// import 'package:dmboss/widgets/custom_textfield_screen1.dart';
// import 'package:dmboss/widgets/date_container.dart';
// import 'package:dmboss/widgets/game_app_bar.dart';
// import 'package:dmboss/widgets/submit_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class FullSangam extends StatefulWidget {
//   final String title;
//   final String gameName;
//   final String marketId; // Added marketId parameter

//   const FullSangam({
//     super.key,
//     required this.title,
//     required this.gameName,
//     required this.marketId, // Added to constructor
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

//     // You can now use widget.marketId for any initialization
//     print("Market ID in FullSangam: ${widget.marketId}");
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
//     if (_openPannaFocusNode.hasFocus) {
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
//             //return number.toString().contains(input);
//             return number.toString().startsWith(input);
//           }).toList();
//         } catch (e) {
//           _filteredOpenPannaNumbers = [];
//         }
//       }
//     });

//     if (_openPannaFocusNode.hasFocus) {
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
//               child: _filteredOpenPannaNumbers.isEmpty
//                   ? const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text("No matching pana found"),
//                       ),
//                     )
//                   : ListView.builder(
//                       padding: EdgeInsets.zero,
//                       shrinkWrap: true,
//                       itemCount: _filteredOpenPannaNumbers.length,
//                       itemBuilder: (context, index) {
//                         final number = _filteredOpenPannaNumbers[index];
//                         return ListTile(
//                           title: Text(number.toString()),
//                           onTap: () {
//                             setState(() {
//                               _openPannaController.text = number.toString();
//                               _openPannaController.selection = TextSelection.fromPosition(
//                                 TextPosition(offset: _openPannaController.text.length),
//                               );
//                             });
//                             _removeOpenPannaOverlay();
//                           },
//                         );
//                       },
//                     ),
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
//     if (_closePannaFocusNode.hasFocus) {
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
//            // return number.toString().contains(input);
//            return number.toString().startsWith(input);
//           }).toList();
//         } catch (e) {
//           _filteredClosePannaNumbers = [];
//         }
//       }
//     });

//     if (_closePannaFocusNode.hasFocus) {
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
//               child: _filteredClosePannaNumbers.isEmpty
//                   ? const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text("No matching pana found"),
//                       ),
//                     )
//                   : ListView.builder(
//                       padding: EdgeInsets.zero,
//                       shrinkWrap: true,
//                       itemCount: _filteredClosePannaNumbers.length,
//                       itemBuilder: (context, index) {
//                         final number = _filteredClosePannaNumbers[index];
//                         return ListTile(
//                           title: Text(number.toString()),
//                           onTap: () {
//                             setState(() {
//                               _closePannaController.text = number.toString();
//                               _closePannaController.selection = TextSelection.fromPosition(
//                                 TextPosition(offset: _closePannaController.text.length),
//                               );
//                             });
//                             _removeClosePannaOverlay();
//                           },
//                         );
//                       },
//                     ),
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
//     FocusScope.of(context).unfocus();
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

//   void _submitAllBids(BuildContext context) {
//     final provider = Provider.of<FullSangamProvider>(context, listen: false);

//     for (var bid in bids) {
//       final singleAnkModel = SingleAnkModel(
//         gameId: widget.marketId,
//         gameType: "FULL_SANGAM", // Changed to FULL_SANGAM
//         number: bid['displayDigit']!, // Using the combined display digit
//         amount: int.parse(bid['points']!),
//         // You might need to add additional fields for open/close values
//         // depending on your API requirements
//       );

//       provider.placeSingleAnkBet(context, singleAnkModel);
//     }

//     // Clear bids after submission
//     setState(() {
//       bids.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => FullSangamProvider(),
//       child: Consumer<FullSangamProvider>(
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
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Wallet()
//                 ),
//               ],
//             ),
//             body: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Date and Game Name
//                           Row(
//                             children: [
//                               Expanded(child: DateContainer()),
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
//                                       widget.gameName,
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
//                                 // Open Panna field
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Enter Open Pana: ",
//                                       style: TextStyle(fontWeight: FontWeight.w600),
//                                     ),
//                                     SizedBox(width: 50),
//                                     Expanded(
//                                       child: CompositedTransformTarget(
//                                         link: _openPannaLayerLink,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             FocusScope.of(context).requestFocus(_openPannaFocusNode);
//                                             _showOpenPannaDropdownOverlay();
//                                           },
//                                           child: CustomTextfieldScreen1(
//                                             controller: _openPannaController,
//                                             focusNode: _openPannaFocusNode,
//                                             hintText: "Enter Pana",
//                                             onChanged: (value) {
//                                               // For Panna - limit to 3 digits
//                                               if (value.length > 3) {
//                                                 _openPannaController.text = value.substring(0, 3);
//                                                 _openPannaController.selection = TextSelection.fromPosition(
//                                                   TextPosition(offset: 3),
//                                                 );
//                                               } else {
//                                                 _openPannaController.text = value;
//                                               }
//                                             },
//                                             validator: (value) {
//                                               if (value == null || value.isEmpty || !halfSangam.contains(value)) {
//                                                 return "Enter valid pana";
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

//                                 // Close Panna field
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Enter Close Pana: ",
//                                       style: TextStyle(fontWeight: FontWeight.w600),
//                                     ),
//                                     SizedBox(width: 43),
//                                     Expanded(
//                                       child: CompositedTransformTarget(
//                                         link: _closePannaLayerLink,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             FocusScope.of(context).requestFocus(_closePannaFocusNode);
//                                             _showClosePannaDropdownOverlay();
//                                           },
//                                           child: CustomTextfieldScreen1(
//                                             controller: _closePannaController,
//                                             focusNode: _closePannaFocusNode,
//                                             hintText: "Enter Pana",
//                                             onChanged: (value) {
//                                               // For Panna - limit to 3 digits
//                                               if (value.length > 3) {
//                                                 _closePannaController.text = value.substring(0, 3);
//                                                 _closePannaController.selection = TextSelection.fromPosition(
//                                                   TextPosition(offset: 3),
//                                                 );
//                                               } else {
//                                                 _closePannaController.text = value;
//                                               }
//                                             },
//                                             validator: (value) {
//                                               if (value == null || value.isEmpty || !halfSangam.contains(value)) {
//                                                 return "Enter valid pana";
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

//                                 // Enter Points
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Enter Points: ",
//                                       style: TextStyle(fontWeight: FontWeight.w600),
//                                     ),
//                                     SizedBox(width: 95),
//                                     Expanded(
//                                       child: CustomTextfieldScreen1(
//                                         controller: _pointsController,
//                                         hintText: "Enter Points",
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _pointsController.text = value;
//                                           });
//                                         },
//                                         validator: (value) {
//                                           if (value == null ||
//                                               value.isEmpty ||
//                                               int.parse(value) < 10 ||
//                                               int.parse(value) > 1000) {
//                                             return "Enter amount \nbetween 10 - 1000";
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
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     AddButton(data: "ADD BID", onPressed: _addBid),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 15),

//                           // Bid List Table
//                           Container(
//                             constraints: BoxConstraints(
//                               maxHeight: MediaQuery.of(context).size.height * 0.4,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.orange, width: 2),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 8,
//                                     horizontal: 10,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: const [
//                                         Expanded(
//                                           child: Text(
//                                             "Pana",
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             "Amount",
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             "Game type",
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
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
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey,
//                                                 blurRadius: 0.5,
//                                                 spreadRadius: 1,
//                                                 offset: Offset(0, 1),
//                                               ),
//                                             ],
//                                           ),
//                                           child: ListTile(
//                                             title: Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: Text(
//                                                     bids[index]['displayDigit']!,
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 ),
//                                                 Text('|'),
//                                                 Expanded(
//                                                   child: Text(
//                                                     bids[index]['points']!,
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 ),
//                                                 Text('|'),
//                                                 Expanded(
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.center,
//                                                     children: [
//                                                       SizedBox(width: 5),
//                                                       Text(
//                                                         bids[index]['type']!,
//                                                         textAlign: TextAlign.center,
//                                                       ),
//                                                       const SizedBox(width: 8),
//                                                       GestureDetector(
//                                                         onTap: () =>
//                                                             _deleteBid(index),
//                                                         child: const Icon(
//                                                           Icons.delete,
//                                                           color: Colors.red,
//                                                           size: 20,
//                                                         ),
//                                                       ),
//                                                     ],
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
//                           Consumer<FullSangamProvider>(
//                             builder: (context, provider, child) {
//                               return provider.isLoading
//                                   ? CircularProgressIndicator()
//                                   : SubmitButton(
//                                       data: "Submit",
//                                       onPressed: () {
//                                         if (bids.isNotEmpty) {
//                                           _submitAllBids(context);
//                                         } else {
//                                           ScaffoldMessenger.of(context).showSnackBar(
//                                             SnackBar(
//                                               content: Text("Please add at least one bid"),
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
import 'package:dmboss/provider/games_provider/full_sangam_provider.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/date_container.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullSangam extends StatefulWidget {
  final String title;
  final String gameName;
  final String marketId;

  const FullSangam({
    super.key,
    required this.title,
    required this.gameName,
    required this.marketId,
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

    print("Market ID in FullSangam: ${widget.marketId}");
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
            return number.toString().startsWith(input);
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
              child: _filteredOpenPannaNumbers.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No matching pana found"),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredOpenPannaNumbers.length,
                      itemBuilder: (context, index) {
                        final number = _filteredOpenPannaNumbers[index];
                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _openPannaController.text = number.toString();
                                  _openPannaController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _openPannaController.text.length,
                                    ),
                                  );
                                });
                                _removeOpenPannaOverlay();
                              },
                              child: Text(
                                number.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        );
                        // ListTile(
                        //   title: Text(number.toString()),
                        //   onTap: () {
                        //     setState(() {
                        //       _openPannaController.text = number.toString();
                        //       _openPannaController.selection =
                        //           TextSelection.fromPosition(
                        //             TextPosition(
                        //               offset: _openPannaController.text.length,
                        //             ),
                        //           );
                        //     });
                        //     _removeOpenPannaOverlay();
                        //   },
                        // );
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
            return number.toString().startsWith(input);
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
              child: _filteredClosePannaNumbers.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No matching pana found"),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredClosePannaNumbers.length,
                      itemBuilder: (context, index) {
                        final number = _filteredClosePannaNumbers[index];
                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _closePannaController.text = number
                                      .toString();
                                  _closePannaController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _closePannaController.text.length,
                                    ),
                                  );
                                });
                                _removeClosePannaOverlay();
                              },
                              child: Text(
                                number.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        );
                        // ListTile(
                        //   title: Text(number.toString()),
                        //   onTap: () {
                        //     setState(() {
                        //       _closePannaController.text = number.toString();
                        //       _closePannaController.selection = TextSelection.fromPosition(
                        //         TextPosition(offset: _closePannaController.text.length),
                        //       );
                        //     });
                        //     _removeClosePannaOverlay();
                        //   },
                        // );
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
    FocusScope.of(context).unfocus();
    if (_globalKey.currentState!.validate()) {
      setState(() {
        // Store both the original values and the combined display value
        bids.add({
          'openPanna': _openPannaController.text,
          'closePanna': _closePannaController.text,
          'points': _pointsController.text,
          'type': 'OPEN',
          'displayDigit':
              "${_openPannaController.text}-${_closePannaController.text}",
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

  void _submitAllBids(BuildContext context) {
    final provider = Provider.of<FullSangamProvider>(context, listen: false);

    for (var bid in bids) {
      final singleAnkModel = SingleAnkModel(
        gameId: widget.marketId,
        gameType: "FULL_SANGAM",
        number: bid['displayDigit']!,
        amount: int.parse(bid['points']!),
      );

      provider.placeSingleAnkBet(context, singleAnkModel);
    }

    // Clear bids after submission
    setState(() {
      bids.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FullSangamProvider(),
      child: Consumer<FullSangamProvider>(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Wallet(),
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
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

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        ),
                        child: Form(
                          key: _globalKey,
                          child: Column(
                            children: [
                              // Open Panna field
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    "Enter Open Pana: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  Expanded(
                                    child: CompositedTransformTarget(
                                      link: _openPannaLayerLink,
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(_openPannaFocusNode);
                                          _showOpenPannaDropdownOverlay();
                                        },
                                        child: CustomTextfieldScreen1(
                                          controller: _openPannaController,
                                          focusNode: _openPannaFocusNode,
                                          hintText: "Enter Pana",
                                          onChanged: (value) {
                                            // For Panna - limit to 3 digits
                                            if (value.length > 3) {
                                              _openPannaController.text = value
                                                  .substring(0, 3);
                                              _openPannaController.selection =
                                                  TextSelection.fromPosition(
                                                    TextPosition(offset: 3),
                                                  );
                                            } else {
                                              _openPannaController.text = value;
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                !halfSangam.contains(value)) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    "Enter Close Pana: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 43),
                                  Expanded(
                                    child: CompositedTransformTarget(
                                      link: _closePannaLayerLink,
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(_closePannaFocusNode);
                                          _showClosePannaDropdownOverlay();
                                        },
                                        child: CustomTextfieldScreen1(
                                          controller: _closePannaController,
                                          focusNode: _closePannaFocusNode,
                                          hintText: "Enter Pana",
                                          onChanged: (value) {
                                            // For Panna - limit to 3 digits
                                            if (value.length > 3) {
                                              _closePannaController.text = value
                                                  .substring(0, 3);
                                              _closePannaController.selection =
                                                  TextSelection.fromPosition(
                                                    TextPosition(offset: 3),
                                                  );
                                            } else {
                                              _closePannaController.text =
                                                  value;
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                !halfSangam.contains(value)) {
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
                                  const SizedBox(width: 10),
                                  Text(
                                    "Enter Points: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 95),
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
                                  AddButton(
                                    data: "ADD BID",
                                    onPressed: _addBid,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),

                              // Bid List Table
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 10,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
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
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Divider(
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: bids.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 0.5,
                                                    spreadRadius: 1,
                                                    offset: const Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        bids[index]['displayDigit']!,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    const Text('|'),
                                                    Expanded(
                                                      child: Text(
                                                        bids[index]['points']!,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    const Text('|'),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            bids[index]['type']!,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                _deleteBid(
                                                                  index,
                                                                ),
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
                              Consumer<FullSangamProvider>(
                                builder: (context, provider, child) {
                                  return provider.isLoading
                                      ? const CircularProgressIndicator()
                                      : SubmitButton(
                                          data: "Submit",
                                          onPressed: () {
                                            if (bids.isNotEmpty) {
                                              _submitAllBids(context);
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                    ? 20
                                    : 40,
                              ),
                            ],
                          ),
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
    );
  }
}
