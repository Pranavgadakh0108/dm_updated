// ignore_for_file: deprecated_member_use

import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/util/get_time_in_12_hours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showTermsPopup(
  BuildContext context,
  GamesSettingsProvider gameSettingsProviders,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
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
              contentPadding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.04,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Terms & Condition",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Minimum Withdrawal is ${provider.gameSettings?.data.minWithdraw} Rs. Maximum Withdraw Unlimited Per Day.\n"
                      "Process Time Minimum 1 Hour Maximum 72 Hours. Depending On Bank Server.\n"
                      "Withdraw Request Timing Is ${convertTimeStringTo12HourFormat(provider.gameSettings?.data.withdrawOpenTime ?? "")} To ${convertTimeStringTo12HourFormat(provider.gameSettings?.data.withdrawCloseTime ?? "")}.\n"
                      "Withdraw Is Available On All Days Of Week.\n",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      "Note: Please Confirm That Bank Details You Have Entered Are Correct, If You Entered Wrong Bank Details Is Not Our Responsibility. After submitting the withdraw request, if there is no valis balance in your wallet, then the request will be automatically declined.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
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
