// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/widgets/custom_profile_text_field.dart';
// import 'package:dmboss/widgets/orange_button.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   final String username;
//   final String phoneNumber;
//   const ProfilePage({super.key, required this.username, required this.phoneNumber});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {

//   final TextEditingController nameController = TextEditingController();

//   final TextEditingController phoneController = TextEditingController();

//   final TextEditingController newPasswordController = TextEditingController();

//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   final GlobalKey<FormState> _globalKey = GlobalKey();
//   // final GlobalKey<FormState> _globalKey1 = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.username;
//     phoneController.text = widget.phoneNumber;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         elevation: 3,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.06,
//           vertical: MediaQuery.of(context).size.height * 0.025,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Notification toggle
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 100),
//                 const Text(
//                   "Enable / Disable Notifications",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Switch(
//                   value: false,
//                   onChanged: (val) {},
//                   inactiveTrackColor: Colors.grey.shade300,
//                   inactiveThumbColor: Colors.white,
//                   activeColor: Colors.orange,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),

//             // Manage profile
//             Form(
//               key: _globalKey,
//               child: Column(
//                 children: [
//                   const Text(
//                     "Manage profile",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),

//                   CustomProfileTextFormField(
//                     controller: nameController,
//                     hintText: "Name",
//                     icon: Icons.person,
//                     onChanged: (value) {
//                       setState(() {
//                         nameController.text = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter the Name first...";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   CustomProfileTextFormField(
//                     controller: phoneController,
//                     hintText: "Phone",
//                     icon: Icons.mobile_friendly,
//                     readOnly: true,
//                   ),
//                   const SizedBox(height: 30),
//                   const Text(
//                     "Change Password",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),

//                   CustomProfileTextFormField(
//                     controller: newPasswordController,
//                     hintText: "New Password",
//                     icon: Icons.lock,
//                     obscureText: true,
//                     onChanged: (value) {
//                       setState(() {
//                         newPasswordController.text = value;
//                       });
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
//                   const SizedBox(height: 10),
//                   CustomProfileTextFormField(
//                     controller: confirmPasswordController,
//                     hintText: "Confirm Password",
//                     icon: Icons.lock,
//                     obscureText: true,
//                     onChanged: (value) {
//                       setState(() {
//                         confirmPasswordController.text = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null ||
//                           value.isEmpty ||
//                           value != newPasswordController.text) {
//                         return "Enter the correct Password";
//                       }
//                       if (!passwordRegExp.hasMatch(value)) {
//                         return "Enter valid Password";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 30),

//                   OrangeButton(
//                     text: "Update Profile",
//                     onPressed: () {
//                       if (_globalKey.currentState!.validate()) {}
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 40),

//             // Change Password
//             // Form(
//             //   key: _globalKey1,
//             //   child: Column(
//             //     children: [
//             //       const Text(
//             //         "Change Password",
//             //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             //       ),
//             //       const SizedBox(height: 10),

//             //       CustomProfileTextFormField(
//             //         controller: newPasswordController,
//             //         hintText: "New Password",
//             //         icon: Icons.lock,
//             //         obscureText: true,
//             //         onChanged: (value) {
//             //           setState(() {
//             //             newPasswordController.text = value;
//             //           });
//             //         },
//             //         validator: (value) {
//             //           if (value == null || value.isEmpty) {
//             //             return "Enter the Password first...";
//             //           }
//             //           if (!passwordRegExp.hasMatch(value)) {
//             //             return "Enter valid Password";
//             //           }
//             //           return null;
//             //         },
//             //       ),
//             //       const SizedBox(height: 10),
//             //       CustomProfileTextFormField(
//             //         controller: confirmPasswordController,
//             //         hintText: "Confirm Password",
//             //         icon: Icons.lock,
//             //         obscureText: true,
//             //         onChanged: (value) {
//             //           setState(() {
//             //             confirmPasswordController.text = value;
//             //           });
//             //         },
//             //         validator: (value) {
//             //           if (value == null ||
//             //               value.isEmpty ||
//             //               value != newPasswordController.text) {
//             //             return "Enter the correct Password";
//             //           }
//             //           if (!passwordRegExp.hasMatch(value)) {
//             //             return "Enter valid Password";
//             //           }
//             //           return null;
//             //         },
//             //       ),
//             //       const SizedBox(height: 30),

