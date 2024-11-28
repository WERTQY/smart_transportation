import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderController extends GetxController{

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

  GoogleMapController? mapController;
  LatLng pickupLocation = const LatLng(0, 0);
  LatLng destination = const LatLng(0, 0);
  LatLng passengerLocation = const LatLng(0, 0);
  LatLng driverLocation = const LatLng(0, 0);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;
}