import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  bool isActive;
  final TextEditingController? pickupController;
  final TextEditingController? destinationController;
  final TextEditingController? timeController;
  final TextEditingController? numberController;

  OrderButton({
    super.key,
    this.isActive = true,
    required this.onTap,
    required this.text,
    this.pickupController,
    this.destinationController,
    this.timeController,
    this.numberController,
  });

  void checkOnTap(BuildContext context) {
    if(pickupController != null && destinationController != null && timeController != null && numberController != null) {
      if(pickupController!.text.isNotEmpty && destinationController!.text.isNotEmpty && timeController!.text.isNotEmpty && numberController!.text.isNotEmpty) {
        isActive = true;
      }else {
        isActive = false;
      }
    }
    if(isActive) {
      onTap?.call();
    }else{
      showFillFormDialog.call(context);
    }  
  }
  void showFillFormDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.warning),
            SizedBox(width: 10,),
            Text("Invalid Order", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text("Please fill in all the fields before ordering a ride."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: () => checkOnTap(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(25),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}