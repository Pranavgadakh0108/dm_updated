// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/games_model/bulk_jodi_model.dart';
// import 'package:dmboss/provider/games_provider/bulk_jodi_provider.dart';
// import 'package:dmboss/widgets/game_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BulkJodii extends StatefulWidget {
//   final String title;
//   final String marketId;
//   final String gameName;
//   const BulkJodii({
//     super.key,
//     required this.title,
//     required this.marketId,
//     required this.gameName,
//   });

//   @override
//   State<BulkJodii> createState() => _BulkJodiState();
// }

// class _BulkJodiState extends State<BulkJodii> {
//   final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
//   int? selectedPoint;
//   String? userId;

//   bool _isLoading = true;

//   Future<void> getUserId() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       userId = sharedPreferences.getString('user_id');
//       _isLoading = false;
//       print('User ID: $userId');
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserId();
//   }

//   void setupProvider() {
//     if (userId != null) {
//       final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);

//       provider.setGameId(widget.marketId);
//       provider.setGameType("BULK_JODI");
//       provider.setUserId(userId!);
//       provider.setGameDate(DateTime.now());
//     }
//   }

//   void resetBid() {
//     final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);
//     provider.clearBulkJodiItems();
//     setState(() {
//       selectedPoint = null;
//     });
//   }

//   void selectPoint(int point) {
//     setState(() {
//       selectedPoint = point;
//     });
//   }

//   void incrementDigitValue(String digit) {
//     if (selectedPoint == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select a point value first"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }

//     final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);

//     // Check if digit already exists in the list
//     final existingIndex = provider.bulkJodiModel.bulkJodi.indexWhere(
//       (item) => item.jodi == digit,
//     );

//     if (existingIndex != -1) {
//       // Update existing item
//       final existingItem = provider.bulkJodiModel.bulkJodi[existingIndex];
//       final updatedItem = BulkJodi(
//         jodi: digit,
//         amount: existingItem.amount + selectedPoint!,
//       );
//       provider.updateBulkJodiItem(existingIndex, updatedItem);
//     } else {
//       // Add new item
//       final newItem = BulkJodi(jodi: digit, amount: selectedPoint!);
//       provider.addBulkJodiItem(newItem);
//     }
//   }

//   void submitBid() {
//     final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);

//     if (provider.isBulkJodiEmpty()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select at least one digit to place a bet"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }

//     if (selectedPoint == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select a point value"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }

//     // Place the bet
//     provider.placeBulkJodiBet(context, provider.bulkJodiModel);

//     resetBid();
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

//   Widget buildDigitsGrid(List<String> digits) {
//     return Consumer<BulkJodiBetProvider>(
//       builder: (context, provider, child) {
//         return Wrap(
//           spacing: 20,
//           runSpacing: 12,
//           children: digits.map((digit) {
//             // Find if this digit exists in the provider's list
//             final jodiItem = provider.bulkJodiModel.bulkJodi.firstWhere(
//               (item) => item.jodi == digit,
//               orElse: () => BulkJodi(jodi: "", amount: 0),
//             );

//             bool isSelected = jodiItem.jodi == digit;

//             return GestureDetector(
//               onTap: () => incrementDigitValue(digit),
//               child: Column(
//                 children: [
//                   Text(
//                     digit,
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     width: 60,
//                     height: 35,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Colors.grey.shade200
//                           : Colors.grey.shade300,
//                       border: Border.all(
//                         color: isSelected
//                             ? Colors.orangeAccent
//                             : Colors.grey.shade300,
//                         width: isSelected ? 3 : 0,
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       isSelected ? "${jodiItem.amount}" : "",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Setup provider when userId is available
//     if (userId != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         setupProvider();
//       });
//     }

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
//             child: Row(mainAxisSize: MainAxisSize.min, children: [Wallet()]),
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Consumer<BulkJodiBetProvider>(
//               builder: (context, provider, child) {
//                 return LayoutBuilder(
//                   builder: (context, constraints) {
//                     return Padding(
//                       padding: EdgeInsets.all(
//                         MediaQuery.of(context).size.width * 0.04,
//                       ),
//                       child: Column(
//                         children: [
//                           // Fixed Top Content
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // Date Container
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       padding: const EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.orange,
//                                           width: 2,
//                                         ),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           widget.gameName,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Container(
//                                       padding: const EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.orange,
//                                           width: 2,
//                                         ),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           "OPEN",
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 15),

//                               // Points Selection
//                               const Text(
//                                 "Select Points for Betting",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.orange,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               buildPointsSelector(),
//                               const SizedBox(height: 15),
//                             ],
//                           ),

//                           // Scrollable Digits Section
//                           Expanded(
//                             child: Column(
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
//                                   "Select All Digits",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),

