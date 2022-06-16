import 'package:location/location.dart';


class LocationService{

  late String latitude;
  late String longitude;

  static Future<LocationData> getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return LocationData.fromMap({'latitude': 50.450001, 'longitude': 30.523333});
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LocationData.fromMap({'latitude': 50.450001, 'longitude': 30.523333});
      }
    }

    return await location.getLocation();
  }
}