//             //       OrangeButton(text: "Update Password", onPressed: () {
//             //         if(_globalKey1.currentState!.validate()){

//             //         }
//             //       }),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/update_profile_model.dart';
// import 'package:dmboss/provider/update_user_provider.dart';
// import 'package:dmboss/widgets/custom_profile_text_field.dart';
// import 'package:dmboss/widgets/orange_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfilePage extends StatefulWidget {
//   final String username;
//   final String phoneNumber;
//   const ProfilePage({super.key, required this.username, required this.phoneNumber});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   final GlobalKey<FormState> _globalKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.username;
//     phoneController.text = widget.phoneNumber;

//     // Initialize provider with current user data
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<ProfileUpdateProvider>(context, listen: false);
//       // Create a mock user object with current data
//       final currentUser = User(
//         id: '',
//         mobile: widget.phoneNumber,
//         name: widget.username,
//         email: '',
//         wallet: 0,
//         session: '',
//         code: '',
//         createdAt: DateTime.now(),
//         active: 1,
//         verify: '',
//         transferPointsStatus: '',
//         paytm: '',
//         pin: null,
//         refcode: null,
//         refId: null,
//         ipAddress: null,
//         createdA: DateTime.now(),
//         updatedAt: DateTime.now(),
//         v: 0,
//       );
//       provider.setOriginalUser(currentUser);
//     });
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _updateProfile() async {
//     if (_globalKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileUpdateProvider>(context, listen: false);

//       // Update provider with current field values
//       provider.setName(nameController.text);
//       provider.setNewPassword(newPasswordController.text);
//       provider.setConfirmPassword(confirmPasswordController.text);

//       if (provider.validateForm()) {
//         await provider.updateProfile(context);

//         // If update was successful, clear password fields
//         if (provider.successMessage != null && provider.errorMessage == null) {
//           newPasswordController.clear();
//           confirmPasswordController.clear();
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileUpdateProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.orange,
//             elevation: 3,
//             title: const Text(
//               "My Profile",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           body: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.06,
//               vertical: MediaQuery.of(context).size.height * 0.025,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Notification toggle
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 100),
//                     const Text(
//                       "Enable / Disable Notifications",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Switch(
//                       value: false,
//                       onChanged: (val) {},
//                       inactiveTrackColor: Colors.grey.shade300,
//                       inactiveThumbColor: Colors.white,
//                       activeColor: Colors.orange,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 // Show error/success messages
//                 if (provider.errorMessage != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       provider.errorMessage!,
//                       style: TextStyle(color: Colors.red, fontSize: 14),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 if (provider.successMessage != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       provider.successMessage!,
//                       style: TextStyle(color: Colors.green, fontSize: 14),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),

//                 // Manage profile
//                 Form(
//                   key: _globalKey,
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Manage profile",
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 10),

//                       CustomProfileTextFormField(
//                         controller: nameController,
//                         hintText: "Name",
//                         icon: Icons.person,
//                         onChanged: (value) {
//                           setState(() {
//                             nameController.text = value;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Enter the Name first...";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       CustomProfileTextFormField(
//                         controller: phoneController,
//                         hintText: "Phone",
//                         icon: Icons.mobile_friendly,
//                         readOnly: true,
//                       ),
//                       const SizedBox(height: 30),
//                       const Text(
//                         "Change Password",
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 10),

