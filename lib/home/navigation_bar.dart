import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/components/location_controller.dart';
import 'package:smart_transportation/home/passenger_map.dart';
import 'package:smart_transportation/home/passenger_profile.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({super.key});

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  int _currentIndex = 0;

  List<Widget> body = const [
    HomeMap(),
    Text("route"),
    Text("info"),
    Text("chat"),
    PassengerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // Change background color
        selectedItemColor: Colors.black, // Color for selected items
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Transport', icon: Icon(Icons.drive_eta)),
          BottomNavigationBarItem(label: 'Route', icon: Icon(Icons.route)),
          BottomNavigationBarItem(label: 'Info', icon: Icon(Icons.info)),
          BottomNavigationBarItem(label: 'Chat', icon: Icon(Icons.chat)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
