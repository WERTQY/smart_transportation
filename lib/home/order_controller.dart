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
  bool canConfirmOrder = true;
  bool hasBeenTaken = false;

  late GoogleMapController mapController;
  LatLng pickupLocation = const LatLng(0, 0);
  LatLng destinationLocation = const LatLng(0, 0);
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
    OrderDetails orderDetails = await fetchSpecificOrderDetails("12");
    writeOrderDetailsIntoController(orderDetails);
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
      number: int.parse(numberController.text),
      timeOfDay: TimeOfOrderDay(hour: timeOfDay.hour, minute: timeOfDay.minute),
      hasCarPool: hasCarPool,
      confirmOrder: confirmOrder,
      canConfirmOrder: canConfirmOrder,
      hasBeenTaken: hasBeenTaken,
      pickupLocation: OrderLocation(lat: pickupLocation.latitude, lng: pickupLocation.longitude),
      destinationLocation: OrderLocation(lat: destinationLocation.latitude, lng: destinationLocation.longitude),
      passengerLocation: OrderLocation(lat: passengerLocation.latitude, lng: passengerLocation.longitude),
      driverLocation: OrderLocation(lat: driverLocation.latitude, lng: driverLocation.longitude),
    );
    final orderJson = orderDetails.toJson();
    doc.set(orderJson);
  }

  void cancelRide() {
    orderIdController.clear();
    nameController.clear();
    phoneController.clear();
    amountController.clear();
    pickupController.clear();
    destinationController.clear();
    timeController.clear();
    numberController.clear();

    timeOfDay = TimeOfDay.now();
    hasCarPool = false;
    confirmOrder = false;
    canConfirmOrder = true;
    hasBeenTaken = false;

    pickupLocation = const LatLng(0, 0);
    destinationLocation = const LatLng(0, 0);
    passengerLocation = const LatLng(0, 0);
    driverLocation = const LatLng(0, 0);
    FirebaseFirestore.instance.collection("order").doc(orderIdController.text).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  Future<OrderDetails> fetchSpecificOrderDetails(String orderId) async {
    try {
      DocumentReference doc = orderCollection.doc(orderId);
      DocumentSnapshot snapshot = await doc.get();
      if(snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        update();
        return OrderDetails.fromJson(data);
      }else{      
        update();
        OrderDetails orderDetails = OrderDetails();
        orderDetails.resetToInitialState;
        return orderDetails;
      }
    } catch (e) {
      rethrow;
    }
  }

  writeOrderDetailsIntoController(OrderDetails orderDetails) {
    orderIdController.text = orderDetails.orderId!;
      nameController.text = orderDetails.name!;
      phoneController.text = orderDetails.phone!;
      amountController.text = orderDetails.amount!.toString();
      pickupController.text = orderDetails.pickup!;
      destinationController.text = orderDetails.destination!;
      timeController.text = orderDetails.time!;
      numberController.text = orderDetails.number!.toString();
      timeOfDay = TimeOfDay(hour: orderDetails.timeOfDay!.hour!, minute: orderDetails.timeOfDay!.minute!);
      hasCarPool = orderDetails.hasCarPool!;
      confirmOrder = orderDetails.confirmOrder!;
      canConfirmOrder = orderDetails.canConfirmOrder!;
      hasBeenTaken = orderDetails.hasBeenTaken!;
      pickupLocation = LatLng(orderDetails.pickupLocation!.lat!, orderDetails.pickupLocation!.lng!);
      destinationLocation = LatLng(orderDetails.destinationLocation!.lat!, orderDetails.destinationLocation!.lng!);
      passengerLocation = LatLng(orderDetails.passengerLocation!.lat!, orderDetails.passengerLocation!.lng!);
      driverLocation = LatLng(orderDetails.driverLocation!.lat!, orderDetails.driverLocation!.lng!);
  }

}