// ignore_for_file: library_private_types_in_public_api

import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddFundScreen extends StatefulWidget {
  const AddFundScreen({super.key});

  @override
  _AddFundScreenState createState() => _AddFundScreenState();
}

class _AddFundScreenState extends State<AddFundScreen> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  // bool _showErrorIcon = false;

  // void _validateAmount() {
  //   setState(() {
  //     _showErrorIcon = _amountController.text.isEmpty;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: const Text(
          "Deposite Coins",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  "Balance :  24897",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                // TextFormField(
                //   controller: _amountController,
                //   keyboardType: TextInputType.number,
                //   cursorColor: Colors.pink,
                //   decoration: InputDecoration(
                //     hintText: "Enter Amount",
                //     filled: true,
                //     fillColor: Colors.grey.shade100,
                //     contentPadding: EdgeInsets.symmetric(
                //       horizontal: 12,
                //       vertical: 14,
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //       borderSide: BorderSide.none,
                //     ),

                //     // suffixIcon: _showErrorIcon
                //     //     ? IconButton(onPressed: (){
                //     //       Tooltip(message: "Please Enter Amount",
                //     //       preferBelow: true,
                //     //       );
                //     //     }, icon: Icon(Icons.error, color: Colors.red))
                //     //     :null,
                //     suffixIcon: _showErrorIcon
                //         ? Builder(
                //             builder: (context) {
                //               final GlobalKey<TooltipState> tooltipKey =
                //                   GlobalKey<TooltipState>();
                //               return Tooltip(
                //                 key: tooltipKey,
                //                 message: "Please Enter Amount",
                //                 triggerMode: TooltipTriggerMode
                //                     .manual, // Disable automatic triggers
                //                 child: IconButton(
                //                   onPressed: () {
                //                     tooltipKey.currentState?.ensureTooltipVisible();
                //                     // Hide after 2 seconds
                //                     Future.delayed(const Duration(seconds: 2), () {
                //                       if (tooltipKey.currentState?.mounted ??
                //                           false) {
                //                         tooltipKey.currentState?.deactivate();
                //                       }
                //                     });
                //                   },
                //                   icon: const Icon(Icons.error, color: Colors.red),
                //                 ),
                //               );
                //             },
                //           )
                //         : null,
                //   ),
                // ),
                CustomTextField(
                  hintText: "Enter Amount",
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  onChanged: (value) {
                    setState(() {
                      _amountController.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠️ Enter the Amount";
                    }
                    if (value.contains('.')) {
                      return "⚠️ Enter the Correct Amount (Remove '.')";
                    }
                    if (int.parse(value) < 100) {
                      return "⚠️ Amount must be at least 100";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  // onPressed: _validateAmount,
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "ADD MANUAL PAYMENT",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(196, 25, 127, 211),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "PAYMENT GATEWAY",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
