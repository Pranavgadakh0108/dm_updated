import 'package:dmboss/model/games_model/bulk_sp_model.dart';
import 'package:dmboss/widgets/bulk_sp_dp_dialogue.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/game_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dmboss/provider/games_provider/bulk_sp_provider.dart';

class BulkSP extends StatefulWidget {
  final String title;
  final String marketId;
  final String gameName;
  final String openTime;
  const BulkSP({
    super.key,
    required this.title,
    required this.marketId,
    required this.gameName,
    required this.openTime,
  });

  @override
  State<BulkSP> createState() => _BulkSPState();
}

class _BulkSPState extends State<BulkSP> {
  final List<int> pointsList = [5, 10, 20, 50, 100, 200, 500, 1000];
  int? selectedPoint;

  final List<int> digits1 = [
    128,
    137,
    146,
    236,
    245,
    290,
    380,
    470,
    489,
    560,
    579,
    678,
  ];
  final List<int> digits2 = [
    129,
    138,
    147,
    156,
    237,
    246,
    345,
    390,
    480,
    570,
    589,
    679,
  ];
  final List<int> digits3 = [
    120,
    139,
    148,
    157,
    238,
    247,
    256,
    346,
    490,
    580,
    670,
    689,
  ];
  final List<int> digits4 = [
    130,
    149,
    158,
    167,
    239,
    248,
    257,
    347,
    356,
    590,
    680,
    789,
  ];
  final List<int> digits5 = [
    140,
    159,
    168,
    230,
    249,
    258,
    267,
    348,
    357,
    456,
    690,
    780,
  ];
  final List<int> digits6 = [
    123,
    150,
    169,
    178,
    240,
    259,
    268,
    349,
    358,
    367,
    457,
    790,
  ];
  final List<int> digits7 = [
    124,
    160,
    278,
    179,
    250,
    269,
    340,
    359,
    368,
    458,
    467,
    890,
  ];
  final List<int> digits8 = [
    125,
    134,
    170,
    189,
    260,
    279,
    350,
    369,
    468,
    378,
    459,
    567,
  ];
  final List<int> digits9 = [
    126,
    135,
    180,
    234,
    270,
    289,
    360,
    379,
    450,
    469,
    478,
    568,
  ];
  final List<int> digits0 = [
    127,
    136,
    145,
    190,
    235,
    280,
    370,
    389,
    460,
    479,
    569,
    578,
  ];

  Map<int, int> selectedDigits = {};

  List<Map<String, String>> bids = [];

  void resetBid() {
    setState(() {
      selectedDigits.clear();
      bids.clear();
    });

    final provider = Provider.of<BulkSpBetProvider>(context, listen: false);
    provider.clearBulkSpItems();
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

      final digitStr = digit.toString();
      final amountStr = selectedDigits[digit]!.toString();

      final existingIndex = bids.indexWhere((bid) => bid['digit'] == digitStr);

      if (existingIndex != -1) {
        bids[existingIndex] = {'digit': digitStr, 'amount': amountStr};
      } else {
        bids.add({'digit': digitStr, 'amount': amountStr});
      }
    });

    final provider = Provider.of<BulkSpBetProvider>(context, listen: false);

    final existingIndex = provider.bulkSpModel.bulkSp.indexWhere(
      (item) => item.number == digit.toString(),
    );

    if (existingIndex != -1) {
      final newItem = BulkSp(
        number: digit.toString(),
        amount: selectedDigits[digit]!,
      );
      provider.updateBulkSpItem(existingIndex, newItem);
    } else {
      final newItem = BulkSp(number: digit.toString(), amount: selectedPoint!);
      provider.addBulkSpItem(newItem);
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

    final provider = Provider.of<BulkSpBetProvider>(context, listen: false);

    provider.setGameId(widget.marketId);
    provider.setGameType("BULK_SP");

    provider.placeBulkSpBet(context, provider.bulkSpModel);

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
    final isSmallScreen = screenWidth < 360;

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
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.09,
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
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: Text(
                  isSelected ? "${selectedDigits[digit]}" : "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 10 : 12,
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
    final isSmallScreen = screenWidth < 360;

    final gameStatus = getGameStatus(widget.openTime);
    return Consumer<BulkSpBetProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isSmallScreen ? 16 : 18,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.05),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(screenWidth * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.01,
                ),
                constraints: BoxConstraints(maxWidth: screenWidth * 0.4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.08),
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
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.02,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.gameName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 12 : 14,
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
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    Text(
                      "Select Points for Betting",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    buildPointsSelector(),
                    SizedBox(height: screenHeight * 0.02),

                    Center(
                      child: Text(
                        "Select Digits",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                    Divider(color: Colors.orange, thickness: 1),
                  ],
                ),
              ),

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
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits1),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits2),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits3),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 4",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits4),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits5),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 6",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits6),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 7",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits7),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 8",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits8),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 9",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits9),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(color: Colors.orange, thickness: 1),
                      Text(
                        "Select All Digits 0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildDigitsGrid(digits0),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),

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
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.08,
                            ),
                          ),
                        ),
                        child: Text(
                          "RESET BID",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 12 : 14,
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
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.08,
                            ),
                          ),
                        ),
                        child: provider.isLoading
                            ? SizedBox(
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "SUBMIT BID",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSmallScreen ? 12 : 14,
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
