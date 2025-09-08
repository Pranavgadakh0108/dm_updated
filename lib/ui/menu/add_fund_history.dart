import 'package:dmboss/provider/get_fund_history_provider.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFundHistoryScreen extends StatefulWidget {
  const AddFundHistoryScreen({super.key});

  @override
  State<AddFundHistoryScreen> createState() => _AddFundHistoryScreenState();
}

class _AddFundHistoryScreenState extends State<AddFundHistoryScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFundHistory();
    });
  }

  Future<void> _loadFundHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final provider = Provider.of<GetFundHistoryProvider>(
        context,
        listen: false,
      );
      await provider.getFundHistory(context);
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load fund history. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadFundHistory();
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
          "Fund History",
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
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.001),
        child: Consumer<GetFundHistoryProvider>(
          builder: (context, provider, _) {
            // Show loading state
            if (_isLoading) {
              return _buildLoadingState();
            }

            // Show error state
            if (_errorMessage != null) {
              return _buildErrorState(_errorMessage!);
            }

            // Show empty state
            if (provider.gamesList == null ||
                provider.gamesList!.deposits.isEmpty) {
              return _buildEmptyState();
            }

            // Show data state
            return _buildDataState(provider);
          },
        ),
      ),
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
            'Loading fund history...',
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
          const Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No fund history found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your fund transactions will appear here',
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

  Widget _buildDataState(GetFundHistoryProvider provider) {
    return RefreshIndicator(
      onRefresh: _loadFundHistory,
      color: Colors.orange,
      child: ListView.builder(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        itemCount: provider.gamesList?.deposits.length ?? 0,
        itemBuilder: (context, index) {
          final deposit = provider.gamesList!.deposits[index];

          // Format date properly
          final formattedDate = _formatDate(deposit.date);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 3,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Points row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Points",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          deposit.amount.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Text(
                  "Method: ${deposit.method}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  _getStatusMessage(deposit.status ?? 0),
                  style: TextStyle(
                    color: _getStatusColor(deposit.status ?? 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 10.3,
                  ),
                ),
                deposit.rejectionNote != ""
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            deposit.status,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _getStatusColor(deposit.status ?? 0),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          deposit.rejectionNote ?? "",
                          style: TextStyle(
                            color: _getStatusColor(deposit.status ?? 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 10.3,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 1: // Approved
        return Colors.green;
      case 2: // Rejected
        return Colors.red;
      default: // Pending (0 or any other)
        return Colors.orange;
    }
  }

  String _getStatusMessage(int status) {
    switch (status) {
      case 1:
        return "✓ Approved - Fund Added Successfully!";
      case 2:
        return "✗ Rejected - Failed to Add Funds!";
      default:
        return "⏳ Pending - Waiting for approval...";
    }
  }
}
