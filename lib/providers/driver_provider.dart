
import 'package:rxdart/rxdart.dart';

class DriverProvider {
  BehaviorSubject<int> currentIndicatorNumber = BehaviorSubject<int>()..value = 1;
  BehaviorSubject<bool> isLoading = BehaviorSubject<bool>()..value = false;

  void setCurrentIndicatorNumber(int value) {
    currentIndicatorNumber.value = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  void update() {
    isLoading.value = isLoading.value;
    currentIndicatorNumber.value = currentIndicatorNumber.value;
  }

  void dispose () {
    currentIndicatorNumber.close();
    isLoading.close();
  }
}

final DriverProvider driverProvider = DriverProvider();