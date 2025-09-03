import 'package:dmboss/provider/withdraw_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WithdrawPendingRequests extends StatefulWidget {
  const WithdrawPendingRequests({super.key});

  @override
  State<WithdrawPendingRequests> createState() =>
      _WithdrawPendingRequestsState();
}

class _WithdrawPendingRequestsState extends State<WithdrawPendingRequests> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWithdrawHistory();
  }

  Future<void> _loadWithdrawHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final provider = Provider.of<GetWithdrawHistoryProvider>(
        context,
        listen: false,
      );
      await provider.withdrawHistory(context);
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load withdrawal requests. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadWithdrawHistory();
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0: // Pending
        return Colors.orange;
      case 1: // Approved
        return Colors.green;
      case 2: // Rejected
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return "PENDING";
      case 1:
        return "APPROVED";
      case 2:
        return "REJECTED";
      default:
        return "UNKNOWN";
    }
  }

  IconData _getStatusIcon(int status) {
    switch (status) {
      case 0:
        return Icons.access_time;
      case 1:
        return Icons.check_circle;
      case 2:
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Withdraw Requests",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _retryLoading,
            tooltip: 'Refresh',
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

    return Consumer<GetWithdrawHistoryProvider>(
      builder: (context, provider, _) {
        // Show empty state if no withdrawal requests
        if (provider.withdrawHistoryModel == null ||
            provider.withdrawHistoryModel!.data.isEmpty) {
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
            'Loading withdrawal requests...',
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
            'No withdrawal requests',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your withdrawal requests will appear here',
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

  Widget _buildDataState(GetWithdrawHistoryProvider provider) {
    return RefreshIndicator(
      onRefresh: _loadWithdrawHistory,
      color: Colors.orange,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: ListView.builder(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          itemCount: provider.withdrawHistoryModel!.data.length,
          itemBuilder: (context, index) {
            final withdrawal = provider.withdrawHistoryModel!.data[index];
            final statusColor = _getStatusColor(withdrawal.status ?? 0);
            final statusText = _getStatusText(withdrawal.status ?? 0);
            final statusIcon = _getStatusIcon(withdrawal.status ?? 0);

            return Card(
              color: Colors.white,
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: statusColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Date and Status Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat(
                            'yyyy-MM-dd • HH:mm',
                          ).format(withdrawal.createdAt ?? DateTime.now()),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(statusIcon, size: 14, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                statusText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Amount and Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Amount Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "AMOUNT",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "₹${withdrawal.amount.toString()}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),

                        // Payment Method Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "PAYMENT METHOD",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              withdrawal.mode?.toUpperCase() ?? "N/A",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Status Description
                    const SizedBox(height: 8),
                    Text(
                      _getStatusDescription(withdrawal.status ?? 0),
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
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

  String _getStatusDescription(int status) {
    switch (status) {
      case 0:
        return "Your withdrawal request is being processed. Please wait for approval.";
      case 1:
        return "Your withdrawal has been approved successfully!";
      case 2:
        return "Your withdrawal request has been rejected. Please contact support for details.";
      default:
        return "Unknown status. Please contact support.";
    }
  }
}
