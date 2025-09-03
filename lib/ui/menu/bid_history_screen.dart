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
    _loadBetHistory();
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          itemCount: provider.gamesList!.bets.length,
          itemBuilder: (context, index) {
            final bid = provider.gamesList!.bets[index];
            final isWon = bid.status?.contains("won") == true;
            final isLost = bid.status?.contains("luck") == true;
            final isPending =
                bid.status?.contains("Pending") == true ||
                (bid.status != "🎉 You won!" &&
                    bid.status != "Better luck next time");

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isWon
                      ? Colors.green.withOpacity(0.3)
                      : isLost
                      ? Colors.red.withOpacity(0.3)
                      : Colors.blue.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.04,
                ),
                child: Column(
                  children: [
                    // Header Row with Date and Status Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bid.date ?? "No date",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(bid.status ?? ""),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getStatusText(bid.status ?? ""),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Main Content Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column - Market Details
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow("Market", bid.market ?? "N/A"),
                              const SizedBox(height: 4),
                              _buildDetailRow("Session", bid.session ?? "N/A"),
                              const SizedBox(height: 4),
                              _buildDetailRow(
                                "Game Type",
                                bid.gameType ?? "N/A",
                                isHighlighted: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Middle Column - Bet Number
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Bet Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bid.number ?? "N/A",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Right Column - Coins
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Coins",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bid.amount?.toString() ?? "0",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isWon
                                          ? Colors.green
                                          : isLost
                                          ? Colors.red
                                          : Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.monetization_on,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Status Message
                    if (bid.status != null && bid.status!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(bid.status!).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _getStatusColor(bid.status!),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          bid.status!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(bid.status!),
                          ),
                          textAlign: TextAlign.center,
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

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isHighlighted ? Colors.orange : Colors.black,
          ),
        ),
      ],
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
    return Colors.grey;
  }

  String _getStatusText(String status) {
    if (status.contains("won") || status.contains("🎉")) {
      return "WON";
    } else if (status.contains("luck") || status.contains("lost")) {
      return "LOST";
    } else if (status.contains("Pending") || status.contains("Processing")) {
      return "PENDING";
    }
    return status.length > 10 ? status.substring(0, 10) + "..." : status;
  }
}
