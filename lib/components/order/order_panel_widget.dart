import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_transportation/components/location/location_search_dialogue.dart';
import 'package:smart_transportation/components/generic/styled_textfield.dart';
import 'package:smart_transportation/components/location/location_controller.dart';
import 'package:smart_transportation/components/order/order_button.dart';
import 'package:smart_transportation/components/order/order_controller.dart';

class OrderPanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  final GoogleMapController mapController;

  const OrderPanelWidget({
    super.key,
    required this.controller,
    required this.panelController,
    required this.mapController,
  });

  @override
  State<OrderPanelWidget> createState() => _OrderPanelWidgetState();
}

class _OrderPanelWidgetState extends State<OrderPanelWidget> {
  final OrderController controller = Get.find();

  @override
  Widget build(BuildContext context) => 
        GetBuilder<LocationController>(builder: (locationController) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Unfocus text fields when tapping outside
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              controller: widget.controller,
              padding: EdgeInsets.zero,
              children: buildPanelWidget(controller),
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
    if (widget.panelController.panelPosition > 0.99) {
      widget.panelController.close();
    } else {
      widget.panelController.open();
    }
  }

  void sentOrder(OrderController controller) {
    setState(() {
      controller.confirmOrder = true;
    });

    controller.orderRide();

    if (kDebugMode) {
      print('Order Sent');
    }
  }

  void _showTimePicker(OrderController controller) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((onValue) {
      setState(() {
        controller.timeOfDay = onValue!;
        controller.timeController.text = controller.timeOfDay.format(context);
      });
    });
  }

  void cancelOrder(OrderController controller) {
    setState(() {
      controller.cancelRide();
    });

    if (kDebugMode) {
      print('Order cancel');
    }
  }

  List<Widget> buildPanelWidget(OrderController controller) {
    if (controller.confirmOrder) {
      return showRideDetailsPanelWidget(controller);
    } else {
      return showOrderPanelWidget(controller);
    }
  }

  List<Widget> showOrderPanelWidget(OrderController controller) {
    return <Widget>[
      const SizedBox(
        height: 18,
      ),
      buildDragHandle(),
      const SizedBox(
        height: 11,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "  Book Ride",
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 2,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 25),

      //pickup
      LocationSearchDialogue(
        controller: controller.pickupController,
        hintText: 'Pickup At? ',
        obscureText: false,
        icon: const Icon(Icons.room_outlined),
        prefixIconColor: Colors.black,
        mapController: widget.mapController,
      ),
      const SizedBox(height: 30),

      //destination
      LocationSearchDialogue(
        controller: controller.destinationController,
        hintText: 'Where To?',
        obscureText: false,
        icon: const Icon(Icons.outlined_flag),
        prefixIconColor: Colors.black,
        mapController: widget.mapController,
      ),
      const SizedBox(height: 30),

      //time
      StyledTextField(
        onTap: () => _showTimePicker(controller),
        readOnly: true,
        controller: controller.timeController,
        hintText: 'When?',
        obscureText: false,
        icon: const Icon(Icons.access_time),
        prefixIconColor: Colors.black,
      ),
      const SizedBox(height: 30),

      //no. of passengers
      StyledTextField(
        keyboardType: TextInputType.number,
        controller: controller.numberController,
        hintText: 'How Many?',
        obscureText: false,
        icon: const Icon(Icons.people),
        prefixIconColor: Colors.black,
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Checkbox(
            value: controller.hasCarPool,
            activeColor: Colors.black,
            onChanged: (bool? value) {
              setState(() {
                controller.hasCarPool = value!;
              });
            },
          ),
          const Text(
            "Do you want to carpool?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
      OrderButton(
        onTap: () => sentOrder(controller),
        text: 'Confirm Order',
        isActive: controller.canConfirmOrder,
        timeController: controller.timeController,
        numberController: controller.numberController,
        destinationController: controller.destinationController,
        pickupController: controller.pickupController,
      )
    ];
  }

  List<Widget> showRideDetailsPanelWidget(OrderController controller) {
    return <Widget>[
      const SizedBox(
        height: 18,
      ),
      buildDragHandle(),
      const SizedBox(
        height: 11,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "  Ride Details",
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 2,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 25),

      //pickup
      StyledTextField(
        canRequestFocus: false,
        readOnly: true,
        controller: controller.pickupController,
        hintText: 'Pickup At? ',
        obscureText: false,
        icon: const Icon(Icons.room_outlined),
        prefixIconColor: Colors.black,
      ),
      const SizedBox(height: 30),

      //destination
      StyledTextField(
        canRequestFocus: false,
        readOnly: true,
        controller: controller.destinationController,
        hintText: 'Where To?',
        obscureText: false,
        icon: const Icon(Icons.outlined_flag),
        prefixIconColor: Colors.black,
      ),
      const SizedBox(height: 30),

      //time
      StyledTextField(
        canRequestFocus: false,
        readOnly: true,
        controller: controller.timeController,
        hintText: 'When?',
        obscureText: false,
        icon: const Icon(Icons.access_time),
        prefixIconColor: Colors.black,
      ),
      const SizedBox(height: 30),

      //no. of passengers
      StyledTextField(
        canRequestFocus: false,
        readOnly: true,
        keyboardType: TextInputType.number,
        controller: controller.numberController,
        hintText: 'How Many?',
        obscureText: false,
        icon: const Icon(Icons.people),
        prefixIconColor: Colors.black,
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Checkbox(
            value: controller.hasCarPool,
            activeColor: Colors.black,
            onChanged: (bool? value) {},
          ),
          const Text(
            "Do you want to carpool?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
      //'Cancel Order' button
      OrderButton(
        onTap: () => cancelOrder(controller),
        text: 'Cancel Order',
      )
    ];
  }
}
