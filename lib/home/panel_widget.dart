import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_transportation/components/my_button.dart';
import 'package:smart_transportation/components/my_textfield.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  final timeController = TextEditingController();
  final numberController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;


  PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    controller: controller,
    children: <Widget>[
      const SizedBox(height: 18,),
      buildDragHandle(),
      const SizedBox(height: 18,),
      Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Book Ride",
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 4,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: signUserOut, icon: const Icon(Icons.logout)),
            ],
          ),
          const SizedBox(height: 40),

          //pickup
          MyTextField(
              controller: pickupController,
              hintText: 'Pick Up',
              obscureText: false),
          const SizedBox(height: 20),

          //destination
          MyTextField(
              controller: destinationController,
              hintText: 'Destination',
              obscureText: false),
          const SizedBox(height: 20),

          //time
          MyTextField(
              controller: timeController,
              hintText: 'Time (am/pm)',
              obscureText: false),
          const SizedBox(height: 20),

          //no. of passengers
          MyTextField(
              controller: numberController,
              hintText: 'Number of Passenger',
              obscureText: false),
          const SizedBox(height: 20),

          //just a line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Expanded(
                child: Divider(
              thickness: 1,
              color: Colors.grey[500],
            )),
          ),
          const SizedBox(height: 20),

          //'Confirm Order' button
          MyButton(onTap: sentOrder, text: 'Confirm Order')
    ],
  );

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
    if(panelController.panelPosition > 0.99) {
      panelController.close();
    } else {
      panelController.open();
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void sentOrder() {
    if (kDebugMode) {
      print('Order Sent');
    }
  }
}
