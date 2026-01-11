import 'package:e_commerce_app/core/shared/Loading/easy_loading.dart';
import 'package:e_commerce_app/core/shared/Loading/loading_message.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  String toString() {
    return 'Lat: $latitude, Lng: $longitude, Address: $address';
  }
}

Future<LocationData?> getCurrentLocationAndAddress() async {
  try {
    easyLoading('Récupération de la localisation...', EasyLoadingEnum.loading);
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return null;
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return null;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get address from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String address = 'Unknown';
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      address = '${place.street}, ${place.locality}, ${place.country}' ;
    }

    easyLoading(NONE, EasyLoadingEnum.dismiss);
    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  } catch (e) {
    easyLoading('Error getting location', EasyLoadingEnum.error);
    print('Error getting location: $e');
    return null;
  }
}