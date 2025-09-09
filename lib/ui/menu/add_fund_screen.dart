// ignore_for_file: library_private_types_in_public_api

import 'package:dmboss/provider/add_deposite_manual_provider.dart';
import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/get_payment_mode_provider.dart';
import 'package:dmboss/provider/payment_gateway_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/ui/menu/add_funds_with_qr_or_transactionid.dart';
import 'package:dmboss/ui/payment_gateway_screen.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      final paymentModeProvider = Provider.of<GetPaymentModeProvider>(
        context,
        listen: false,
      );
      paymentModeProvider.getPaymentMode(context);
    });
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
                    SizedBox(height: 15),

                    Text(
                      "For Fund Query's please Contact",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),

                    Consumer<GamesSettingsProvider>(
                      builder: (context, settingsProvider, _) {
                        return GestureDetector(
                          onTap: () => openWhatsApp(
                            settingsProvider.gameSettings?.data.whatsapp == ""
                                ? "9888195353"
                                : settingsProvider
                                          .gameSettings
                                          ?.data
                                          .whatsapp ??
                                      "",
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.whatsapp,
                                size: 25,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "9888195353",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 15),

                    Consumer<GetPaymentModeProvider>(
                      builder: (context, paymentProvider, _) {
                        return ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              paymentProvider.gamesList?.data.active == "MANUAL"
                                  ? setState(() {
                                      final provider =
                                          Provider.of<
                                            AddDepositePointsManualProvider
                                          >(context, listen: false);
                                      provider.setAmount(
                                        _amountController.text,
                                      );
                                    })
                                  : setState(() {
                                      final provider =
                                          Provider.of<PaymentGatewayProvider>(
                                            context,
                                            listen: false,
                                          );
                                      provider.setAmount(
                                        _amountController.text,
                                      );
                                    });
                            
                            paymentProvider.gamesList?.data.active == "MANUAL"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddFundScreenWithQR(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentGatewayScreen(
                                            mode: paymentProvider
                                                .gamesList
                                                ?.data
                                                .active,
                                          ),
                                    ),
                                  );
                          }},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "ADD PAYMENT",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(
      //     bottom: 20,
      //   ), // Adjust this value to lift it up more
      //   child: Consumer<GamesSettingsProvider>(
      //     builder: (context, settingsProvider, _) {
      //       return FloatingActionButton(
      //         onPressed: () {
      //           print(settingsProvider.gameSettings?.data.whatsapp ?? "");
      //           openWhatsApp(
      //             settingsProvider.gameSettings?.data.whatsapp == ""
      //                 ? "9888195353"
      //                 : settingsProvider.gameSettings?.data.whatsapp ?? "",
      //           );
      //         },
      //         backgroundColor: Colors.green,
      //         child: Icon(
      //           FontAwesomeIcons.whatsapp,
      //           color: Colors.white,
      //           size: 40,
      //         ),
      //       );
      //     },
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
