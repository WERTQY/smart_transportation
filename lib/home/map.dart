import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_transportation/home/panel_widget.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late GoogleMapController mapController; 
  final Completer<GoogleMapController> _controllerCompleter = Completer<GoogleMapController>();

  final LatLng _center = const LatLng(3.1220007402224543, 101.65689475884037);
  LocationData? currentLocation;

  final panelController = PanelController();
  static const double fabHeightClosed = 60;
  double fabHeight = fabHeightClosed;

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
    _controllerCompleter.complete(controller);
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
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;
    final panelHeightClosed = 41.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: true,
          parallaxOffset: .55,
          onPanelSlide: (position) => setState(() {
            final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;
            fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
          }),
          onPanelClosed: () => FocusScope.of(context).unfocus(),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: currentLocation == null? _center : LatLng(currentLocation!.latitude!, currentLocation!.longitude!),                zoom: 17.5,
            ),
          ), 
          panelBuilder: (controller) => FutureBuilder<GoogleMapController>(
            future: _controllerCompleter.future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return PanelWidget(
                  controller: controller,
                  panelController: panelController,
                  mapController: snapshot.data!, // Safe to use now
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),      
        Positioned(
          right: 20,
          bottom: fabHeight,
          child: buildFAB(context),
        ),
      ]
    );
  }

  Widget buildFAB(BuildContext context) => FloatingActionButton(
    onPressed: _moveToCurrentLocation,
    backgroundColor: Colors.white,
    child: const Icon(Icons.my_location),
  );
}
