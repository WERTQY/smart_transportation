import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/components/location_controller.dart';
import 'package:smart_transportation/home/map.dart';

class DriverNavigationBar extends StatefulWidget {
  const DriverNavigationBar({super.key});

  @override
  State<DriverNavigationBar> createState() => _DriverNavigationBarState();
}

class _DriverNavigationBarState extends State<DriverNavigationBar> {
  int _currentIndex = 0;

  List<Widget> body = const [
    HomeMap(),
    Text("route"),
    Text("info"),
    Text("chat"),
    Text("profile"),
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
            label: 'Drive',
            icon: Icon(Icons.car_crash)),
          BottomNavigationBarItem(
            label: 'Info',
            icon: Icon(Icons.info)),
            BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.chat)),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person)),
        ],
        ),
    );
  }
}