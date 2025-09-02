// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:dmboss/model/withdraw_coins_model.dart';
import 'package:dmboss/provider/get_bank_details_provider.dart';
import 'package:dmboss/provider/withdraw_coins_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:dmboss/widgets/term_condition_popup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawPoints extends StatefulWidget {
  const WithdrawPoints({super.key});

  @override
  State<WithdrawPoints> createState() => _WithdrawPointsState();
}

class _WithdrawPointsState extends State<WithdrawPoints> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController withdrawCoinsController = TextEditingController();
  String? userId;
  bool _isLoading = true;

  Future<void> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString('user_id');
      _isLoading = false;
      print('User ID: $userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId().then((_) {
      // After user ID is loaded, fetch bank details
      if (userId != null) {
        final bankDetailsProvider = Provider.of<GetBankDetailsProvider>(
          context,
          listen: false,
        );
        bankDetailsProvider.getBankDetails(context, userId!);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        showTermsPopup(context);
      });
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
          "Withdraw Coins",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Consumer<GetBankDetailsProvider>(
                  builder: (context, provider, _) {
                    // Show loading if bank details are still being fetched
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Show error if bank details fetch failed
                    if (provider.errorMessage != null) {
                      return Center(
                        child: Text(
                          provider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    // Show message if no bank details found
                    if (provider.gamesList?.banks == null ||
                        provider.gamesList!.banks.isEmpty) {
                      return const Center(
                        child: Text(
                          'No bank details found. Please add your bank account first.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          'Bank A/C Details',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextFormField(
                          controller: TextEditingController(
                            text:
                                provider.gamesList!.banks[0].accountHolderName,
                          ),
                          hintText: "A/C Holder Name",
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextFormField(
                          controller: TextEditingController(
                            text: provider.gamesList!.banks[0].accountNumber,
                          ),
                          hintText: "A/C Number",
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextFormField(
                          controller: TextEditingController(
                            text: provider.gamesList!.banks[0].ifscCode,
                          ),
                          hintText: "IFSC",
                          readOnly: true,
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () => openWhatsApp("+919888195353"),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.squareWhatsapp,
                                color: Colors.green,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '9888195353',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Withdraw Fund Request Below',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _globalKey,
                          child: Column(
                            children: [
                              CustomProfileTextFormField(
                                controller: withdrawCoinsController,
                                hintText: "Enter Points",
                                icon: FontAwesomeIcons.circleDollarToSlot,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "⚠️ Enter valid Coins";
                                  }
                                  if (int.tryParse(value) == null) {
                                    return "⚠️ Enter valid number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              OrangeButton(
                                text: "Withdraw",
                                onPressed: () {
                                  if (_globalKey.currentState!.validate()) {
                                    final withDrawCoinsModel =
                                        WithdrawCoinsModel(
                                          amount: int.parse(
                                            withdrawCoinsController.text,
                                          ),
                                        );
                                    setState(() {
                                      final provider =
                                          Provider.of<WithdrawCoinsProvider>(
                                            context,
                                            listen: false,
                                          );

                                      provider.addWithdrawCoins(
                                        context,
                                        withDrawCoinsModel,
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
