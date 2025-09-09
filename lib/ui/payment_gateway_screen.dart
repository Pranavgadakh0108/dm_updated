// ignore_for_file: deprecated_member_use

import 'package:dmboss/model/payment_model.dart';
import 'package:dmboss/provider/get_qr_code_provider.dart';
import 'package:dmboss/provider/payment_gateway_provider.dart';
import 'package:dmboss/provider/payment_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentGatewayScreen extends StatefulWidget {
  final String? mode;
  const PaymentGatewayScreen({super.key, required this.mode});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PaymentGatewayProvider>(
        context,
        listen: false,
      );
      _amountController.text = provider.amount;

      final userProvider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );
      userProvider.fetchUserProfile();

      final qrProvider = Provider.of<GetQrCodeProvider>(context, listen: false);
      qrProvider.getQrCodeProvider(context);
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child:
                Consumer3<
                  UserProfileProvider,
                  GetQrCodeProvider,
                  PaymentProvider
                >(
                  builder: (context, provider, qrProvider, paymentProvider, _) {
                    _nameController.text =
                        provider.userProfile?.user.name ?? "";
                    _mobileController.text =
                        provider.userProfile?.user.mobile ?? "";

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
                        Text(
                          "Add Your Payment Details!!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomProfileTextFormField(
                          controller: TextEditingController(
                            text: _nameController.text,
                          ),
                          hintText: "Name",
                          icon: Icons.person,
                          readOnly: true,
                        ),

                        SizedBox(height: 20),
                        CustomProfileTextFormField(
                          controller: TextEditingController(
                            text: _mobileController.text,
                          ),
                          hintText: "Phone",
                          icon: Icons.phone,
                          readOnly: true,
                        ),

                        SizedBox(height: 20),
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
                              return 'Please enter an amount';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 30),

                        // Loading indicator or button
                        if (paymentProvider.isLoading)
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Processing...",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ElevatedButton(
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                final paymentGatewayModel =
                                    PaymentModel(
                                      amount: int.parse(_amountController.text),
                                      action: "combo",
                                      method: widget.mode ?? ""
                                      // redirectUrl:
                                      //     "https://api.dmbossbusiness.com/after-pay",
                                    );

                                paymentProvider.postPaymentGateway(
                                  context,
                                  paymentGatewayModel,
                                  widget.mode ?? "MANUAL",
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        SizedBox(height: 12),

                        // Error message
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
