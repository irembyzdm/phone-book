import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:phone_book_app/home_page.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> profileData;

  ProfilePage({required this.profileData, Key? key}) : super(key: key);

  final phoneNumberFomatter = FilteringTextInputFormatter.digitsOnly;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String? _editedImagePath;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profileData["username"];
    _phoneNumberController.text = widget.profileData["phonenumber"];
    _emailController.text = widget.profileData["email"];
    _birthDateController.text = widget.profileData["birthDate"];
  }

  void updateProfileData() {
    setState(() {
      widget.profileData["username"] = _nameController.text;
      widget.profileData["phonenumber"] = _phoneNumberController.text;
      widget.profileData["email"] = _emailController.text;
      widget.profileData["birthDate"] = _birthDateController.text;
      if (_editedImagePath != null) {
        widget.profileData["imageURL"] = _editedImagePath!;
      }
    });
    Navigator.pop(context, widget.profileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil Sayfası",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  _editedImagePath = await pickImageFromGallery();
                  setState(() {});
                },
                child: CircleAvatar(
                  backgroundImage: _editedImagePath != null
                      ? FileImage(File(_editedImagePath!))
                      : AssetImage(widget.profileData["imageURL"])
                          as ImageProvider,
                  radius: 80,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "İsim-Soyisim"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneNumberController,
                inputFormatters: [widget.phoneNumberFomatter],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Telefon Numarası"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "E-posta Adresi"),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final DateTime? selectedBirthDate =
                      await _selectBirthDate(context);
                  if (selectedBirthDate != null) {
                    _birthDateController.text =
                        "${selectedBirthDate.year}-${selectedBirthDate.month.toString().padLeft(2, '0')}-${selectedBirthDate.day.toString().padLeft(2, '0')}";
                    setState(() {});
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: _birthDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Doğum Tarihi (YYYY-AA-GG)",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.profileData["username"] = _nameController.text;
                    widget.profileData["phonenumber"] =
                        _phoneNumberController.text;
                    widget.profileData["email"] = _emailController.text;
                    widget.profileData["birthDate"] = _birthDateController.text;
                    if (_editedImagePath != null) {
                      widget.profileData["imageURL"] = _editedImagePath!;
                    }
                  });
                  updateProfileData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 242, 131, 168),
                ),
                child: Text(
                  "Güncelle",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return pickedDate;
  }

  Future<String?> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return pickedImage.path;
    } else {
      return null;
    }
  }
}
