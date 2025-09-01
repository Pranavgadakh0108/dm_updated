import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';

class AddBankDetails extends StatefulWidget {
  const AddBankDetails({super.key});

  @override
  State<AddBankDetails> createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController accountNumController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Add Bank Details",
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
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  'Add Back A/C Details',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 20),
                CustomProfileTextFormField(
                  controller: holderNameController,
                  hintText: "A/C Holder Name",
                  onChanged: (value) {
                    setState(() {
                      holderNameController.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠️ Enter the valid Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomProfileTextFormField(
                  controller: accountNumController,
                  hintText: "A/C Number",
                  onChanged: (value) {
                    setState(() {
                      accountNumController.text;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠️ Enter the Valid A/C Number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomProfileTextFormField(
                  controller: ifscController,
                  hintText: "IFSC",
                  onChanged: (value) {
                    setState(() {
                      ifscController.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠️ Enter the valid IFSC number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                OrangeButton(text: "Submit", onPressed: () {
                  if(_globalKey.currentState!.validate()){

                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
