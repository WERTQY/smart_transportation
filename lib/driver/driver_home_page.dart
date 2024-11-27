import 'package:flutter/material.dart';
import 'package:smart_transportation/home/navigation_bar.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeNavigationBar();
  }
}
