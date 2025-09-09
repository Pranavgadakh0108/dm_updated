import 'package:dmboss/provider/transaction_history_provider.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Transaction {
  final String dateTime;
  final int amount;
  final String narration;

  Transaction({
    required this.dateTime,
    required this.amount,
    required this.narration,
  });
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactionHistory();
    });
  }

  Future<void> _loadTransactionHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final getTransactionHistoryProvider =
          Provider.of<GetTransactionHistoryProvider>(context, listen: false);
      await getTransactionHistoryProvider.getTransactionHistoryFunc(context);
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load transaction history. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppNavigationBar()),
            );
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     onPressed: _retryLoading,
        //     tooltip: 'Refresh',
        //   ),
        // ],
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_errorMessage != null) {
      return _buildErrorState(_errorMessage!);
    }

    return Consumer<GetTransactionHistoryProvider>(
      builder: (context, provider, _) {
        // Show empty state if no transactions
        if (provider.transactionHistoryModel == null ||
            provider.transactionHistoryModel!.transactions.isEmpty) {
          return _buildEmptyState();
        }

        // Show data state
        return _buildDataState(provider);
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          SizedBox(height: 16),
          Text(
            'Loading transaction history...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _retryLoading,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No transactions found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your transaction history will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _retryLoading,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildDataState(GetTransactionHistoryProvider provider) {
    return RefreshIndicator(
      onRefresh: _loadTransactionHistory,
      color: Colors.orange,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: ListView.builder(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          itemCount: provider.transactionHistoryModel!.transactions.length,
          itemBuilder: (context, index) {
            final transaction =
                provider.transactionHistoryModel!.transactions[index];
            print(transaction.type?.name.toString());
            print("transaction mrket :${transaction.market}");
            print("transaction gametype :${transaction.gameType}");
            final isDebit = transaction.amount < 0;
            final amountColor =
                isDebit ||
                    transaction.narration!.toLowerCase().contains('bet') ||
                    transaction.narration!.toLowerCase().contains('withdraw')
                ? Colors.red
                : Colors.green;
            final amountPrefix =
                isDebit ||
                    transaction.narration!.toLowerCase().contains('bet') ||
                    transaction.narration!.toLowerCase().contains('withdraw')
                ? '-'
                : '+';

            return Card(
              color: Colors.white,
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.grey, width: 0.2),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat(
                            'dd/MM/yyy',
                          ).format(transaction.createdAt ?? DateTime.now()),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          transaction.time ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Amount and Narration
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amount Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Amount",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$amountPrefix₹${transaction.amount.abs().toString()}',
                              style: TextStyle(
                                color: amountColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 24),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction.narration!.toLowerCase().contains(
                                      'deposit',
                                    )
                                    ? "Deposit Successfully"
                                    : transaction.narration ?? "No description",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // SizedBox(width: 10,),
                      ],
                    ),

                    // Transaction Type Badge
                    if (transaction.narration != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getTransactionTypeColor(
                              transaction.narration!,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getTransactionType(transaction.narration!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Color _getTransactionTypeColor(String narration) {
    if (narration.toLowerCase().contains('won') ||
        narration.toLowerCase().contains('deposit')) {
      return Colors.green;
    } else if (narration.toLowerCase().contains('withdraw') ||
        narration.toLowerCase().contains('deduct')) {
      return Colors.red;
    } else if (narration.toLowerCase().contains('referral') ||
        narration.toLowerCase().contains('bonus')) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  String _getTransactionType(String narration) {
    if (narration.toLowerCase().contains('won')) {
      return 'WINNING';
    } else if (narration.toLowerCase().contains('deposit')) {
      return 'DEPOSIT';
    } else if (narration.toLowerCase().contains('withdraw')) {
      return 'WITHDRAWAL';
    } else if (narration.toLowerCase().contains('bet')) {
      return 'BET PLACED';
    } else if (narration.toLowerCase().contains('bonus')) {
      return 'BONUS';
    } else if (narration.toLowerCase().contains('deduct')) {
      return 'DEDUCTION';
    }
    return 'TRANSACTION';
  }
}
