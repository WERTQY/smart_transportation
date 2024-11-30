import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/components/location/location_controller.dart';
import 'package:smart_transportation/pages/passenger/passenger_map.dart';
import 'package:smart_transportation/pages/passenger/passenger_profile.dart';
import 'package:smart_transportation/components/profile/profile_controller.dart';

class PassengerHome extends StatefulWidget {
  const PassengerHome({super.key});

  @override
  State<PassengerHome> createState() => _PassengerHomeState();
}

class _PassengerHomeState extends State<PassengerHome> {
  List<Widget> body = const [
    Center(child: Text("route")),
    Center(child: Text("info")),
    Center(child: PassengerMap()),
    Center(child: Text("chat")),
    Center(child: PassengerProfile()),
  ];

  @override
  Widget build(BuildContext context) {
    ProfileController profileController =  Get.find();
    Get.put(LocationController());

    return Scaffold(
      body: Obx(() {
        if (profileController.isLoading.value == true ) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return IndexedStack(
            index: profileController.currentIndex.value,
            children: body,
          );
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: profileController.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white, // Change background color
          selectedItemColor: Colors.black, // Color for selected items
          unselectedItemColor: Colors.grey, // Color for unselected items
          onTap: (int newIndex) {
            if (profileController.firstTimeLogin == false || newIndex == 4) {
              setState(() {
                profileController.currentIndex.value = newIndex;
              });
            } else {
              Future.delayed(Duration.zero, showProfileCompletionFormDialog);
            }
          },

          items: const [
            BottomNavigationBarItem(label: 'Info', icon: Icon(Icons.info)),
            BottomNavigationBarItem(label: 'Route', icon: Icon(Icons.route)),
            BottomNavigationBarItem(
                label: 'Transport', icon: Icon(Icons.drive_eta)),
            BottomNavigationBarItem(label: 'Chat', icon: Icon(Icons.chat)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }

  void showProfileCompletionFormDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("First Time Login",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Please complete your profile before proceeding.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            }, // Close the dialog
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: true, // Optional: Prevent closing by tapping outside
    );
  }
}
