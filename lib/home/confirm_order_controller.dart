import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmOrderController extends GetxController{

  TextEditingController orderIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pickupController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  GoogleMapController? mapController;
  LatLng currentLocation = const LatLng(0, 0);
  LatLng selectedLocation = const LatLng(0, 0);
}