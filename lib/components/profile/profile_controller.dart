import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/model/user_information.dart';

class ProfileController extends GetxController {
  var currentIndex = 2.obs;
  var isLoading = true.obs;
  var firstFetch = true;

  late String userId;
  late String email;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? selectedGender;
  String? selectedRace;
  TextEditingController phoneController = TextEditingController();
  bool? firstTimeLogin;
  bool? isDriver;
  TextEditingController carModelController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
  bool? online;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  String? getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid; // User's UUID
    } else {
      return null; // No user signed in
    }
  }

  String? getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email; // User's UUID
    } else {
      return null; // No user signed in
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    userId = getUserId()!;
    email = getUserEmail()!;

    ever(currentIndex, (index) async {
      // Trigger the fetch operation when switching to a specific index
      if (index == 4) {
        UserInformation userInformation = await fetchSpecificOrderDetails(userId);
        writeUserInformationIntoController(userInformation);
      }
    });

    orderCollection = firestore.collection('userInformation');
    UserInformation userInformation = await fetchSpecificOrderDetails(userId);
    writeUserInformationIntoController(userInformation);
  }

  void applyUserInformation() {
    DocumentReference doc = orderCollection.doc(userId);
    UserInformation userInformation = UserInformation(
      userId: userId,
      email: email,
      name: nameController.text,
      age: int.parse(ageController.text),
      gender: selectedGender,
      race: selectedRace,
      phone: phoneController.text,
      firstTimeLogin: firstTimeLogin,
      isDriver: isDriver,
      carModel: carModelController.text,
      carPlate: carPlateController.text,
      online: online,
    );
    final userInformationJson = userInformation.toJson();
    doc.set(userInformationJson);
  }

    void applyNewUserInformation(UserInformation userInformation) {
    DocumentReference doc = orderCollection.doc(userId);
    UserInformation newUserInformation = userInformation;
    final newUserInformationJson = newUserInformation.toJson();
    doc.set(newUserInformationJson);
  }

  Future<UserInformation> fetchSpecificOrderDetails(String userId) async {
    try {
      if(firstFetch){
        isLoading(true);
      }
      DocumentReference doc = orderCollection.doc(userId);
      DocumentSnapshot snapshot = await doc.get();
      if(snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        UserInformation userInformation = UserInformation.fromJson(data);
        if(userInformation.firstTimeLogin == true) {
          Future.delayed(Duration.zero, showProfileCompletionFormDialog);
        }
        update();
        return userInformation;
      }else{
        UserInformation userInformation = UserInformation();
        userInformation.reset();
        userInformation.userId = userId;
        userInformation.email = email;
        applyNewUserInformation(userInformation);
        Future.delayed(Duration.zero, showProfileCompletionFormDialog);
        update();
        return userInformation;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
      firstFetch = false;
    }
  }

  void showProfileCompletionFormDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("First Time Login", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Please complete your profile 352 proceeding.'),
        actions: [
          TextButton(
            onPressed: () {
              currentIndex.value = 4; 
              Get.back();
            },// Close the dialog
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false, // Optional: Prevent closing by tapping outside
    );
  }

  writeUserInformationIntoController(UserInformation userInformation) {
    emailController.text = email;
    nameController.text = userInformation.name!;
    if(userInformation.age != 0) {
      ageController.text = userInformation.age!.toString();
    }else{
      ageController.text = "";
    }
    selectedGender = userInformation.gender;
    selectedRace = userInformation.race;
    phoneController.text = userInformation.phone!;
    firstTimeLogin = userInformation.firstTimeLogin;
    isDriver = userInformation.isDriver;
    carModelController.text = userInformation.carModel!;
    carPlateController.text = userInformation.carPlate!;
    online = userInformation.online;
  }
}