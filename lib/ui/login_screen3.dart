// // ignore_for_file: deprecated_member_use

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/ui/login_screen1.dart';
// import 'package:dmboss/util/make_call.dart';
// import 'package:dmboss/util/make_whatsapp_chat.dart';
// import 'package:dmboss/widgets/always_phone_prefix.dart';
// import 'package:dmboss/widgets/custom_text_field.dart';
// import 'package:dmboss/widgets/navigation_bar.dart';
// import 'package:dmboss/widgets/orange_button.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class LoginScreen3 extends StatefulWidget {
//   final String mobileNumber;

//   const LoginScreen3({super.key, required this.mobileNumber});

//   @override
//   State<LoginScreen3> createState() => _LoginScreen3State();
// }

// class _LoginScreen3State extends State<LoginScreen3> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final GlobalKey<FormState> _globalKey = GlobalKey();

//   void handleContinue() {
//     if (_globalKey.currentState!.validate()) {
//       // Register and auto login success
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const AppNavigationBar()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenHeight < 600;

//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen1()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.05,
//               vertical: screenHeight * 0.03,
//             ),
//             child: Form(
//               key: _globalKey,
//               child: Column(
//                 children: [
//                   SizedBox(height: screenHeight * 0.08),

//                   // App logo
//                   Container(
//                     height: screenHeight * 0.2,
//                     width: screenHeight * 0.2,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(screenHeight * 0.05),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(screenWidth * 0.03),
//                       child: Image.asset('assets/images/dmbossLogo.png'),
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.1),

//                   // Mobile field (read-only)
//                   CustomPhoneField(
//                     controller: TextEditingController(text: widget.mobileNumber),
//                     enabled: false,
//                     validator: (value) => null,
//                   ),
//                   SizedBox(height: screenHeight * 0.025),

//                   // Name field
//                   CustomTextField(
//                     controller: nameController,
//                     hintText: 'Name',
//                     icon: Icons.person,
//                     keyboardType: TextInputType.text,
//                     onChanged: (value) {
//                       nameController.text = value;
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter the Name first...";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.025),

//                   // Password field
//                   CustomTextField(
//                     controller: passwordController,
//                     hintText: 'Password',
//                     icon: Icons.lock,
//                     obscureText: true,
//                     keyboardType: TextInputType.text,
//                     onChanged: (value) {
//                       passwordController.text = value;
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter the Password first...";
//                       }
//                       if (!passwordRegExp.hasMatch(value)) {
//                         return "Enter valid Password";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.025),

//                   // Confirm Password field
//                   CustomTextField(
//                     controller: confirmPasswordController,
//                     hintText: 'Confirm Password',
//                     icon: Icons.lock,
//                     obscureText: true,
//                     keyboardType: TextInputType.text,
//                     onChanged: (value) {
//                       confirmPasswordController.text = value;
//                     },
//                     validator: (value) {
//                       if (value == null ||
//                           value.isEmpty ||
//                           value != passwordController.text) {
//                         return "Enter the correct Password";
//                       }
//                       if (!passwordRegExp.hasMatch(value)) {
//                         return "Enter valid Password";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.05),

//                   // Continue Button
//                   OrangeButton(text: 'Continue', onPressed: handleContinue),
//                   SizedBox(height: screenHeight * 0.03),

//                   // // Common section
//                   // _buildCommonSection(isSmallScreen),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// }

// ignore_for_file: deprecated_member_use

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/register_user_provider.dart';
import 'package:dmboss/ui/login_screen1.dart';
import 'package:dmboss/widgets/always_phone_prefix.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen3 extends StatefulWidget {
  final String mobileNumber;

  const LoginScreen3({super.key, required this.mobileNumber});

  @override
  State<LoginScreen3> createState() => _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  void handleContinue() async {
    if (_globalKey.currentState!.validate()) {
      final registerProvider = Provider.of<RegisterUserProvider>(
        context,
        listen: false,
      );

      final success = await registerProvider.registerUser(
        mobile: widget.mobileNumber,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        context: context,
      );

      if (success) {
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
        body: Consumer<RegisterUserProvider>(
          builder: (context, registerProvider, child) {
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
                      SizedBox(height: screenHeight * 0.1),

                      // Mobile field (read-only)
                      CustomPhoneField(
                        controller: TextEditingController(
                          text: widget.mobileNumber,
                        ),
                        enabled: false,
                        validator: (value) => null,
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Name field
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Name',
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          nameController.text = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Name first...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Email field
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          emailController.text = value;
                          registerProvider.setEmail(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Email first...";
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return "Enter valid Email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Password field
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
                          if (value.length < 6) {
                            return "Password required minimum 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Confirm Password field
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          confirmPasswordController.text = value;
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value != passwordController.text) {
                            return "Enter the correct Password";
                          }
                          // if (!passwordRegExp.hasMatch(value)) {
                          //   return "Enter valid Password";
                          // }
                          if (value.length < 6) {
                            return "Password required minimum 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Error message
                      if (registerProvider.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            registerProvider.errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),

                      // Continue Button
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
                        onPressed: registerProvider.isLoading
                            ? null
                            : handleContinue,
                        child: registerProvider.isLoading
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
