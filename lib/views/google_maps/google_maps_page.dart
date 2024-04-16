import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/google_maps_controller.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;
  LatLng? currentLocation;
  static const double defaultLatitude = 25.764083417112865;
  static const double defaultLongitude = -80.19481147397552;
  LatLng? defaultLocation = const LatLng(defaultLatitude, defaultLongitude);
  List<LatLng> nearbyStoreLocations = [];
  final GoogleMapsController _mapsController = GoogleMapsController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    LatLng? currentLocation = await _mapsController.fetchCurrentLocation();
    if (currentLocation != null && mounted) {
      setState(() {
        this.currentLocation = currentLocation;
      });
      List<LatLng> currentStores =
          await _mapsController.fetchNearbyStores(currentLocation);
      nearbyStoreLocations.addAll(currentStores);
    }

    List<LatLng> defaultStores =
        await _mapsController.fetchNearbyStores(defaultLocation!);
    nearbyStoreLocations.addAll(defaultStores);

    if (mounted) {
      setState(() {});
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
                      padding: const EdgeInsets.only(bottom: 50),
                      markers: {
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: currentLocation!,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                        Marker(
                          markerId: const MarkerId('defaultLocation'),
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
