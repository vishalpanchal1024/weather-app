import 'package:geolocator/geolocator.dart';

class Location {
  double? latt;
  double? long;

  Future locations() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // permission = await Geolocator.requestPermission();
      // permission = await Geolocator.checkPermission();
      return await Geolocator.isLocationServiceEnabled();
    }

    if (permission == LocationPermission.deniedForever) {
      return await Geolocator.isLocationServiceEnabled();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latt = position.latitude;
    long = position.longitude;

    return await Geolocator.getCurrentPosition();
  }
}
