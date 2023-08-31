import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {
  final locationPermission = await Geolocator.checkPermission();

  if (locationPermission == LocationPermission.whileInUse ||
      locationPermission == LocationPermission.always) {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } else if ((locationPermission == LocationPermission.denied ||
      locationPermission == LocationPermission.deniedForever)) {
    // Added fallback location if location perms not granted.

    // ** DO NOT RETURN NULL !!!
    // ** SINCE THIS "callBackPlaceDetail" FUNCTION DOES NOT CHECK CALLBACK VALUE
    return null;
  }
  return null;
}
