import 'package:flutter/material.dart';
import 'package:smart_transportation/home/map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeMap(),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 35, 152, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), child: const Text("Explore")),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), child: const Text("Route")),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), child: const Text("Info")),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), child: const Text("Profile")),
          ]
        ),
      ),
    );
  }
}