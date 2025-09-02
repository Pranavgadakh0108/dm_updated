import 'package:dmboss/model/bid_history_model.dart';
import 'package:dmboss/service/get_bid_history_service.dart';
import 'package:flutter/material.dart';

class GetBetHistoryProvider extends ChangeNotifier {
  BidHistoryModel? _bidHistoryModel;
  String? _errorMessage;
  bool _isLoading = false;

  BidHistoryModel? get gamesList => _bidHistoryModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getBetHistoryProvider(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetBidHistoryService();
    final result = await service.getBidHistory(context);

    if (result != null) {
      _bidHistoryModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Bid History.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
