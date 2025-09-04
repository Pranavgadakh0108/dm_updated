import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/single_ank_model.dart';
import 'package:dmboss/provider/games_provider/half_sangam_provider.dart';
import 'package:dmboss/widgets/add_button.dart';
import 'package:dmboss/widgets/bet_summarry_dialogue.dart';
import 'package:dmboss/widgets/custom_textfield_screen1.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HalfSangam extends StatefulWidget {
  final String title;
  final String gameName;
  final String marketId; // Added marketId parameter

  const HalfSangam({
    super.key,
    required this.title,
    required this.gameName,
    required this.marketId, // Added to constructor
  });
  @override
  State<HalfSangam> createState() => _HalfSangamState();
}

class _HalfSangamState extends State<HalfSangam> {
  // Four separate controllers for each field type
  final TextEditingController _openDigitsController = TextEditingController();
  final TextEditingController _openPannaController = TextEditingController();
  final TextEditingController _closeDigitsController = TextEditingController();
  final TextEditingController _closePannaController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  bool _isFlipped = false; // Track if the fields are flipped

  List<Map<String, String>> bids = [];

  // Dropdown functionality for open digits field
  final FocusNode _openDigitsFocusNode = FocusNode();
  final LayerLink _openDigitsLayerLink = LayerLink();
  OverlayEntry? _openDigitsOverlayEntry;
  List<String> _filteredOpenDigitsNumbers = [];

  // Dropdown functionality for open panna field
  final FocusNode _openPannaFocusNode = FocusNode();
  final LayerLink _openPannaLayerLink = LayerLink();
  OverlayEntry? _openPannaOverlayEntry;
  List<String> _filteredOpenPannaNumbers = [];

  // Dropdown functionality for close digits field
  final FocusNode _closeDigitsFocusNode = FocusNode();
  final LayerLink _closeDigitsLayerLink = LayerLink();
  OverlayEntry? _closeDigitsOverlayEntry;
  List<String> _filteredCloseDigitsNumbers = [];

  // Dropdown functionality for close panna field
  final FocusNode _closePannaFocusNode = FocusNode();
  final LayerLink _closePannaLayerLink = LayerLink();
  OverlayEntry? _closePannaOverlayEntry;
  List<String> _filteredClosePannaNumbers = [];

  @override
  void initState() {
    super.initState();

    // Initialize all dropdowns
    _openDigitsController.addListener(() => _filterOpenDigitsNumbers());
    _openDigitsFocusNode.addListener(() => _onOpenDigitsFocusChange());
    _filteredOpenDigitsNumbers = singleAnkNumbers;

    _openPannaController.addListener(() => _filterOpenPannaNumbers());
    _openPannaFocusNode.addListener(() => _onOpenPannaFocusChange());
    _filteredOpenPannaNumbers = halfSangam;

    _closeDigitsController.addListener(() => _filterCloseDigitsNumbers());
    _closeDigitsFocusNode.addListener(() => _onCloseDigitsFocusChange());
    _filteredCloseDigitsNumbers = singleAnkNumbers;

    _closePannaController.addListener(() => _filterClosePannaNumbers());
    _closePannaFocusNode.addListener(() => _onClosePannaFocusChange());
    _filteredClosePannaNumbers = halfSangam;

    // You can now use widget.marketId for any initialization
    print("Market ID in HalfSangam: ${widget.marketId}");
  }

  @override
  void dispose() {
    // Clean up all controllers and focus nodes
    _openDigitsController.dispose();
    _openPannaController.dispose();
    _closeDigitsController.dispose();
    _closePannaController.dispose();
    _pointsController.dispose();

    _openDigitsFocusNode.dispose();
    _openPannaFocusNode.dispose();
    _closeDigitsFocusNode.dispose();
    _closePannaFocusNode.dispose();

    _removeOpenDigitsOverlay();
    _removeOpenPannaOverlay();
    _removeCloseDigitsOverlay();
    _removeClosePannaOverlay();

    super.dispose();
  }

