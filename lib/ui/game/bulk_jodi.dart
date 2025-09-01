// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/widgets/current_date.dart';
// import 'package:flutter/material.dart';

// class BulkJodi extends StatefulWidget {
//   final String title;
//   const BulkJodi({super.key, required this.title});

//   @override
//   State<BulkJodi> createState() => _BulkJodiState();
// }

// class _BulkJodiState extends State<BulkJodi> {
//   final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
//   int? selectedPoint;


//   Map<String, int> selectedDigits = {};

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

//   void incrementDigitValue(String digit) {
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

//   Widget buildDigitsGrid(List<String> digits) {
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
//                 digit,
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
//                               "Select All Digits",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             buildDigitsGrid(jodiNumbers),
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

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/widgets/current_date.dart';
import 'package:flutter/material.dart';

class BulkJodi extends StatefulWidget {
  final String title;
  const BulkJodi({super.key, required this.title});

  @override
  State<BulkJodi> createState() => _BulkJodiState();
}

class _BulkJodiState extends State<BulkJodi> {
  final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
  int? selectedPoint;

  Map<String, int> selectedDigits = {};

  void resetBid() {
    setState(() {
      selectedDigits.clear();
    });
  }

  void selectPoint(int point) {
    setState(() {
      selectedPoint = point;
    });
  }

  void incrementDigitValue(String digit) {
    if (selectedPoint == null) return;

    setState(() {
      selectedDigits[digit] = (selectedDigits[digit] ?? 0) + selectedPoint!;
    });
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
              children: const [
                Text("24897", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Icon(Icons.wallet, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Column(
              children: [
                // Fixed Top Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Date Container
                    Container(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.calendar_today, color: Colors.black),
                          SizedBox(width: 5),
                          CurrentDateWidget(),
                        ],
                      ),
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
                  padding: const EdgeInsets.only(bottom: 20.0, top: 15),
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
                          onPressed: () {},
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
                            "SUBMIT BID",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}