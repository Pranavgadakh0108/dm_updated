import 'package:dmboss/util/share_refferal.dart';
import 'package:flutter/material.dart';

class ReferAndEarnPage extends StatelessWidget {
  const ReferAndEarnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Share App",
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/images/referImg.jpg",
                  height: 280,
                  width: 380,
                ),
              ),
              const SizedBox(height: 30),
              // const Text(
              //   "Your referral code",
              //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              // ),
              // const SizedBox(height: 15),
              // Container(
              //   //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   padding: EdgeInsets.symmetric(
              //     horizontal: MediaQuery.of(context).size.width * 0.05,
              //     vertical: MediaQuery.of(context).size.height * 0.01,
              //   ),
              //   decoration: BoxDecoration(
              //     color: Colors.orange,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: const Text(
              //     "D7SjS",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text(
                "Click On The Below Button and Share App",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  shareText();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Share",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
