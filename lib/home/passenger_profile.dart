import 'package:flutter/material.dart';
import 'package:smart_transportation/driver/driver_home_map.dart';
import 'package:smart_transportation/driver/driver_home_page.dart';
import 'package:smart_transportation/driver/driver_nagivation_bar.dart';
import 'package:smart_transportation/driver/driver_profile_page.dart';

class PassengerProfile extends StatefulWidget {
  const PassengerProfile({super.key});

  @override
  State<PassengerProfile> createState() => _PassengerProfileState();
}

class _PassengerProfileState extends State<PassengerProfile> {
  void _handleButtonTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DriverHomeNavigationBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blue,
        actions: [
          const Text(
            "Switch to Driver",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.compare_arrows_rounded),
            color: Colors.white,
            iconSize: 30,
            onPressed: _handleButtonTap,
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile Details"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
