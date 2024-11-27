import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:smart_transportation/driver/driver_nagivation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class PassengerProfile extends StatefulWidget {
  const PassengerProfile({super.key});

  @override
  State<PassengerProfile> createState() => _PassengerProfileState();
}

class _PassengerProfileState extends State<PassengerProfile> {
  bool isEditing = false;
  bool showPersonalInfo = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();

  String? selectedRace;
  String? selectedReligion;

  String? ageError;
  String? phoneNumberError;

  // Variables to store original values
  String? originalName;
  String? originalAge;
  String? originalPhoneNumber;
  String? originalEmail;
  String? originalHomeAddress;
  String? originalRace;
  String? originalReligion;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.ref();
  }

  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void _handleButtonTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DriverHomeNavigationBar()),
    );
  }

  void _toggleEditing() {
    setState(() {
      if (isEditing) {
        // Save changes
        originalName = nameController.text;
        originalAge = ageController.text;
        originalPhoneNumber = phoneNumberController.text;
        originalEmail = emailController.text;
        originalHomeAddress = homeAddressController.text;
        originalRace = selectedRace;
        originalReligion = selectedReligion;
      } else {
        // Start editing
        nameController.text = originalName ?? '';
        ageController.text = originalAge ?? '';
        phoneNumberController.text = originalPhoneNumber ?? '';
        emailController.text = originalEmail ?? '';
        homeAddressController.text = originalHomeAddress ?? '';
        selectedRace = originalRace;
        selectedReligion = originalReligion;
      }
      isEditing = !isEditing;
      ageError = null;
      phoneNumberError = null;
    });
  }

  void _applyChanges() {
    setState(() {
      ageError = null;
      phoneNumberError = null;

      if (int.tryParse(ageController.text) == null) {
        ageError = 'Age can only have numbers';
      }

      if (int.tryParse(phoneNumberController.text) == null) {
        phoneNumberError = 'Phone number can only have numbers';
      }

      if (ageError == null && phoneNumberError == null) {
        isEditing = false;
        // Save changes to the profile
        originalName = nameController.text;
        originalAge = ageController.text;
        originalPhoneNumber = phoneNumberController.text;
        originalEmail = emailController.text;
        originalHomeAddress = homeAddressController.text;
        originalRace = selectedRace;
        originalReligion = selectedReligion;

        _updateProfileInDatabase();
      }
    });
  }

  void _updateProfileInDatabase() {
    _databaseReference.child('passenger_profile').set({
      'Name': nameController.text,
      'Age': ageController.text,
      'Phone_Number': phoneNumberController.text,
      'Email': emailController.text,
      'Home_Address': homeAddressController.text,
      'Race': selectedRace,
      'Religion': selectedReligion,
    });
  }

  void _cancelChanges() {
    setState(() {
      isEditing = false;
      ageError = null;
      phoneNumberError = null;
      // Revert changes to the profile
      nameController.text = originalName ?? '';
      ageController.text = originalAge ?? '';
      phoneNumberController.text = originalPhoneNumber ?? '';
      emailController.text = originalEmail ?? '';
      homeAddressController.text = originalHomeAddress ?? '';
      selectedRace = originalRace;
      selectedReligion = originalReligion;
    });
  }

  void _togglePersonalInfo() {
    setState(() {
      showPersonalInfo = !showPersonalInfo;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blue,
        leading: showPersonalInfo
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _togglePersonalInfo,
              )
            : null,
        actions: [
          if (!showPersonalInfo)
            const Text(
              "Switch to Driver",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          if (!showPersonalInfo)
            IconButton(
              icon: const Icon(Icons.compare_arrows_rounded),
              color: Colors.white,
              iconSize: 30,
              onPressed: _handleButtonTap,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!showPersonalInfo) ...[
              GestureDetector(
                onTap: isEditing ? _pickImage : null,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/profile_photo.png')
                          as ImageProvider,
                  child: isEditing
                      ? const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Hi, ${nameController.text.isEmpty ? 'user' : nameController.text}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _togglePersonalInfo,
                child: const Text('Personal Information'),
              ),
            ],
            if (showPersonalInfo) ...[
              const SizedBox(height: 20),
              _buildTextField('Name', nameController),
              _buildTextField('Age', ageController,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              if (ageError != null)
                Text(
                  ageError!,
                  style: const TextStyle(color: Colors.red),
                ),
              _buildDropdownField('Select Race', selectedRace,
                  ['Malay', 'Chinese', 'India', 'Others'], (value) {
                setState(() {
                  selectedRace = value;
                });
              }),
              _buildDropdownField('Select Religion', selectedReligion,
                  ['Buddha', 'Christian', 'Hindu', 'Islam', 'Others'], (value) {
                setState(() {
                  selectedReligion = value;
                });
              }),
              _buildTextField('Phone Number', phoneNumberController,
                  inputType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              if (phoneNumberError != null)
                Text(
                  phoneNumberError!,
                  style: const TextStyle(color: Colors.red),
                ),
              _buildTextField('Email', emailController,
                  inputType: TextInputType.emailAddress),
              _buildTextField('Home Address', homeAddressController),
              const SizedBox(height: 20),
              if (isEditing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _applyChanges,
                      child: const Text('Apply'),
                    ),
                    ElevatedButton(
                      onPressed: _cancelChanges,
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              if (!isEditing)
                ElevatedButton(
                  onPressed: _toggleEditing,
                  child: const Text('Edit Profile'),
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
        enabled: isEditing,
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
            onChanged: isEditing ? onChanged : null,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