//                       CustomProfileTextFormField(
//                         controller: newPasswordController,
//                         hintText: "New Password",
//                         icon: Icons.lock,
//                         obscureText: true,
//                         onChanged: (value) {
//                           setState(() {
//                             newPasswordController.text = value;
//                           });
//                         },
//                         validator: (value) {
//                           // Only validate if password field is not empty
//                           if (value != null && value.isNotEmpty) {
//                             if (!passwordRegExp.hasMatch(value)) {
//                               return "Enter valid Password";
//                             }
//                             if (value.length < 8) {
//                               return "Password must be at least 8 characters";
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       CustomProfileTextFormField(
//                         controller: confirmPasswordController,
//                         hintText: "Confirm Password",
//                         icon: Icons.lock,
//                         obscureText: true,
//                         onChanged: (value) {
//                           setState(() {
//                             confirmPasswordController.text = value;
//                           });
//                         },
//                         validator: (value) {
//                           // Only validate if new password is provided
//                           if (newPasswordController.text.isNotEmpty) {
//                             if (value == null || value.isEmpty) {
//                               return "Please confirm your password";
//                             }
//                             if (value != newPasswordController.text) {
//                               return "Passwords do not match";
//                             }
//                             if (!passwordRegExp.hasMatch(value)) {
//                               return "Enter valid Password";
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 30),

//                       provider.isLoading
//                           ? CircularProgressIndicator()
//                           : OrangeButton(
//                               text: "Update Profile",
//                               onPressed: _updateProfile,
//                             ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:dmboss/model/update_profile_model.dart';
import 'package:dmboss/provider/update_user_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String phoneNumber;
  const ProfilePage({
    super.key,
    required this.username,
    required this.phoneNumber,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Initialize provider with current user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProfileUpdateProvider>(
        context,
        listen: false,
      );
      // Create a mock user object with current data
      final currentUser = User(
        id: '',
        mobile: widget.phoneNumber,
        name: widget.username,
        email: '',
        wallet: 0,
        session: '',
        code: '',
        createdAt: DateTime.now(),
        active: 1,
        verify: '',
        transferPointsStatus: '',
        paytm: '',
        pin: null,
        refcode: null,
        refId: null,
        ipAddress: null,
        createdA: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
      );
      provider.setOriginalUser(currentUser);

      // Set initial values in provider controllers
      provider.nameController.text = widget.username;
    });
  }

  void _updateProfile() async {
    if (_globalKey.currentState!.validate()) {
      final provider = Provider.of<ProfileUpdateProvider>(
        context,
        listen: false,
      );

      if (provider.validateForm()) {
        await provider.updateProfile(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileUpdateProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            elevation: 3,
            title: const Text(
              "My Profile",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
              vertical: MediaQuery.of(context).size.height * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Notification toggle
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      "Enable / Disable Notifications",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5),
                    Switch(
                      value: false,
                      onChanged: null,
                      inactiveTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.white,
                      activeColor: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Show error/success messages
                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (provider.successMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      provider.successMessage!,
                      style: const TextStyle(color: Colors.green, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Manage profile
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      const Text(
                        "Manage profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),

                      CustomProfileTextFormField(
                        controller: provider.nameController,
                        hintText: "Name",
                        icon: Icons.person,
                        onChanged: (value) {
                          // No need for setState, provider will handle it
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Name first...";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomProfileTextFormField(
                        controller: TextEditingController(
                          text: widget.phoneNumber,
                        ),
                        hintText: "Phone",
                        icon: Icons.mobile_friendly,
                        readOnly: true,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Change Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),

                      CustomProfileTextFormField(
                        controller: provider.newPasswordController,
                        hintText: "New Password",
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (value) {
                          // No need for setState
                        },
                        validator: (value) {
                          // Only validate if password field is not empty
                          if (value != null && value.isNotEmpty) {
                            // if (!passwordRegExp.hasMatch(value)) {
                            //   return "Enter valid Password";
                            // }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomProfileTextFormField(
                        controller: provider.confirmPasswordController,
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (value) {
                          // No need for setState
                        },
                        validator: (value) {
                          // Only validate if new password is provided
                          if (provider.newPasswordController.text.isNotEmpty) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != provider.newPasswordController.text) {
                              return "Passwords do not match";
                            }
                            // if (!passwordRegExp.hasMatch(value)) {
                            //   return "Enter valid Password";
                            // }
                            if (value.length < 6) {
                              return "Password required minimum 6";
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      provider.isLoading
                          ? const CircularProgressIndicator()
                          : OrangeButton(
                              text: "Update Profile",
                              onPressed: _updateProfile,
                            ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
