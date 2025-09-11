import 'package:dmboss/model/add_bank_details_model.dart';
import 'package:dmboss/model/get_bank_details_model.dart';
import 'package:dmboss/provider/add_bank_details_provider.dart';
import 'package:dmboss/provider/get_bank_details_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? user_Id;

  bool _isDataLoaded = false;
  bool _hasExistingData = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBankDetails();
    });
  }

  Future<void> getUserId() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        user_Id = sharedPreferences.getString('user_id');
        print('User ID: $user_Id');
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load user data';
      });
    }
  }

  void _loadBankDetails() async {
    await getUserId();

    final getBankDetailsProvider = Provider.of<GetBankDetailsProvider>(
      context,
      listen: false,
    );

    final String? userId = user_Id;
    getBankDetailsProvider.getBankDetails(context, userId).then((_) {
      if (getBankDetailsProvider.gamesList != null &&
          getBankDetailsProvider.gamesList!.banks.isNotEmpty) {
        _populateFormWithExistingData(getBankDetailsProvider.gamesList!);
        setState(() {
          _hasExistingData = true;
        });
      }
      setState(() {
        _isDataLoaded = true;
      });
    });
  }

  void _populateFormWithExistingData(GetBankDetailsModel bankDetails) {
    if (bankDetails.banks.isNotEmpty) {
      final bank = bankDetails.banks[0];
      holderNameController.text = bank.accountHolderName ?? '';
      accountNumController.text = bank.accountNumber ?? '';
      confirmAccountNumController.text = bank.accountNumber ?? '';
      bankNameController.text = bank.bankName ?? '';
      ifscController.text = bank.ifscCode ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Consumer2<AddBankDetailsProvider, GetBankDetailsProvider>(
            builder: (context, addProvider, getProvider, _) {
              if (!_isDataLoaded && getProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Form(
                key: _globalKey,
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      _hasExistingData
                          ? 'Update Bank A/C Details'
                          : 'Add Bank A/C Details',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextFormField(
                      controller: holderNameController,
                      hintText: "A/C Holder Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the valid Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextFormField(
                      controller: accountNumController,
                      hintText: "A/C Number",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the Valid A/C Number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextFormField(
                      controller: confirmAccountNumController,
                      hintText: "Confirm A/C Number",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the Valid A/C Number";
                        } else if (value != accountNumController.text) {
                          return "⚠️ Account numbers don't match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextFormField(
                      controller: ifscController,
                      hintText: "IFSC",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the valid IFSC number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextFormField(
                      controller: bankNameController,
                      hintText: "Bank Name",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "⚠️ Enter the valid Bank Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Note: Please Confirm That Bank Details You Have Entered Are Correct, If You Entered Wrong Bank Details Is Not Our Responsibility.",
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    OrangeButton(
                      text: _hasExistingData ? "Update" : "Submit",
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
                          addProvider.addBankDetails(context, addbankDetails);
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
