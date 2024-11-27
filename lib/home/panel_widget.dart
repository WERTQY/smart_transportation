import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_transportation/components/my_location_search_dialogue.dart';
import 'package:smart_transportation/components/my_button.dart';
import 'package:smart_transportation/components/my_textfield.dart';
import 'package:smart_transportation/home/location_controller.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  final GoogleMapController mapController;

  PanelWidget({
    super.key,
    required this.controller,
    required this.panelController,
    required this.mapController,
  });

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  final pickupController = TextEditingController();

  final destinationController = TextEditingController();

  final timeController = TextEditingController();

  final numberController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  var hasCarPool = false;

  @override
  Widget build(BuildContext context) => GetBuilder<LocationController>(builder: (locationController) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Unfocus text fields when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        controller: widget.controller,
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 18,),
          buildDragHandle(),
          const SizedBox(height: 11,),
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "  Book Ride",
                    style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 2,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: signUserOut, icon: const Icon(Icons.logout)),
                ],
          ),
          const SizedBox(height: 25),

          //pickup
          MyLocationSearchDialogue(
              controller: pickupController,
              hintText: 'Pickup At? ',
              obscureText: false,
              icon: const Icon(Icons.room_outlined),
              prefixIconColor: Colors.black,
              mapController: widget.mapController,
              ),
          const SizedBox(height: 30),

          //destination
          MyLocationSearchDialogue(
              controller: destinationController,
              hintText: 'Where To?',
              obscureText: false,
              icon: const Icon(Icons.outlined_flag),
              prefixIconColor: Colors.black,
              mapController: widget.mapController,
          ),
          const SizedBox(height: 30),

          //time
          MyTextField(
              controller: timeController,
              hintText: 'When?',
              obscureText: false,
              icon: const Icon(Icons.access_time),
              prefixIconColor: Colors.black,
          ),
          const SizedBox(height: 30),
    
          //no. of passengers
          MyTextField(
              controller: numberController,
              hintText: 'How Many?',
              obscureText: false,
              icon: const Icon(Icons.people),
              prefixIconColor: Colors.black,
              ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10,),
              Checkbox(
                value: hasCarPool,
                activeColor: Colors.black,
                onChanged: (bool? value) {
                  setState(() {
                    hasCarPool = value!;
                  });
                },
              ),
              const Text("Do you want to carpool?", style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          //just a line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                      color: Colors.grey[500],
                    ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          //'Confirm Order' button
          MyButton(onTap: sentOrder, text: 'Confirm Order')
        ],
      ),
    );
  });

  Widget buildDragHandle() => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: togglePanel,
    child: Center( 
      child: Container(
        width: 80,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(13)),
        ),
      ),
    ),
  );

  void togglePanel() {
    if(widget.panelController.panelPosition > 0.99) {
      widget.panelController.close();
    } else {
      widget.panelController.open();
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void sentOrder() {
    pickupController.addListener(() {
      print('Text input: ${pickupController.text}');
    });
    if (kDebugMode) {
      print('Order Sent');
    }
  }
}
