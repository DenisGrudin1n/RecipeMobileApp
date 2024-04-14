import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapsServices {
  static const apiKey = 'AIzaSyDqxWKh05mRB7KnqohBeUepeL6b55dU2uY';
  static const radius = 10000;

  Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }

  Future<List<LatLng>> getNearbyStores(LatLng location) async {
    List<LatLng> nearbyStoreLocations = [];

    final latitude = location.latitude;
    final longitude = location.longitude;

    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&keyword=Grocery store|supermarket|restaurant&language=en&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];

      for (var result in results) {
        final location = result['geometry']['location'];
        final storeLocation = LatLng(location['lat'], location['lng']);
        nearbyStoreLocations.add(storeLocation);
      }
    }

    return nearbyStoreLocations;
  }
}
