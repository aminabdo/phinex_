
import 'package:location/location.dart';

class LocationUtils{

  static Location _location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

 LocationUtils() {
   _checkLocationPermission();
   _checkServiceIsEnabled();
 }

  bool get serviceEnabled => _serviceEnabled;
  LocationData get locationData => _locationData;
  PermissionStatus get permissionStatus => _permissionGranted;

  static Future<bool> locationIsEnabled() async {
    return await _location.serviceEnabled();
  }

  static Future<LocationData> getCurrentUserLocation() async {
    return await _location.getLocation();
  }

  static Stream<LocationData> getCurrentUserLocationAsStream() {
    return _location.onLocationChanged;
  }

  void _checkServiceIsEnabled() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }


  void _checkLocationPermission() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
