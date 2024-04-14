import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recipeapp/services/google_maps_services.dart';

class GoogleMapsController {
  final GoogleMapsServices _locationService = GoogleMapsServices();

  Future<LatLng?> fetchCurrentLocation() async {
    return await _locationService.getCurrentLocation();
  }

  Future<List<LatLng>> fetchNearbyStores(LatLng location) async {
    return await _locationService.getNearbyStores(location);
  }
}
