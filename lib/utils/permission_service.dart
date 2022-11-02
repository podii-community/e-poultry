import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if Location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the Location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the Location services.
        return Future.error('Location permissions are disabled.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      return Future.error('Location permissions are disabled permanently.');
    }
  }
}
