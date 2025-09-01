// // // ignore_for_file: deprecated_member_use

// // import 'package:dmboss/ui/register_screen.dart';
// // import 'package:dmboss/widgets/always_phone_prefix.dart';
// // import 'package:dmboss/widgets/custom_text_field.dart';
// // import 'package:dmboss/widgets/exit_dialog.dart';
// // import 'package:dmboss/widgets/make_call.dart';
// // import 'package:dmboss/widgets/make_whatsapp_chat.dart';
// // import 'package:dmboss/widgets/navigation_bar.dart';
// // import 'package:dmboss/widgets/orange_button.dart';
// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         showExitDialog(context);
// //         return false; // prevent default back
// //       },
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         body: SingleChildScrollView(
// //           child: Padding(
// //             //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
// //             padding: EdgeInsets.symmetric(
// //               horizontal: MediaQuery.of(context).size.width * 0.05,
// //               vertical: MediaQuery.of(context).size.height * 0.06,
// //             ),
// //             child: Column(
// //               children: [
// //                 const SizedBox(height: 50),

// //                 // App logo
// //                 Container(
// //                   height: 180,
// //                   width: 180,
// //                   decoration: BoxDecoration(
// //                     color: Colors.black,
// //                     borderRadius: BorderRadius.circular(50),
// //                   ),
// //                   child: Padding(
// //                     // padding: const EdgeInsets.all(12.0),
// //                     padding: EdgeInsets.all(
// //                       MediaQuery.of(context).size.width * 0.03,
// //                     ),
// //                     child: Image.asset('assets/images/dmbossLogo.png'),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 120),
// //                 // Phone field
// //                 CustomPhoneField(controller: TextEditingController()),

// //                 const SizedBox(height: 25),

// //                 // Password field
// //                 CustomTextField(
// //                   hintText: 'Password',
// //                   icon: Icons.lock,
// //                   obscureText: true,
// //                   keyboardType: TextInputType.text,
// //                 ),
// //                 const SizedBox(height: 50),

// //                 OrangeButton(
// //                   text: 'Login',
// //                   onPressed: () {
// //                     Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => AppNavigationBar(),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //                 const SizedBox(height: 30),
// //                 // Create Account & Forgot Password
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                     Column(
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => RegisterScreen(),
// //                               ),
// //                             );
// //                           },
// //                           child: const Text(
// //                             'Create Account',
// //                             style: TextStyle(
// //                               fontSize: 14,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 20),
// //                         Row(
// //                           children: [
// //                             GestureDetector(
// //                               onTap: () => openWhatsApp("+919888195353"),
// //                               child: Column(
// //                                 children: [
// //                                   Icon(
// //                                     FontAwesomeIcons.squareWhatsapp,
// //                                     color: Colors.green,
// //                                     size: 40,
// //                                   ),
// //                                   SizedBox(height: 5),
// //                                   Text(
// //                                     '+919888195353',
// //                                     style: TextStyle(
// //                                       fontSize: 14,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                     Column(
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () => openWhatsApp("+919888195353"),
// //                           child: const Text(
// //                             'Forgot Password?',
// //                             style: TextStyle(
// //                               fontSize: 14,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 20),
// //                         Row(
// //                           children: [
// //                             GestureDetector(
// //                               onTap: () => makePhoneCall("+919888395353"),
// //                               child: Column(
// //                                 children: [
// //                                   Icon(
// //                                     FontAwesomeIcons.whatsapp,
// //                                     color: Colors.black,
// //                                     size: 40,
// //                                   ),
// //                                   SizedBox(height: 5),
// //                                   Text(
// //                                     '+919888395353',
// //                                     style: TextStyle(
// //                                       fontSize: 14,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: deprecated_member_use

// import 'package:dmboss/ui/register_screen.dart';
// import 'package:dmboss/widgets/always_phone_prefix.dart';
// import 'package:dmboss/widgets/custom_text_field.dart';
// import 'package:dmboss/widgets/exit_dialog.dart';
// import 'package:dmboss/widgets/make_call.dart';
// import 'package:dmboss/widgets/make_whatsapp_chat.dart';
// import 'package:dmboss/widgets/navigation_bar.dart';
// import 'package:dmboss/widgets/orange_button.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenHeight < 600; // Check for small screens

//     return WillPopScope(
//       onWillPop: () async {
//         showExitDialog(context);
//         return false; // prevent default back
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.05,
//               vertical: screenHeight * 0.03,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: screenHeight * 0.08),

//                 // App logo
//                 Container(
//                   height: screenHeight * 0.2,
//                   width: screenHeight * 0.2,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(screenHeight * 0.05),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(screenWidth * 0.03),
//                     child: Image.asset('assets/images/dmbossLogo.png'),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.1),

//                 // Phone field
//                 CustomPhoneField(controller: TextEditingController()),

//                 SizedBox(height: screenHeight * 0.025),

//                 // Password field
//                 CustomTextField(
//                   hintText: 'Password',
//                   icon: Icons.lock,
//                   obscureText: true,
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: screenHeight * 0.05),

//                 OrangeButton(
//                   text: 'Continue',
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AppNavigationBar(),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: screenHeight * 0.03),

