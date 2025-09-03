import 'package:dmboss/model/add_bank_details_model.dart';
import 'package:dmboss/provider/add_bank_details_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBankDetailsPage extends StatefulWidget {
  const AddBankDetailsPage({super.key});

  @override
  State<AddBankDetailsPage> createState() => _AddBankDetailsPageState();
}

class _AddBankDetailsPageState extends State<AddBankDetailsPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController accountNumController = TextEditingController();
  final TextEditingController confirmAccountNumController =
      TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
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
          child: Consumer<AddBankDetailsProvider>(
            builder: (context, provider, _) {
              return Form(
                key: _globalKey,
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text(
                      'Add Back A/C Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
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
                      controller: confirmAccountNumController,
                      hintText: "Confirm A/C Number",
                      onChanged: (value) {
                        setState(() {
                          confirmAccountNumController.text;
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
                    CustomProfileTextFormField(
                      controller: bankNameController,
                      hintText: "Bank Name",
                      onChanged: (value) {
                        setState(() {
                          bankNameController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the valid Bank Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    OrangeButton(
                      text: "Submit",
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          final addbankDetails = AddBankDetails(
                            accountHolderName: holderNameController.text,
                            accountNumber: accountNumController.text,
                            confirmAccountNumber:
                                confirmAccountNumController.text,
                            ifscCode: ifscController.text,
                            bankName: bankNameController.text,
                          );
                          provider.addBankDetails(context, addbankDetails);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
