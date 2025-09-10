// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:dmboss/model/withdraw_coins_model.dart';
import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/get_bank_details_provider.dart';
import 'package:dmboss/provider/withdraw_coins_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
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
  String? _errorMessage;
  bool _showTermsPopup = true;

  Future<void> getUserId() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        userId = sharedPreferences.getString('user_id');
        print('User ID: $userId');
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load user data';
      });
    }
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await getUserId();

      if (userId != null) {
        final bankDetailsProvider = Provider.of<GetBankDetailsProvider>(
          context,
          listen: false,
        );
        await bankDetailsProvider.getBankDetails(context, userId!);

        final getGamesSettings = Provider.of<GamesSettingsProvider>(
          context,
          listen: false,
        );
        await getGamesSettings.getGameSettings(context);

        // Show terms popup only once
        if (_showTermsPopup) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showTermsPopup(context, getGamesSettings);
            setState(() {
              _showTermsPopup = false;
            });
          });
        }
      } else {
        setState(() {
          _errorMessage = 'User not logged in. Please login again.';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load data. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadInitialData();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
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
          "Withdraw Coins",
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
      body: _isLoading
          ? _buildLoadingState()
          : _errorMessage != null
          ? _buildErrorState(_errorMessage!)
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
                      return _buildBankDetailsLoadingState();
                    }

                    // Show error if bank details fetch failed
                    if (provider.errorMessage != null) {
                      return _buildBankDetailsErrorState(
                        provider.errorMessage!,
                      );
                    }

                    // Show message if no bank details found
                    if (provider.gamesList?.banks == null ||
                        provider.gamesList!.banks.isEmpty) {
                      return _buildNoBankDetailsState();
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
                                provider
                                    .gamesList
                                    ?.banks[0]
                                    .accountHolderName ??
                                "",
                          ),
                          hintText: "A/C Holder Name",
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextFormField(
                          controller: TextEditingController(
                            text:
                                provider.gamesList?.banks[0].accountNumber ??
                                "",
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
                        // OrangeButton(
                        //   text: "Add Bank Details",

                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => AddBankDetailsPage(),
                        //       ),
                        //     );
                        //   },
                        // ),
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
                              Consumer<WithdrawCoinsProvider>(
                                builder: (context, withdrawProvider, _) {
                                  return OrangeButton(
                                    text: "Withdraw",

                                    onPressed: () {
                                      if (_globalKey.currentState!.validate()) {
                                        final withDrawCoinsModel =
                                            WithdrawCoinsModel(
                                              amount: int.parse(
                                                withdrawCoinsController.text,
                                              ),
                                            );

                                        withdrawProvider.addWithdrawCoins(
                                          context,
                                          withDrawCoinsModel,
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppNavigationBar(),
                                          ),
                                        );
                                      }
                                    },
                                  );
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

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          SizedBox(height: 16),
          Text(
            'Loading withdrawal information...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _retryLoading,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          SizedBox(height: 16),
          Text(
            'Loading bank details...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_balance_outlined,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _retryLoading,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoBankDetailsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No bank account found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please add your bank account details first to withdraw funds',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _retryLoading,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
