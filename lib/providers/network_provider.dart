
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class NetworkProvider with ChangeNotifier {
  bool hasNetworkConnection;

  NetworkProvider() {
    subscripeToConnection();
  }

  subscripeToConnection() async {
    Connectivity().checkConnectivity().then((value) {
      hasNetworkConnection = getNetworkState(value);
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      hasNetworkConnection = getNetworkState(result);
      notifyListeners();
    });
  }

  bool getNetworkState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
        return false;
      default:
        return false;
    }
  }
}