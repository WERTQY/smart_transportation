/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_transportation/components/location_controller.dart';

class LocationSearchDialogue extends StatelessWidget {
  final GoogleMapController? mapController;
  final TextEditingController textEditingController;
  const LocationSearchDialogue({required this.mapController, required this.textEditingController});


  @override
  Widget build(BuildContext context) {
    //final TextEditingController _controller = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 150),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: SizedBox(
          width: 250, 
          child: TypeAheadField(
            suggestionsCallback: (search) async => 
            await Get.find<LocationController>().searchLocation(context, search),
            builder: (context, controller, focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                )
              );
            },
            itemBuilder: (context, Prediction suggestion) {
              return ListTile(
                title: Text(suggestion.description!, maxLines: 1,overflow: TextOverflow.ellipsis,),
                //subtitle: Text(city.country),
              );
            },
            
            onSelected: (Prediction suggestion) async {
    final locationController = Get.find<LocationController>();

    // Use Geocoding or Places API to convert description to location
    List<geocoding.Location> locations =
        await geocoding.locationFromAddress(suggestion.description!);

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

        textEditingController.text = suggestion.description!;
        /*
              '${locationController.pickPlaceMark.name ?? ''}'
              '${locationController.pickPlaceMark.locality ?? ''}'
              '${locationController.pickPlaceMark.postalCode ?? ''}'
              '${locationController.pickPlaceMark.country ?? ''}';
              */
      }
    }
            }
            
          ),
        ),
      ),
    );
  }
}
*/