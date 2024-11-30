import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/pages/authentication/switch_page.dart';
import 'package:smart_transportation/pages/authentication/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("Snapshot state: ${snapshot.connectionState}");
          print("User: ${snapshot.data}");

          //user is logged in
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If there is an error in the stream
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred. Please try again later.'),
            );
          }

          if (snapshot.hasData) {
            Future.microtask(() => Get.to(() => const SwitchPage()));
          } else {
            Future.microtask(
                () => Get.to(() => const LoginOrRegisterPage()));
          }
          return const SizedBox.shrink(); // This ensures a fallback widget
        },
      ),
    );
  }
}
