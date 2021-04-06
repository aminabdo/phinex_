import 'package:flutter/foundation.dart';

class DoctorProvider with ChangeNotifier {
  int _currentIndicatorNumber = 1;
  bool _isLoading = false;

  int get currentIndicatorNumber => _currentIndicatorNumber;

  bool get isLoading => _isLoading;

  void setCurrentIndicatorNumber(int number) {
    _currentIndicatorNumber = number;
    notifyListeners();
  }

  void toggleLoadingState(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}
