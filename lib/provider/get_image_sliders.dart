import 'package:dmboss/model/get_image_sliders.dart';
import 'package:dmboss/service/get_image_sliders_service.dart';
import 'package:flutter/material.dart';

class GetImageSlidersProvider extends ChangeNotifier {
  GetImageSliders? _getImageSliders;
  String? _errorMessage;
  bool _isLoading = false;

  GetImageSliders? get getImageSliders => _getImageSliders;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getImageSLiders(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetImageSlidersService();
    final result = await service.getImageSlidersService(context);

    if (result != null) {
      _getImageSliders = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch image sliders.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