//                                 // Scrollable digits grid
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     child: buildDigitsGrid(jodiNumbers),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Fixed Bottom Buttons
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               bottom: 20.0,
//                               top: 5,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Flexible(
//                                   child: ElevatedButton(
//                                     onPressed: resetBid,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.orange,
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             MediaQuery.of(context).size.width *
//                                             0.06,
//                                         vertical: 12,
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       "RESET BID",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Flexible(
//                                   child: ElevatedButton(
//                                     onPressed: submitBid,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.orange,
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             MediaQuery.of(context).size.width *
//                                             0.06,
//                                         vertical: 12,
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       "SUBMIT BID",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 15),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/bulk_jodi_model.dart';
import 'package:dmboss/provider/games_provider/bulk_jodi_provider.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulkJodii extends StatefulWidget {
  final String title;
  final String marketId;
  final String gameName;
  const BulkJodii({
    super.key,
    required this.title,
    required this.marketId,
    required this.gameName,
  });

  @override
  State<BulkJodii> createState() => _BulkJodiState();
}

class _BulkJodiState extends State<BulkJodii> {
  final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
  int? selectedPoint;
  String? userId;

  bool _isLoading = true;

  // Create the bids list as requested
  List<Map<String, String>> bids = [];

  Future<void> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString('user_id');
      _isLoading = false;
      print('User ID: $userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void setupProvider() {
    if (userId != null) {
      final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);

      provider.setGameId(widget.marketId);
      provider.setGameType("BULK_JODI");
      provider.setUserId(userId!);
      provider.setGameDate(DateTime.now());
    }
  }

  void resetBid() {
    final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);
    provider.clearBulkJodiItems();
    setState(() {
      selectedPoint = null;
      bids.clear(); // Clear the bids list
    });
  }

  void selectPoint(int point) {
    setState(() {
      selectedPoint = point;
    });
  }

  void incrementDigitValue(String digit) {
    if (selectedPoint == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a point value first"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);

    // Check if digit already exists in the bids list
    final existingIndex = bids.indexWhere(
      (item) => item.containsKey(digit),
    );

    if (existingIndex != -1) {
      // Update existing item in bids list
      final currentAmount = int.parse(bids[existingIndex][digit]!);
      final newAmount = currentAmount + selectedPoint!;
      bids[existingIndex][digit] = newAmount.toString();
      
      // Also update the provider for backward compatibility
      final existingProviderIndex = provider.bulkJodiModel.bulkJodi.indexWhere(
        (item) => item.jodi == digit,
      );
      if (existingProviderIndex != -1) {
        final updatedItem = BulkJodi(
          jodi: digit,
          amount: newAmount,
        );
        provider.updateBulkJodiItem(existingProviderIndex, updatedItem);
      }
    } else {
      // Add new item to bids list
      bids.add({digit: selectedPoint!.toString()});
      
      // Also add to provider for backward compatibility
      final newItem = BulkJodi(jodi: digit, amount: selectedPoint!);
      provider.addBulkJodiItem(newItem);
    }

    // Notify UI to update
    setState(() {});
  }

  void submitBid() {
    final provider = Provider.of<BulkJodiBetProvider>(context, listen: false);

    if (bids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one digit to place a bet"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (selectedPoint == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a point value"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Convert bids list to provider format for submission
    provider.bulkJodiModel.bulkJodi.clear();
    for (var bid in bids) {
      bid.forEach((key, value) {
        provider.addBulkJodiItem(BulkJodi(
          jodi: key,
          amount: int.parse(value),
        ));
      });
    }

    // Place the bet
    provider.placeBulkJodiBet(context, provider.bulkJodiModel);

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

  Widget buildDigitsGrid(List<String> digits) {
    return Consumer<BulkJodiBetProvider>(
      builder: (context, provider, child) {
        return Wrap(
          spacing: 20,
          runSpacing: 12,
          children: digits.map((digit) {
            // Find if this digit exists in the bids list
            String amountText = "";
            bool isSelected = false;
            
            for (var bid in bids) {
              if (bid.containsKey(digit)) {
                amountText = bid[digit]!;
                isSelected = true;
                break;
              }
            }

            return GestureDetector(
              onTap: () => incrementDigitValue(digit),
              child: Column(
                children: [
                  Text(
                    digit,
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
                      amountText,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Setup provider when userId is available
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setupProvider();
      });
    }

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
            child: Row(mainAxisSize: MainAxisSize.min, children: [Wallet()]),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<BulkJodiBetProvider>(
              builder: (context, provider, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Column(
                        children: [
                          // Fixed Top Content
                          Column(
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
                                          "OPEN",
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
                            ],
                          ),

                          // Scrollable Digits Section
                          Expanded(
                            child: Column(
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
                                  "Select All Digits",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Scrollable digits grid
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: buildDigitsGrid(jodiNumbers),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Fixed Bottom Buttons
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20.0,
                              top: 5,
                            ),
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
                                            MediaQuery.of(context).size.width *
                                            0.06,
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
                                    onPressed: submitBid,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                            0.06,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      "SUBMIT BID",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
