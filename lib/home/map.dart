import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late GoogleMapController mapController; 

  final LatLng _center = const LatLng(3.1220007402224543, 101.65689475884037);
  LocationData? currentLocation;

  void _getCurrentLocation () {
    Location location = Location();

    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location; 
        });
        _moveToCurrentLocation();
      },
    );
  }

  @override
  void initState(){
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (currentLocation != null) {
      _moveToCurrentLocation();
    }
  }

  void _moveToCurrentLocation() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        zoom: 17.5,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: currentLocation == null? _center : LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 17.5,
            ),
          ), 
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _moveToCurrentLocation,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      );
  }
}