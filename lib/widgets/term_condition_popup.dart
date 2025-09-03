// ignore_for_file: deprecated_member_use

import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showTermsPopup(
  BuildContext context,
  GamesSettingsProvider gameSettingsProviders,
) {
  showDialog(
    context: context,
    barrierDismissible: false, // Force user to click OK
    builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        gameSettingsProviders.getGameSettings(context);
      });

      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Consumer<GamesSettingsProvider>(
          builder: (context, provider, _) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
              // contentPadding: const EdgeInsets.all(16),
              contentPadding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.04,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 80,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Terms & Condition",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Minimum Withdrawal is ${provider.gameSettings?.data.minWithdraw} Rs. Maximum Withdraw Unlimited Per Day.\n\n"
                      "Process Time Minimum 1 Hour Maximum 72 Hours. Depending On Bank Server.\n\n"
                      "Withdraw Request Timing Is Morning 10:00 AM To Night 10:00 PM.\n\n"
                      "Withdraw Is Available On All Days Of Week.\n",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      "Note: Please Confirm That Bank Details You Have Entered Are Correct, If You Entered Wrong Bank Details Is Not Our Responsibility. After submitting the withdraw request, if there is no valid balance in your wallet, then the request will be automatically declined.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
