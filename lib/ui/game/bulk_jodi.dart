import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/bulk_jodi_model.dart';
import 'package:dmboss/provider/games_provider/bulk_jodi_provider.dart';
import 'package:dmboss/widgets/bulk_summary_dialogue.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  List<Map<String, String>> bids = [];

  Future<void> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString('user_id');
      _isLoading = false;
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
      bids.clear();
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

    final existingIndex = bids.indexWhere((item) => item.containsKey(digit));

    if (existingIndex != -1) {
      final currentAmount = int.parse(bids[existingIndex][digit]!);
      final newAmount = currentAmount + selectedPoint!;
      bids[existingIndex][digit] = newAmount.toString();

      final existingProviderIndex = provider.bulkJodiModel.bulkJodi.indexWhere(
        (item) => item.jodi == digit,
      );
      if (existingProviderIndex != -1) {
        final updatedItem = BulkJodi(jodi: digit, amount: newAmount);
        provider.updateBulkJodiItem(existingProviderIndex, updatedItem);
      }
    } else {
      bids.add({digit: selectedPoint!.toString()});

      final newItem = BulkJodi(jodi: digit, amount: selectedPoint!);
      provider.addBulkJodiItem(newItem);
    }

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

    provider.bulkJodiModel.bulkJodi.clear();
    for (var bid in bids) {
      bid.forEach((key, value) {
        provider.addBulkJodiItem(BulkJodi(jodi: key, amount: int.parse(value)));
      });
    }

    provider.placeBulkJodiBet(context, provider.bulkJodiModel);

    resetBid();

    Navigator.pop(context);
  }

  void _showConfirmationDialog(BuildContext context) {
    final totalBids = bids.length;
    final totalBidAmount = bids.fold<int>(
      0,
      (sum, bid) => sum + int.parse(bid.values.first),
    );

    showDialog(
      context: context,
      builder: (context) => BulkJodiBetSummaryDialog(
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

  Widget buildDigitsGrid(List<String> digits) {
    final screenWidth = MediaQuery.of(context).size.width;
    final digitContainerWidth = screenWidth * 0.15;
    final digitContainerHeight = screenWidth * 0.08;

    return Consumer<BulkJodiBetProvider>(
      builder: (context, provider, child) {
        return Wrap(
          spacing: screenWidth * 0.04,
          runSpacing: screenWidth * 0.03,
          children: digits.map((digit) {
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
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.005),
                  Container(
                    width: digitContainerWidth,
                    height: digitContainerHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.grey.shade200
                          : Colors.grey.shade300,
                      border: Border.all(
                        color: isSelected
                            ? Colors.orangeAccent
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 0,
                      ),
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    child: Text(
                      amountText,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.045,
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
              borderRadius: BorderRadius.circular(screenWidth * 0.07),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [Wallet()]),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<BulkJodiBetProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      Column(
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
                                      width: 1.5,
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
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.02,
                                    ),
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
                          SizedBox(height: screenHeight * 0.015),

                          Text(
                            "Select Points for Betting",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          buildPointsSelector(),
                          SizedBox(height: screenHeight * 0.015),
                        ],
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Divider(color: Colors.orange, thickness: 1),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              "Select All Digits",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.008),

                            Expanded(
                              child: SingleChildScrollView(
                                child: buildDigitsGrid(jodiNumbers),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.02,
                          top: screenHeight * 0.005,
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
                                    horizontal: screenWidth * 0.06,
                                    vertical: screenHeight * 0.015,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.07,
                                    ),
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
                                onPressed: () =>
                                    _showConfirmationDialog(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.06,
                                    vertical: screenHeight * 0.015,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.07,
                                    ),
                                  ),
                                ),
                                child: Text(
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
                      SizedBox(height: screenHeight * 0.015),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
