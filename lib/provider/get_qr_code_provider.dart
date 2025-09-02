import 'package:dmboss/model/get_qr_code_model.dart';
import 'package:dmboss/service/get_qr_code_service.dart';
import 'package:flutter/material.dart';

class GetQrCodeProvider extends ChangeNotifier {
  GetQrCodeModel? _getQrCodeModel;
  String? _errorMessage;
  bool _isLoading = false;

  GetQrCodeModel? get gamesList => _getQrCodeModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getQrCodeProvider(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetQrCodeService();
    final result = await service.getQrCode(context);

    if (result != null) {
      _getQrCodeModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch QR code.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
