import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_transportation/home/panel_widget.dart';
import 'package:smart_transportation/home/order_controller.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  final panelController = PanelController();
  static const double fabHeightClosed = 60;
  double fabHeight = fabHeightClosed;

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;
    final panelHeightClosed = 41.0;

    return GetBuilder<OrderController>(
      init: OrderController(), // Initialize the controller
      builder: (orderController) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              controller: panelController,
              minHeight: panelHeightClosed,
              maxHeight: panelHeightOpen,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              parallaxEnabled: true,
              parallaxOffset: .55,
              onPanelClosed: () => FocusScope.of(context).unfocus(),
              onPanelSlide: (position) => setState(() {
                final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;
                fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
              }),
              body:
              GoogleMap(
                onMapCreated: orderController.onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: orderController.center,
                  zoom: 17.5,
                ),
              ),
              panelBuilder: (controller) => FutureBuilder<GoogleMapController>(
                future: orderController.controllerCompleter.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return PanelWidget(
                      controller: controller,
                      panelController: panelController,
                      mapController: snapshot.data!, // Safe to use now
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Positioned(
              right: 20,
              bottom: fabHeight,
              child: buildFAB(context, orderController),
            ),
          ],
        );
      },
    );
  }

  Widget buildFAB(BuildContext context, OrderController orderController) => FloatingActionButton(
        onPressed: orderController.moveToCurrentLocation,
        backgroundColor: Colors.white,
        child: const Icon(Icons.my_location),
      );
}
