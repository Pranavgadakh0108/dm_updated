// ignore_for_file: deprecated_member_use

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/get_bet_history_provider.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bid {
  final String date;
  final String market;
  final String openStatus;
  final int bet;
  final int coin;
  final String status;

  Bid({
    required this.date,
    required this.market,
    required this.openStatus,
    required this.bet,
    required this.coin,
    required this.status,
  });
}

class BidHistoryScreen extends StatefulWidget {
  const BidHistoryScreen({super.key});

  @override
  State<BidHistoryScreen> createState() => _BidHistoryScreenState();
}

class _BidHistoryScreenState extends State<BidHistoryScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBetHistory();
    });
  }

  Future<void> _loadBetHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final provider = Provider.of<GetBetHistoryProvider>(
        context,
        listen: false,
      );
      await provider.getBetHistoryProvider(context);
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load bid history. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadBetHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: const Text(
          "Bid History",
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

    return Consumer<GetBetHistoryProvider>(
      builder: (context, provider, _) {
        // Show empty state if no bids
        if (provider.gamesList == null || provider.gamesList!.bets.isEmpty) {
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
            'Loading bid history...',
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
          const Icon(Icons.sports_score_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No bids found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your bid history will appear here',
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

  Widget _buildDataState(GetBetHistoryProvider provider) {
    return RefreshIndicator(
      onRefresh: _loadBetHistory,
      color: Colors.orange,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: ListView.builder(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          itemCount: provider.gamesList!.bets.length,
          itemBuilder: (context, index) {
            final bid = provider.gamesList!.bets[index];
            final isWon = bid.status.contains("won") == true;
            final isLost = bid.status.contains("luck") == true;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: BorderSide(
                //   color: isWon
                //       ? Colors.green.withOpacity(0.3)
                //       : isLost
                //       ? Colors.red.withOpacity(0.3)
                //       : Colors.blue.withOpacity(0.3),
                //   width: 1.2,
                // ),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row with date and status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          bid.date,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 6,
                        //     vertical: 3,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: _getStatusColor(bid.status),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: Text(
                        //     _getStatusText(bid.status),
                        //     style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 9,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCompactDetail("Market", bid.market),
                              const SizedBox(height: 2),
                              _buildCompactDetail("Session", bid.session),
                              const SizedBox(height: 2),
                              _buildCompactDetail(
                                "Game Type",
                                bid.gameType,
                                isHighlighted: true,
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  bid.number,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Coins",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isWon
                                          ? Colors.green.withOpacity(0.1)
                                          : isLost
                                          ? Colors.red.withOpacity(0.1)
                                          : Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      bid.amount.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isWon
                                            ? Colors.green
                                            : isLost
                                            ? Colors.red
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (bid.status.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(bid.status).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getStatusIcon(bid.status),
                              size: 12,
                              color: _getStatusColor(bid.status),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                bid.status,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _getStatusColor(bid.status),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );

            // Helper method for compact detail rows
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains("won") || status.contains("🎉")) {
      return Colors.green;
    } else if (status.contains("luck") || status.contains("lost")) {
      return Colors.red;
    } else if (status.contains("Pending") || status.contains("Processing")) {
      return Colors.blue;
    }
    return Colors.grey[600]!;
  }

  Widget _buildCompactDetail(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 12,
              color: isHighlighted ? Colors.blue : Colors.black,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get status icon
  IconData _getStatusIcon(String status) {
    if (status.toLowerCase().contains('win') ||
        status.toLowerCase().contains('success')) {
      return Icons.check_circle;
    } else if (status.toLowerCase().contains('loss') ||
        status.toLowerCase().contains('fail')) {
      return Icons.cancel;
    } else {
      return Icons.access_time;
    }
  }
}
