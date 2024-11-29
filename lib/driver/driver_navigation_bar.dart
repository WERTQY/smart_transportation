import 'package:flutter/material.dart';
import 'package:smart_transportation/driver/driver_stats_page.dart';
import 'package:smart_transportation/driver/driver_profile_page.dart';
import 'package:smart_transportation/driver/driver_map.dart';

class DriverHomeNavigationBar extends StatefulWidget {
  const DriverHomeNavigationBar({super.key});

  @override
  State<DriverHomeNavigationBar> createState() =>
      _DriverHomeNavigationBarState();
}

class _DriverHomeNavigationBarState extends State<DriverHomeNavigationBar> {
  int _currentIndex = 0;
  List<Widget> body = const [
    DriverHomeMap(),
    DriverStatsPage(),
    DriverProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // Change background color
        selectedItemColor: Colors.blue, // Color for selected items
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Booking', icon: Icon(Icons.car_crash)),
          BottomNavigationBarItem(
              label: 'Stats', icon: Icon(Icons.attach_money)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
