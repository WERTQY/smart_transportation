import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_transportation/components/generic/styled_button.dart';
import 'package:smart_transportation/components/profile/profile_button.dart';
import 'package:smart_transportation/components/profile/profile_textfield.dart';
import 'package:smart_transportation/pages/driver/driver_home.dart';
import 'package:smart_transportation/components/profile/profile_controller.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  ProfileController profileController = Get.find();

  bool showPersonalInfo = false;
  String? ageError;
  String? phoneNumberError;

  @override
  void initState() {
    super.initState();

    profileController.fetchSpecificOrderDetails(profileController.userId);
  }

  void _switchToPassenger() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DriverHome()),
    );
  }

  void _toggleEditing() {
    setState(() {
      ageError = null;
      phoneNumberError = null;
    });
  }

  void _applyChanges() {
    setState(() {
      ageError = null;
      phoneNumberError = null;

      if (int.tryParse(profileController.ageController.text) == null) {
        ageError = 'Age can only have numbers';
      }

      if (int.tryParse(profileController.phoneController.text) == null) {
        phoneNumberError = 'Phone number can only have numbers';
      }

      if (ageError == null && phoneNumberError == null) {
        _togglePersonalInfo();
        profileController.firstTimeLogin = false;
        profileController.applyUserInformation();
      }
    });
  }

  void _cancelChanges() {
    setState(() {
      _togglePersonalInfo();
      ageError = null;
      phoneNumberError = null;
      profileController.fetchSpecificOrderDetails(profileController.userId);
    });
  }

  void _togglePersonalInfo() {
    setState(() {
      showPersonalInfo = !showPersonalInfo;
      _toggleEditing();
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showPersonalInfo
            ? const Text(
                "Edit Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 30),
              )
            : const Text(
                "Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 30),
              ),
        backgroundColor: Colors.black,
        leading: showPersonalInfo
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _cancelChanges();      
                  });
                },
              )
            : null,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            if (!showPersonalInfo) ...[
              const CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage('assets/img/profile_photo.jpg') as ImageProvider,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Hi, ${profileController.nameController.text}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTextField(
                icon: const Icon(Icons.mail),
                readOnly: true,
                controller: profileController.emailController,
                hintText: "",
                obscureText: false,
                canRequestFocus: false,
                prefixIconColor: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTextField(
                icon: const Icon(Icons.phone),
                readOnly: true,
                controller: profileController.phoneController,
                hintText: "",
                obscureText: false,
                canRequestFocus: false,
                prefixIconColor: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ProfileButton(
                  text: "Edit Profile",
                  onPressed: _togglePersonalInfo,
                  arrowIcon: Icons.edit,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ProfileButton(
                  text: "Settings",
                  onPressed: () {},
                  arrowIcon: Icons.settings,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ProfileButton(
                  text: "Switch To Driver",
                  onPressed: () {},
                  arrowIcon: Icons.drive_eta,
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ProfileButton(
                  text: "Logout",
                  onPressed: signUserOut,
                  textColor: Colors.red,
                  arrowIcon: Icons.logout,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
            if (showPersonalInfo) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  const SizedBox(height: 20),
                  _buildTextField('Name', profileController.nameController),
                  _buildTextField('Age', profileController.ageController,
                      inputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                  if (ageError != null)
                    Text(
                      ageError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    
                  _buildDropdownField('Gender', profileController.selectedGender == ''? null : profileController.selectedGender, [
                    'Male',
                    'Female'
                  ], (value) {
                    setState(() {
                      profileController.selectedGender = value;
                    });
                  }),
                  _buildDropdownField('Select Race', profileController.selectedRace == ''? null : profileController.selectedRace,
                      ['Malay', 'Chinese', 'India', 'Others'], (value) {
                    setState(() {
                      profileController.selectedRace = value;
                    });
                  }),
                  
                  _buildTextField('Phone Number', profileController.phoneController,
                      inputType: TextInputType.phone,),
                  if (phoneNumberError != null)
                    Text(
                      phoneNumberError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StyledButton(
                        onTap: _cancelChanges,
                        text: 'Cancel',
                      ),
                      StyledButton(
                        onTap: _applyChanges,
                        text: 'Apply',
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint),
            isDense: true,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
