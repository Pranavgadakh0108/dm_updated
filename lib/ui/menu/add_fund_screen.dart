// ignore_for_file: library_private_types_in_public_api

import 'package:dmboss/provider/add_deposite_manual_provider.dart';
import 'package:dmboss/provider/payment_gateway_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/service/post_payment_gateway.dart';
import 'package:dmboss/ui/menu/add_funds_with_qr_or_transactionid.dart';
import 'package:dmboss/ui/payment_gateway_screen.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFundScreen extends StatefulWidget {
  const AddFundScreen({super.key});

  @override
  _AddFundScreenState createState() => _AddFundScreenState();
}

class _AddFundScreenState extends State<AddFundScreen> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final provider = Provider.of<AddDepositePointsManualProvider>(
      //   context,
      //   listen: false,
      // );
      // _amountController.text = provider.amount;

      final userProvider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );
      userProvider.fetchUserProfile();
    });
  }

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
            child: Consumer<UserProfileProvider>(
              builder: (context, provider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Balance : ${provider.userProfile?.user.wallet}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),

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
                        if (_globalKey.currentState!.validate()) {
                          setState(() {
                            final provider =
                                Provider.of<AddDepositePointsManualProvider>(
                                  context,
                                  listen: false,
                                );
                            provider.setAmount(_amountController.text);
                          });
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFundScreenWithQR(),
                          ),
                        );
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
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          setState(() {
                            final provider =
                                Provider.of<PaymentGatewayProvider>(
                                  context,
                                  listen: false,
                                );
                            provider.setAmount(_amountController.text);
                          });
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentGatewayScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          196,
                          25,
                          127,
                          211,
                        ),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
