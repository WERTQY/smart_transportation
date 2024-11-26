import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.zero,
    controller: controller,
    children: <Widget>[
      const SizedBox(height: 18,),
      buildDragHandle(),
      const SizedBox(height: 18,),
      Container(
        alignment: Alignment.center, 
        child: const Text(
          "Book Ride", 
          style: TextStyle(
            fontSize: 25, 
            letterSpacing: 4,
          ),
        ),
      ),
    ],
  );

  Widget buildDragHandle() => GestureDetector(
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
  
void togglePanel() => panelController.isPanelOpen ? 
  panelController.close() :
  panelController.open();
}