// ignore_for_file: deprecated_member_use

//                 // Create Account & Forgot Password
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => RegisterScreen(),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             'Create Account',
//                             style: TextStyle(
//                               fontSize: isSmallScreen ? 12 : 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () => openWhatsApp("+919888195353"),
//                               child: Column(
//                                 children: [
//                                   Icon(
//                                     FontAwesomeIcons.squareWhatsapp,
//                                     color: Colors.green,
//                                     size: isSmallScreen ? 30 : 40,
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     '+919888195353',
//                                     style: TextStyle(
//                                       fontSize: isSmallScreen ? 12 : 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () => openWhatsApp("+919888195353"),
//                           child: Text(
//                             'Forgot Password?',
//                             style: TextStyle(
//                               fontSize: isSmallScreen ? 12 : 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () => makePhoneCall("+919888395353"),
//                               child: Column(
//                                 children: [
//                                   Icon(
//                                     FontAwesomeIcons.whatsapp,
//                                     color: Colors.black,
//                                     size: isSmallScreen ? 30 : 40,
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     '+919888395353',
//                                     style: TextStyle(
//                                       fontSize: isSmallScreen ? 12 : 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/widgets/always_phone_prefix.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:dmboss/widgets/exit_dialog.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();

  int step =
      1; // 1 = Mobile only, 2 = Existing User (Password), 3 = New User (Name + Password)
  bool isExistingUser = false;

  void handleContinue() {
    if (_globalKey.currentState!.validate()) {
      if (step == 1) {
        // Mock check: if mobile ends with 5 → existing user
        if (mobileController.text.endsWith("5")) {
          isExistingUser = true;
          step = 2;
        } else {
          isExistingUser = false;
          step = 3;
        }
      } else if (step == 2) {
        // Login success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppNavigationBar()),
        );
      } else if (step == 3) {
        // Register and auto login success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppNavigationBar()),
        );
      }
      setState(() {});
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
        return false; // prevent default back
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                      borderRadius: BorderRadius.circular(screenHeight * 0.05),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      child: Image.asset('assets/images/dmbossLogo.png'),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),

                  // Step 1: Phone field (always shown)
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
                      if (value.length < 13 || value.length > 13) {
                        return "Enter valid Mobile number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Step 2: Existing user → Password
                  if (step == 2) ...[
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
                        if (!passwordRegExp.hasMatch(value)) {
                          return "Enter valid Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],

                  // Step 3: New user → Name + Password
                  if (step == 3) ...[
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
                        if (!passwordRegExp.hasMatch(value)) {
                          return "Enter valid Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.025),
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
                        if (!passwordRegExp.hasMatch(value)) {
                          return "Enter valid Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],

                  // Continue Button
                  OrangeButton(text: 'Continue', onPressed: handleContinue),
                  SizedBox(height: screenHeight * 0.03),

                  // Create Account & Forgot Password section
                  if (step == 1 ||
                      step == 2) // hide this when inside progressive flow
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => openWhatsApp("+919888195353"),
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
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => openWhatsApp("+919888195353"),
                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.squareWhatsapp,
                                    color: Colors.green,
                                    size: isSmallScreen ? 30 : 40,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '+919888195353',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => makePhoneCall("+919888395353"),
                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.black,
                                    size: isSmallScreen ? 30 : 40,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '+919888395353',
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
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
