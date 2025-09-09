// ignore_for_file: deprecated_member_use

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/mobile_exist_provider.dart';
import 'package:dmboss/ui/login_screen2.dart';
import 'package:dmboss/ui/login_screen3.dart';
import 'package:dmboss/widgets/always_phone_prefix.dart';
import 'package:dmboss/widgets/exit_dialog.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({super.key});

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _isNavigating = false; // Add this flag to prevent multiple navigations
  bool _isLoading = true;
  String? _errorMessage;

  void handleContinue() {
    if (_globalKey.currentState!.validate()) {
      final mobileCheckProvider = Provider.of<MobileCheckProvider>(
        context,
        listen: false,
      );

      mobileCheckProvider.setMobileNumber(mobileController.text);
      mobileCheckProvider.checkMobileExists(context, mobileController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactionHistory();
    });
  }

  Future<void> _loadTransactionHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final getGameSettings = Provider.of<GamesSettingsProvider>(
        context,
        listen: false,
      );
      await getGameSettings.getGameSettings(context);
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load Games. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600;

    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<MobileCheckProvider>(
          builder: (context, mobileCheckProvider, child) {
            // Handle navigation when response arrives
            if (mobileCheckProvider.mobileExistResponse != null &&
                !mobileCheckProvider.isLoading &&
                !_isNavigating) {
              _isNavigating = true; // Set flag to prevent multiple navigations
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mobileCheckProvider.mobileExists) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen2(mobileNumber: mobileController.text),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen3(mobileNumber: mobileController.text),
                    ),
                  );
                }

                // Reset after a delay to allow navigation to complete
                Future.delayed(const Duration(milliseconds: 100), () {
                  _isNavigating = false;
                  mobileCheckProvider.reset();
                });
              });
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03,
                ),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.08),

                      // App logo
                      Container(
                        height: screenHeight * 0.2,
                        width: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                            screenHeight * 0.05,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Image.asset('assets/images/dmbossLogo.png'),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),

                      CustomPhoneField(
                        controller: mobileController,
                        onChanged: (value) {
                          setState(() {
                            mobileController.text = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Mobile Number first...";
                          }
                          if (!phoneRegex.hasMatch(value)) {
                            return "Enter valid Mobile number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      if (mobileCheckProvider.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            mobileCheckProvider.errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // padding: const EdgeInsets.symmetric(vertical: 15),
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.015,
                            horizontal: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                        onPressed: mobileCheckProvider.isLoading
                            ? null
                            : handleContinue,
                        child: mobileCheckProvider.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      _buildCommonSection(isSmallScreen),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCommonSection(bool isSmallScreen) {
    return Consumer<GamesSettingsProvider>(
      builder: (context, gameSettings, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => openWhatsApp(
                    gameSettings.gameSettings?.data.whatsapp == ""
                        ? "9888195353"
                        : gameSettings.gameSettings?.data.whatsapp ?? "",
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => openWhatsApp(
                    gameSettings.gameSettings?.data.whatsapp == ""
                        ? "9888195353"
                        : gameSettings.gameSettings?.data.whatsapp ?? "",
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                        size: isSmallScreen ? 30 : 40,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        gameSettings.gameSettings?.data.whatsapp == ""
                            ? "9888195353"
                            : gameSettings.gameSettings?.data.whatsapp ?? "",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => makePhoneCall(
                    gameSettings.gameSettings?.data.whatsapp == ""
                        ? "9888195353"
                        : gameSettings.gameSettings?.data.whatsapp ?? "",
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.black,
                        size: isSmallScreen ? 22 : 33,
                      ),
                      const SizedBox(height: 9),
                      Text(
                        gameSettings.gameSettings?.data.whatsapp == ""
                            ? "9888195353"
                            : gameSettings.gameSettings?.data.whatsapp ?? "",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
}
