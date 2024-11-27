import 'package:flutter/material.dart';
import 'package:smart_transportation/home/navigation_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).unfocus();
    return const HomeNavigationBar();
  
  }
}
