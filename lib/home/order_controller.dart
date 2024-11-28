import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_transportation/model/order_details.dart';

class OrderController extends GetxController {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  bool hasCarPool = false;
  bool confirmOrder = false;
  bool canConfirmOder = false;

  late GoogleMapController mapController;
  LatLng pickupLocation = const LatLng(0, 0);
  LatLng destination = const LatLng(0, 0);
  LatLng passengerLocation = const LatLng(0, 0);
  LatLng driverLocation = const LatLng(0, 0);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;



  // Controllers and States
  final Completer<GoogleMapController> controllerCompleter = Completer<GoogleMapController>();
  LocationData? currentLocation;
  final center = const LatLng(3.1220007402224543, 101.65689475884037);

  // Location and Google Maps Setup
  final Location location = Location();

  @override
  Future<void> onInit() async {
    orderIdController.text = "1${orderIdController.text}2";
    nameController.text = "2";
    phoneController.text = "3";
    amountController.text = "100";
    orderCollection = firestore.collection('order');
    _getCurrentLocation();
    super.onInit();
  }

  // Fetch current location
  Future<void> _getCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      if (currentLocation != null) {
        moveToCurrentLocation();
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  // Update GoogleMapController
  void onMapCreated(GoogleMapController controller) {
    controllerCompleter.complete(controller);
    mapController = controller;
    if (currentLocation != null) {
      moveToCurrentLocation();
    }
  }

  // Move camera to current location
  void moveToCurrentLocation() {
    if (currentLocation != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 17.5,
        ),
      ));
    }
  }

  void orderRide() {
    DocumentReference doc = orderCollection.doc(orderIdController.text);
    OrderDetails orderDetails = OrderDetails(
      orderId: doc.id,
      name: nameController.text,
      phone: phoneController.text,
      amount: int.parse(amountController.text),
      pickup: pickupController.text,
      destination: destinationController.text,
      time: timeController.text,
      timeOfDay: TimeOfOrderDay(hour: timeOfDay.hour, minute: timeOfDay.minute),
      hasCarPool: hasCarPool,
      confirmOrder: confirmOrder,
      canConfirmOrder: canConfirmOder,
      pickupLocation: OrderLocation(lat: pickupLocation.latitude, lng: pickupLocation.longitude),
      destinationLocation: OrderLocation(lat: destination.latitude, lng: destination.longitude),
      passengerLocation: OrderLocation(lat: passengerLocation.latitude, lng: passengerLocation.longitude),
      driverLocation: OrderLocation(lat: driverLocation.latitude, lng: driverLocation.longitude),
    );
    final orderJson = orderDetails.toJson();
    doc.set(orderJson);
  }
}