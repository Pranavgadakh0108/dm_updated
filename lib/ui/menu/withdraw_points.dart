// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:dmboss/widgets/term_condition_popup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawPoints extends StatefulWidget {
  const WithdrawPoints({super.key});

  @override
  State<WithdrawPoints> createState() => _WithdrawPointsState();
}

class _WithdrawPointsState extends State<WithdrawPoints> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController withdrawCoinsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showTermsPopup(context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                'Back A/C Details',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(height: 20),
              CustomProfileTextFormField(
                controller: TextEditingController(),
                hintText: "A/C Holder Name",
              ),
              SizedBox(height: 20),
              CustomProfileTextFormField(
                controller: TextEditingController(),
                hintText: "A/C Number",
              ),
              SizedBox(height: 20),
              CustomProfileTextFormField(
                controller: TextEditingController(),
                hintText: "IFSC",
              ),
              // SizedBox(height: 20),
              // OrangeButton(text: "Submit", onPressed: () {}),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => openWhatsApp("+919888195353"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.squareWhatsapp,
                      color: Colors.green,
                      size: 35,
                    ),
                    SizedBox(width: 10),
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
              SizedBox(height: 20),
              Text(
                'Withdraw Fund Request Below',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(height: 20),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    CustomProfileTextFormField(
                      controller: withdrawCoinsController,
                      hintText: "Enter Points",
                      icon: FontAwesomeIcons.circleDollarToSlot,
                      onChanged: (value) {
                        setState(() {
                          withdrawCoinsController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter valid Coins";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    OrangeButton(text: "Withdraw", onPressed: () {
                      if(_globalKey.currentState!.validate()){

                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
