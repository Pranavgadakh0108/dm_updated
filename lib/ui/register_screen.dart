// import 'package:dmboss/widgets/always_phone_prefix.dart';
// import 'package:dmboss/widgets/custom_text_field.dart';
// import 'package:dmboss/widgets/make_call.dart';
// import 'package:dmboss/widgets/make_whatsapp_chat.dart';
// import 'package:dmboss/widgets/orange_button.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             //padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.06,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               //crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Header
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hurrey,',
//                       style: TextStyle(
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 15),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Let's Finish Up!",
//                       style: TextStyle(
//                         fontSize: 21,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 90),

//                 // Phone Number Field
//                 CustomPhoneField(controller: TextEditingController()),
//                 const SizedBox(height: 20),

//                 CustomTextField(
//                   hintText: 'Enter Name',
//                   icon: Icons.person,
//                   keyboardType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 20),

//                 // Password Field
//                 // Password field
//                 CustomTextField(
//                   hintText: 'Enter Password',
//                   icon: Icons.lock,
//                   obscureText: true,
//                   keyboardType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 20),

//                 // Password field
//                 CustomTextField(
//                   hintText: 'Enter Confirm Password',
//                   icon: Icons.lock,
//                   obscureText: true,
//                   keyboardType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 20),

//                 CustomTextField(
//                   hintText: 'Enter Referral Code (Optional)',
//                   icon: Icons.add_comment_rounded,
//                   keyboardType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 40),

//                 // Register Button
//                 OrangeButton(text: "Register", onPressed: () {}),
//                 const SizedBox(height: 20),

//                 // Footer Links
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'Already a member? Sign In',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Phone Numbers at bottom
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () => openWhatsApp("+919888195353"),
//                       child: Column(
//                         children: [
//                           Icon(
//                             FontAwesomeIcons.squareWhatsapp,
//                             color: Colors.green,
//                             size: 40,
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             '+919888195353',
//                             style: TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 50),
//                     GestureDetector(
//                       onTap: () => makePhoneCall("+919888395353"),
//                       child: Column(
//                         children: [
//                           Icon(FontAwesomeIcons.whatsapp, size: 40),
//                           SizedBox(height: 5),
//                           Text(
//                             '+919888395353',
//                             style: TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
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

import 'package:dmboss/widgets/always_phone_prefix.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600; // Check for small screens

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hurrey,',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Let's Finish Up!",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 21,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.08),

                // Phone Number Field
                CustomPhoneField(controller: TextEditingController()),
                SizedBox(height: screenHeight * 0.02),

                CustomTextField(
                  hintText: 'Enter Name',
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Password Field
                CustomTextField(
                  hintText: 'Enter Password',
                  icon: Icons.lock,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Confirm Password field
                CustomTextField(
                  hintText: 'Enter Confirm Password',
                  icon: Icons.lock,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.02),

                CustomTextField(
                  hintText: 'Enter Referral Code (Optional)',
                  icon: Icons.add_comment_rounded,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Register Button
                OrangeButton(text: "Register", onPressed: () {}),
                SizedBox(height: screenHeight * 0.02),

                // Footer Links
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already a member? Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Phone Numbers at bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(height: 5),
                          Text(
                            '+919888195353',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.12),
                    GestureDetector(
                      onTap: () => makePhoneCall("+919888395353"),
                      child: Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.whatsapp,
                            size: isSmallScreen ? 30 : 40,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '+919888395353',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}