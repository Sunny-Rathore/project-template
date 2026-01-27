import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geolocator/geolocator.dart';

Future<bool> checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  // If denied → request again
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied.");
    }
  }

  // Permanently denied
  if (permission == LocationPermission.deniedForever) {
    Geolocator.openAppSettings();
    return Future.error(
      "Location permissions are permanently denied, cannot request.",
    );
  }

  // If granted (whileInUse / always)
  return true;
}

Future<Position?> ensureLocationAndGetCurrentPosition(
  BuildContext context,
) async {
  try {
    // 1. Check if location services (GPS) are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Turn on Location Services'),
            content: const Text(
              'Location services are disabled. Please turn on GPS to continue.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await Geolocator.openLocationSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
      return null;
    }

    // 2. Handle permission states.
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission is required to continue.'),
          ),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permanently denied → guide user to app settings.
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Location permission required'),
            content: const Text(
              'Location permission is permanently denied. '
              'Please enable it from the app settings to use location features.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await Geolocator.openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
      return null;
    }

    // 3. Finally get the current position.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Unable to get your location. Please check permissions and try again.',
        ),
      ),
    );
    return null;
  }
}

Future<Position> getCurrentLocation() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location services are disabled.");
  }

  // Check permission
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied.");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      "Location permissions are permanently denied, cannot request.",
    );
  }

  // Finally get the location
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

Future<String> getAddressFromLatLng(double lat, double lng) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      // Full address
      String address =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      return address;
    }

    return "Address not found";
  } catch (e) {
    print('Error: $e');
    return "Error getting address";
  }
}

int getDistanceBetweenPoints({
  required double startLatitude,
  required double startLongitude,
  required double endLatitude,
  required double endLongitude,
}) {
  double distance = geo.Geolocator.distanceBetween(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  );
  return (distance / 1000).round();
}
