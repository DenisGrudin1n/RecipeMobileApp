import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:http/http.dart' as http;

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;
  LatLng? currentLocation;
  LatLng? defaultLocation;
  List<LatLng> nearbyStoreLocations = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getNearbyStores();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _getNearbyStores() async {
    const apiKey = 'AIzaSyDqxWKh05mRB7KnqohBeUepeL6b55dU2uY';
    const radius = 2000; // Радіус пошуку магазинів (у метрах)

    if (currentLocation != null) {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentLocation!.latitude},${currentLocation!.longitude}&radius=$radius&type=grocery_or_supermarket&key=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'];

        for (var result in results) {
          final location = result['geometry']['location'];
          final storeLocation = LatLng(location['lat'], location['lng']);
          nearbyStoreLocations.add(storeLocation);
        }

        setState(() {});
      }
    } else {
      // Додати жорстко закодовані координати для стандартної локації
      const double defaultLatitude = 40.7128; // Нью-Йорк
      const double defaultLongitude = -74.0060;
      defaultLocation = const LatLng(defaultLatitude, defaultLongitude);

      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$defaultLatitude,$defaultLongitude&radius=$radius&type=grocery_or_supermarket&key=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'];

        for (var result in results) {
          final location = result['geometry']['location'];
          final storeLocation = LatLng(location['lat'], location['lng']);
          nearbyStoreLocations.add(storeLocation);
        }

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Google Maps',
            style: TextStyle(color: kWhite),
          ),
          backgroundColor: kPrimary),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: kPrimary,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: currentLocation != null
                  ? GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: currentLocation!, zoom: 13),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: currentLocation!,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: defaultLocation!,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                        for (var i = 0; i < nearbyStoreLocations.length; i++)
                          Marker(
                            markerId:
                                MarkerId(nearbyStoreLocations[i].toString()),
                            position: nearbyStoreLocations[i],
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueYellow),
                          ),
                      },
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
