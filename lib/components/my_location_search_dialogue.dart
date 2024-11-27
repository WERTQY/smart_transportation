import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_transportation/components/location_textfield.dart';
import 'package:smart_transportation/home/location_controller.dart';

class MyLocationSearchDialogue extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Color? prefixIconColor;
  final GoogleMapController mapController;

  const MyLocationSearchDialogue({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.mapController,
    this.icon,
    this.prefixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(

      hideOnEmpty: true,
      controller: controller,
      suggestionsCallback: (search) async => 
      await Get.find<LocationController>().searchLocation(context, search),
      builder: (context, controller, focusNode) {
        return LocationTextField(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          icon: icon,
          prefixIconColor: prefixIconColor, 
          autoFocus: false,
          focusNode: focusNode,
        );
      },

      itemBuilder: (context, Prediction suggestion) {
        return ListTile(
          title: Text(suggestion.description!, maxLines: 1,overflow: TextOverflow.ellipsis,),
        );
      },

      decorationBuilder: (context, child) {
        return Container(
          padding: const EdgeInsets.only(left: 25, right: 25,),
          child: Material(
            type: MaterialType.card,
            elevation: 4,
            borderRadius: BorderRadius.zero,
            child: child,
          ),
        );
      },
      offset: const Offset(0, 0),
      onSelected: (Prediction suggestion) {
      controller.text = suggestion.description!;
        //FocusScope.of(context).unfocus();
        
        //final locationController = Get.find<LocationController>();

        // Use Geocoding or Places API to convert description to location
        //List<geocoding.Location> locations = 
        //await geocoding.locationFromAddress(suggestion.description!);
        /*
        if (locations.isNotEmpty) {
          final location = locations.first;

          // Update pickPlaceMark with the selected location
          List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(location.latitude, location.longitude);

          if (placemarks.isNotEmpty) {
            final placemark = placemarks.first;

          // Update the pickPlaceMark with more detailed info from Placemark
            locationController.pickPlaceMark = geocoding.Placemark(
              name: suggestion.description, // You can use the description for name
              locality: placemark.locality,   // Use locality (city or area)
              country: placemark.country,     // Country of the location
              administrativeArea: placemark.administrativeArea, // Administrative area (state/province)
              subAdministrativeArea: placemark.subAdministrativeArea, // Sub administrative area
            );

            print("LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
            controller.text = suggestion.description!;
          }
        }*/
      }       
    );
  }
}
