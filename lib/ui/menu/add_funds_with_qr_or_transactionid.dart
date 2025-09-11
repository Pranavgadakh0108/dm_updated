// ignore_for_file: library_private_types_in_public_api

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/deposite_manual_points.dart';
import 'package:dmboss/provider/add_deposite_manual_provider.dart';
import 'package:dmboss/provider/get_qr_code_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFundScreenWithQR extends StatefulWidget {
  const AddFundScreenWithQR({super.key});

  @override
  _AddFundScreenWithQRState createState() => _AddFundScreenWithQRState();
}

class _AddFundScreenWithQRState extends State<AddFundScreenWithQR> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionIdController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AddDepositePointsManualProvider>(
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
            child: Consumer2<UserProfileProvider, GetQrCodeProvider>(
              builder: (context, provider, qrProvider, _) {
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
                    SizedBox(height: 20),

                    qrProvider.gamesList?.qrCodes[0].qrImage != null
                        ? Image.network(
                            '$baseUrl${qrProvider.gamesList?.qrCodes[0].qrImage}',
                            height: 200,
                            width: 500,
                          )
                        : CircularProgressIndicator(color: Colors.orange),

                    Text(
                      "Scan qr code for payment or add Payment manually",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18),
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
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Enter Transaction Id",
                      keyboardType: TextInputType.text,
                      controller: _transactionIdController,
                      onChanged: (value) {
                        setState(() {
                          _transactionIdController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the Transaction Id";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          final depositeManualPoints = DepositeManualPoints(
                            transactionId: _transactionIdController.text,
                            amount: int.parse(_amountController.text),
                          );
                          setState(() {
                            final provider =
                                Provider.of<AddDepositePointsManualProvider>(
                                  context,
                                  listen: false,
                                );
                            provider.addDepositePointsManual(
                              context,
                              depositeManualPoints,
                            );
                          });
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
