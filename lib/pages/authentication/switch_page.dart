import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/pages/passenger/passenger_home.dart';
import 'package:smart_transportation/components/profile/profile_controller.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    if(Get.isRegistered<ProfileController>()){
      Get.delete<ProfileController>();
    }
    return const PassengerHome();
  }
}
