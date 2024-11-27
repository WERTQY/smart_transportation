
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_transportation/home/location_service.dart';

class LocationController extends GetxController {
  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  set pickPlaceMark(Placemark placemark) {
    _pickPlaceMark = placemark;
    update(); // If you need to notify listeners in GetX
  }

  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty){
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      //print("mt status is " + data["status"]);
      if(data['status'] == 'OK') {
        _predictionList = [];
        data['predictions'].forEach((prediction)
        => _predictionList.add(Prediction.fromJson(prediction)));
      }
    }else {
      _predictionList = [];
    }
    return _predictionList;
  }
}