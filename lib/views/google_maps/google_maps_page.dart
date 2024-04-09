import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recipeapp/constants/constants.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Місцезнаходження вимкнено, показати відповідне повідомлення
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Дозвіл не надано, запросити його
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Дозвіл знову не надано, обробити цей випадок
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
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
                            position: currentLocation!)
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
