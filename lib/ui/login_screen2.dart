// ignore_for_file: deprecated_member_use

import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/login_user_provider.dart';
import 'package:dmboss/ui/login_screen1.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/always_phone_prefix.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen2 extends StatefulWidget {
  final String mobileNumber;

  const LoginScreen2({super.key, required this.mobileNumber});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  void handleContinue() async {
    if (_globalKey.currentState!.validate()) {
      final loginProvider = Provider.of<LoginUserProvider>(
        context,
        listen: false,
      );

      final success = await loginProvider.loginUser(
        mobile: widget.mobileNumber,
        password: passwordController.text,
        context: context,
      );

      if (success && mounted) {
        // Login success - navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppNavigationBar()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen1()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<LoginUserProvider>(
          builder: (context, loginProvider, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03,
                    ),
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.05),

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
                              child: Image.asset(
                                'assets/images/dmbossLogo.png',
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),

                          CustomPhoneField(
                            controller: TextEditingController(
                              text: widget.mobileNumber,
                            ),
                            enabled: false,
                            validator: (value) => null,
                          ),
                          SizedBox(height: screenHeight * 0.025),

                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              passwordController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Password first...";
                              }
                              // if (!passwordRegExp.hasMatch(value)) {
                              //   return "Enter valid Password";
                              // }
                              if (value.length < 4 || value.length > 4) {
                                return "Password required 4 digits";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),

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
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                            onPressed: loginProvider.isLoading
                                ? null
                                : handleContinue,
                            child: loginProvider.isLoading
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

                          // Error message if any
                          if (loginProvider.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                loginProvider.errorMessage!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          // Common section
                          _buildCommonSection(isSmallScreen),
                        ],
                      ),
                    ),
                  ),
                ),

                // Loading overlay
                if (loginProvider.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orange,
                        ),
                      ),
                    ),
                  ),
              ],
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
}
