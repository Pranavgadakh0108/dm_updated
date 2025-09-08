import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BulkSpBetSummaryDialog extends StatefulWidget {
  final String title;
  final String date;
  final List<Map<String, String>> bids;
  final int totalBids;
  final int totalBidAmount;
  final VoidCallback onConfirm;

  const BulkSpBetSummaryDialog({
    super.key,
    required this.title,
    required this.date,
    required this.bids,
    required this.totalBids,
    required this.totalBidAmount,
    required this.onConfirm,
  });

  @override
  State<BulkSpBetSummaryDialog> createState() => _BulkSpBetSummaryDialogState();
}

class _BulkSpBetSummaryDialogState extends State<BulkSpBetSummaryDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProfileProvider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );
      userProfileProvider.fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, child) {
        final walletBalance = provider.userProfile?.user.wallet ?? 0;
        final bool hasSufficientBalance = widget.totalBidAmount <= walletBalance;
        
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "${widget.title}  -  ${widget.date}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Digit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Amount",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: widget.bids.length,
                    itemBuilder: (context, index) {
                      final bid = widget.bids[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(child: Text(bid['digit'] ?? 'N/A')),
                            Expanded(child: Text('₹ ${bid['amount'] ?? 'N/A'}')),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Bids: ${widget.totalBids}"),
                    Text("Total Amount: ₹${widget.totalBidAmount}"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Wallet Balance: ₹${walletBalance.toString()}"),
                    if (!hasSufficientBalance)
                      const Text(
                        "Insufficient balance!",
                        style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "*Note: Bid once played cannot be cancelled*",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasSufficientBalance ? Colors.orange : Colors.grey,
                        foregroundColor: hasSufficientBalance ? Colors.white : Colors.black54,
                      ),
                      onPressed: hasSufficientBalance ? () {
                        widget.onConfirm();
                      } : null,
                      child: const Text("Submit Bet"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}