  // Dropdown methods for each field (similar structure for all)
  void _onOpenDigitsFocusChange() {
    if (_openDigitsFocusNode.hasFocus) {
      _showOpenDigitsDropdownOverlay();
    } else {
      _removeOpenDigitsOverlay();
    }
  }

  void _filterOpenDigitsNumbers() {
    final input = _openDigitsController.text;
    setState(() {
      if (input.isEmpty) {
        _filteredOpenDigitsNumbers = singleAnkNumbers;
      } else {
        try {
          _filteredOpenDigitsNumbers = singleAnkNumbers.where((number) {
            // return number.toString().contains(input);
            return number.toString().startsWith(input);
          }).toList();
        } catch (e) {
          _filteredOpenDigitsNumbers = [];
        }
      }
    });

    if (_openDigitsFocusNode.hasFocus) {
      if (_openDigitsOverlayEntry == null) {
        _showOpenDigitsDropdownOverlay();
      } else {
        _openDigitsOverlayEntry!.markNeedsBuild();
      }
    } else {
      _removeOpenDigitsOverlay();
    }
  }

  void _showOpenDigitsDropdownOverlay() {
    _removeOpenDigitsOverlay();

    _openDigitsOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.5,
        child: CompositedTransformFollower(
          link: _openDigitsLayerLink,
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
              child: _filteredOpenDigitsNumbers.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No matching digits found"),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredOpenDigitsNumbers.length,
                      itemBuilder: (context, index) {
                        final number = _filteredOpenDigitsNumbers[index];
                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _openDigitsController.text = number
                                      .toString();
                                  _openDigitsController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _openDigitsController.text.length,
                                    ),
                                  );
                                });
                                _removeOpenDigitsOverlay();
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
                        //       _openDigitsController.text = number.toString();
                        //       _openDigitsController.selection =
                        //           TextSelection.fromPosition(
                        //             TextPosition(
                        //               offset: _openDigitsController.text.length,
                        //             ),
                        //           );
                        //     });
                        //     _removeOpenDigitsOverlay();
                        //   },
                        // );
                      },
                    ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_openDigitsOverlayEntry!);
  }

  void _removeOpenDigitsOverlay() {
    if (_openDigitsOverlayEntry != null) {
      _openDigitsOverlayEntry!.remove();
      _openDigitsOverlayEntry = null;
    }
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
            // return number.toString().contains(input);
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
                        child: Text("No matching panna found"),
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

  // Close Digits methods
  void _onCloseDigitsFocusChange() {
    if (_closeDigitsFocusNode.hasFocus) {
      _showCloseDigitsDropdownOverlay();
    } else {
      _removeCloseDigitsOverlay();
    }
  }

  void _filterCloseDigitsNumbers() {
    final input = _closeDigitsController.text;
    setState(() {
      if (input.isEmpty) {
        _filteredCloseDigitsNumbers = singleAnkNumbers;
      } else {
        try {
          _filteredCloseDigitsNumbers = singleAnkNumbers.where((number) {
            //return number.toString().contains(input);
            return number.toString().startsWith(input);
          }).toList();
        } catch (e) {
          _filteredCloseDigitsNumbers = [];
        }
      }
    });

    if (_closeDigitsFocusNode.hasFocus) {
      if (_closeDigitsOverlayEntry == null) {
        _showCloseDigitsDropdownOverlay();
      } else {
        _closeDigitsOverlayEntry!.markNeedsBuild();
      }
    } else {
      _removeCloseDigitsOverlay();
    }
  }

  void _showCloseDigitsDropdownOverlay() {
    _removeCloseDigitsOverlay();

    _closeDigitsOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.5,
        child: CompositedTransformFollower(
          link: _closeDigitsLayerLink,
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
              child: _filteredCloseDigitsNumbers.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No matching digits found"),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredCloseDigitsNumbers.length,
                      itemBuilder: (context, index) {
                        final number = _filteredCloseDigitsNumbers[index];
                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _closeDigitsController.text = number
                                      .toString();
                                  _closeDigitsController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset:
                                          _closeDigitsController.text.length,
                                    ),
                                  );
                                });
                                _removeCloseDigitsOverlay();
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
                        //       _closeDigitsController.text = number.toString();
                        //       _closeDigitsController
                        //           .selection = TextSelection.fromPosition(
                        //         TextPosition(
                        //           offset: _closeDigitsController.text.length,
                        //         ),
                        //       );
                        //     });
                        //     _removeCloseDigitsOverlay();
                        //   },
                        // );
                      },
                    ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_closeDigitsOverlayEntry!);
  }

  void _removeCloseDigitsOverlay() {
    if (_closeDigitsOverlayEntry != null) {
      _closeDigitsOverlayEntry!.remove();
      _closeDigitsOverlayEntry = null;
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
            //return number.toString().contains(input);
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
                        child: Text("No matching panna found"),
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
                        //       _closePannaController.selection =
                        //           TextSelection.fromPosition(
                        //             TextPosition(
                        //               offset: _closePannaController.text.length,
                        //             ),
                        //           );
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
        if (_isFlipped) {
          // When flipped, use open panna and close digits
          bids.add({
            'openDigits':
                _openPannaController.text, // This should be panna value
            //'openPanna': _openPannaController.text,
            // 'closeDigits': _closeDigitsController.text,
            'closePanna':
                _closeDigitsController.text, // This should be digits value
            'points': _pointsController.text,
            'type': 'OPEN',
            'displayDigit':
                "${_openPannaController.text}-${_closeDigitsController.text}",
          });
        } else {
          // When not flipped, use open digits and close panna
          bids.add({
            'openDigits': _openDigitsController.text,
            'openPanna':
                _openDigitsController.text, // This should be digits value
            'closeDigits':
                _closePannaController.text, // This should be panna value
            'closePanna': _closePannaController.text,
            'points': _pointsController.text,
            'type': 'OPEN',
            'displayDigit':
                "${_openDigitsController.text}-${_closePannaController.text}",
          });
        }

        // Clear all fields
        _openDigitsController.clear();
        _openPannaController.clear();
        _closeDigitsController.clear();
        _closePannaController.clear();
        _pointsController.clear();

        // Remove any active overlays
        _removeOpenDigitsOverlay();
        _removeOpenPannaOverlay();
        _removeCloseDigitsOverlay();
        _removeClosePannaOverlay();
      });
    }
  }

  void _deleteBid(int index) {
    setState(() {
      bids.removeAt(index);
    });
  }

  void _flipGame() {
    setState(() {
      _isFlipped = !_isFlipped;
      // Update display digits for all existing bids
      for (var bid in bids) {
        if (_isFlipped) {
          bid['displayDigit'] = "${bid['openPanna']}-${bid['closeDigits']}";
        } else {
          bid['displayDigit'] = "${bid['openDigits']}-${bid['closePanna']}";
        }
      }
    });
  }

  void _submitAllBids(BuildContext context, HalfSangamProvider provider) {
    //final provider = Provider.of<HalfSangamProvider>(context, listen: false);
    FocusScope.of(context).unfocus();

    for (var bid in bids) {
      // For Half Sangam, we need to send both open and close values
      // Adjust this based on your API requirements
      final singleAnkModel = SingleAnkModel(
        gameId: widget.marketId,
        gameType: "HALF_SANGAM", // Changed to HALF_SANGAM
        number: bid['displayDigit']!, // Using the combined display digit
        amount: int.parse(bid['points']!),
        // You might need to add additional fields for open/close values
        // depending on your API requirements
      );

      provider.placeSingleAnkBet(context, singleAnkModel);
    }

    // Clear bids after submission
    setState(() {
      bids.clear();
    });
  }

  void _showConfirmationDialog(
    BuildContext context,
    HalfSangamProvider provider,
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
    return ChangeNotifierProvider(
      create: (context) => HalfSangamProvider(),
      child: Consumer<HalfSangamProvider>(
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

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        ),
                        child: Form(
                          key: _globalKey,
                          child: Column(
                            children: [
                              // Show/hide fields based on flip state
                              if (!_isFlipped) ...[
                                // Open Digits field (visible when not flipped)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      "Enter Open Digits: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    Expanded(
                                      child: CompositedTransformTarget(
                                        link: _openDigitsLayerLink,
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).requestFocus(
                                              _openDigitsFocusNode,
                                            );
                                            _showOpenDigitsDropdownOverlay();
                                          },
                                          child: CustomTextfieldScreen1(
                                            controller: _openDigitsController,
                                            focusNode: _openDigitsFocusNode,
                                            hintText: "Enter Single",
                                            onChanged: (value) {
                                              if (value.length > 1) {
                                                _openDigitsController.text =
                                                    value[0];
                                                _openDigitsController
                                                        .selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(offset: 1),
                                                    );
                                              } else {
                                                _openDigitsController.text =
                                                    value;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !singleAnkNumbers.contains(
                                                    value,
                                                  )) {
                                                return "Enter valid digit";
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

                                // Close Panna field (visible when not flipped)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      "Enter Close Panna: ",
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
                                            FocusScope.of(context).requestFocus(
                                              _closePannaFocusNode,
                                            );
                                            _showClosePannaDropdownOverlay();
                                          },
                                          child: CustomTextfieldScreen1(
                                            controller: _closePannaController,
                                            focusNode: _closePannaFocusNode,
                                            hintText: "Enter Pana",
                                            onChanged: (value) {
                                              if (value.length > 3) {
                                                _closePannaController.text =
                                                    value.substring(0, 3);
                                                _closePannaController
                                                        .selection =
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
                                                return "Enter valid panna";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                // Open Panna field (visible when flipped)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      "Enter Open Panna: ",
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
                                              if (value.length > 3) {
                                                _openPannaController.text =
                                                    value.substring(0, 3);
                                                _openPannaController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(offset: 3),
                                                    );
                                              } else {
                                                _openPannaController.text =
                                                    value;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !halfSangam.contains(value)) {
                                                return "Enter valid panna";
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

                                // Close Digits field (visible when flipped)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      "Enter Close Digits: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 43),
                                    Expanded(
                                      child: CompositedTransformTarget(
                                        link: _closeDigitsLayerLink,
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).requestFocus(
                                              _closeDigitsFocusNode,
                                            );
                                            _showCloseDigitsDropdownOverlay();
                                          },
                                          child: CustomTextfieldScreen1(
                                            controller: _closeDigitsController,
                                            focusNode: _closeDigitsFocusNode,
                                            hintText: "Enter Single",
                                            onChanged: (value) {
                                              if (value.length > 1) {
                                                _closeDigitsController.text =
                                                    value[0];
                                                _closeDigitsController
                                                        .selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(offset: 1),
                                                    );
                                              } else {
                                                _closeDigitsController.text =
                                                    value;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !singleAnkNumbers.contains(
                                                    value,
                                                  )) {
                                                return "Enter valid digit";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                                  const SizedBox(width: 20),
                                  AddButton(
                                    data: "FLIP GAME",
                                    onPressed: _flipGame,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),

                              // Bid List Table
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height *
                                      0.4, // Reduced height
                                ),

                                child: Column(
                                  children: [
                                    // Table header
                                    Container(
                                      // padding: const EdgeInsets.symmetric(
                                      //   vertical: 8,
                                      //   horizontal: 10,
                                      // ),
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
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Amount",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Type",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Delete",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                      ),
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
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 8,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .grey[100], // Lighter background
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                minVerticalPadding: 0,
                                                dense:
                                                    true, // Makes the list tile more compact
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        bids[index]['displayDigit']!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        bids[index]['points']!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        bids[index]['type']!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            _deleteBid(index),
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size:
                                                              18, // Smaller delete icon
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
                              const SizedBox(height: 10),

                              // Submit Button with Consumer
                              Consumer<HalfSangamProvider>(
                                builder: (context, provider, child) {
                                  return provider.isLoading
                                      ? const CircularProgressIndicator()
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
