import 'package:flutter/material.dart';
import 'package:smart_transportation/home/map.dart';
import 'package:smart_transportation/home/navigation_bar.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  void _handleButtonTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeNavigationBar()),
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
            "Switch to Passenger",
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
            Text("Driver Profile Details"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
