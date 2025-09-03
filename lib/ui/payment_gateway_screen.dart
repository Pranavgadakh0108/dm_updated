import 'package:dmboss/model/payment_gateway_model.dart';
import 'package:dmboss/provider/get_qr_code_provider.dart';
import 'package:dmboss/provider/payment_gateway_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({super.key});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PaymentGatewayProvider>(
        context,
        listen: false,
      );
      _amountController.text = provider.amount;

      final userProvider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );
      userProvider.fetchUserProfile();

      final qrProvider = Provider.of<GetQrCodeProvider>(context, listen: false);
      qrProvider.getQrCodeProvider(context);
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
          "Deposite Coins",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Consumer2<UserProfileProvider, GetQrCodeProvider>(
              builder: (context, provider, qrProvider, _) {
                _nameController.text = provider.userProfile?.user.name ?? "";
                _mobileController.text =
                    provider.userProfile?.user.mobile ?? "";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Balance : ${provider.userProfile?.user.wallet}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Add Your Payment Details!!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomProfileTextFormField(
                      controller: TextEditingController(
                        text: _nameController.text,
                      ),
                      hintText: "Name",
                      icon: Icons.person,
                      readOnly: true,
                    ),

                    SizedBox(height: 20),
                    CustomProfileTextFormField(
                      controller: TextEditingController(
                        text: _mobileController.text,
                      ),
                      hintText: "Phone",
                      icon: Icons.phone,
                      readOnly: true,
                    ),

                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Enter Amount",
                      keyboardType: TextInputType.number,
                      controller: _amountController,

                      onChanged: (value) {
                        setState(() {
                          _amountController.text = value;
                        });
                      },

                      validator: (value) {},
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          final paymentGatewayModel = PaymentGatewayIntegration(
                            name: _nameController.text,
                            phone: _mobileController.text,
                            amount: int.parse(_amountController.text),
                            redirectUrl:
                                "https://api.dmbossbusiness.com/after-pay",
                          );
                          setState(() {
                            final provider =
                                Provider.of<PaymentGatewayProvider>(
                                  context,
                                  listen: false,
                                );
                            provider.postPaymentGateway(
                              context,
                              paymentGatewayModel,
                            );
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
