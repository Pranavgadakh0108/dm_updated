import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/single_ank_model.dart';
import 'package:dmboss/provider/games_provider/jodi_provider.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Jodi extends StatefulWidget {
  final String title;
  final String gameName;
  final String marketId;
  const Jodi({
    super.key,
    required this.title,
    required this.gameName,
    required this.marketId,
  });

  @override
  State<Jodi> createState() => _JodiState();
}

class _JodiState extends State<Jodi> {
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

  @override
  void initState() {
    super.initState();
    _digitController.addListener(_filterNumbers);
    _digitFocusNode.addListener(_onFocusChange);
    _filteredNumbers = jodiNumbers;
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

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: screenWidth * 0.5,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 40),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: BoxConstraints(maxHeight: screenWidth * 0.5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: _filteredNumbers.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Text(
                          "No matching digits found",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
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
                              vertical: screenWidth * 0.015,
                              horizontal: screenWidth * 0.04,
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
                                style: TextStyle(fontSize: screenWidth * 0.04),
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

  void _addBid() {
    FocusScope.of(context).unfocus();
    if (_globalKey.currentState!.validate()) {
      setState(() {
        _digitError = _digitController.text.isEmpty;
        _pointsError = _pointsController.text.isEmpty;

        if (!_digitError && !_pointsError) {
          bids.add({
            'digit': _digitController.text,
            'points': _pointsController.text,
            'type': 'OPEN',
          });
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

  void _submitAllBids(BuildContext context, JodiProvider provider) {
    FocusScope.of(context).unfocus();

    for (var bid in bids) {
      final singleAnkModel = SingleAnkModel(
        gameId: widget.marketId,
        gameType: "JODI",
        number: bid['digit']!,
        amount: int.parse(bid['points']!),
      );

      provider.placeSingleAnkBet(context, singleAnkModel);
    }

    setState(() {
      bids.clear();
    });

    Navigator.pop(context);
  }

  void _showConfirmationDialog(BuildContext context, JodiProvider provider) {
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
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return ChangeNotifierProvider(
      create: (context) => JodiProvider(),
      child: Consumer<JodiProvider>(
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
                icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.06),
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
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
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
                                      width: screenWidth * 0.005,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.03,
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
                              SizedBox(width: screenWidth * 0.03),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: screenWidth * 0.005,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.03,
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
                          SizedBox(height: screenHeight * 0.02),

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
                                    SizedBox(width: screenWidth * 0.1),
                                    Expanded(
                                      child: CompositedTransformTarget(
                                        link: _layerLink,
                                        child: CustomTextfieldScreen1(
                                          controller: _digitController,
                                          focusNode: _digitFocusNode,
                                          hintText: "Enter Digit",
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
                                                !jodiNumbers.contains(value)) {
                                              return "Enter the valid digits";
                                            }
                                            if (value.length > 2) {
                                              return "Only two digit allowed";
                                            }
                                            return null;
                                          },
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
                                    SizedBox(width: screenWidth * 0.1),
                                    Expanded(
                                      child: CustomTextfieldScreen1(
                                        controller: _pointsController,
                                        hintText: "Enter Amount",
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
                                    SizedBox(width: screenWidth * 0.02),
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
                                                          screenWidth * 0.032,
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
                                                          screenWidth * 0.032,
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
                                                          screenWidth * 0.032,
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

                          Consumer<JodiProvider>(
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
