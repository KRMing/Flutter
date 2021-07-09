import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocator {

  String lat;
  String lon;

  GeoLocator(this.lat, this.lon);

  GeoLocator.empty() : this('0.0', '0.0');

  /* Determine the current position of the device.
  When the location services are not enabled or permissions
  are denied the `Future` will return an error. */
  Future<void> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /* Location services are not enabled don't continue
      accessing the position and request users of the
      App to enable the location services. */
      print('SYSALERT - ERROR: should enable location services.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /* Permissions are denied, next time you could try
        requesting permissions again (this is also where
        Android's shouldShowRequestPermissionRationale
        returned true. According to Android guidelines
        your App should show an explanatory UI now. */
        print('SYSALERT - ERROR: should enable location permission.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print('SYSALERT - ERROR: location services denied permenately, cannot continue.');
      return;
    }

    /* When we reach here, permissions are granted and we can
    continue accessing the position of the device. */
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    this.lon = position.longitude.toString();
    this.lat = position.latitude.toString();
  }
}