import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverHomeMap extends StatefulWidget {
  const DriverHomeMap({super.key});

  @override
  State<DriverHomeMap> createState() => _DriverHomeMapState();
}

class _DriverHomeMapState extends State<DriverHomeMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(3.1220007402224543, 101.65689475884037);
  LocationData? currentLocation;

  void _getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
      _moveToCurrentLocation();
    });
  }

  void _moveToCurrentLocation() {
    if (currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Home Map'),
        backgroundColor: Colors.grey[300],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
          _getCurrentLocation();
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
