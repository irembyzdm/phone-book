import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDetailsPage extends StatefulWidget {
  final Map<String, dynamic> userDetails;

  UserDetailsPage({required this.userDetails, Key? key}) : super(key: key);

  final phoneNumberFomatter = FilteringTextInputFormatter.digitsOnly;

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String? _editedImagePath;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userDetails["username"];
    _phoneNumberController.text = widget.userDetails["phonenumber"];
    _emailController.text = widget.userDetails["email"];
    _birthDateController.text = widget.userDetails["birthDate"];
  }

  void updateProfileData() {
    setState(() {
      widget.userDetails["username"] = _nameController.text;
      widget.userDetails["phonenumber"] = _phoneNumberController.text;
      widget.userDetails["email"] = _emailController.text;
      widget.userDetails["birthDate"] = _birthDateController.text;
      if (_editedImagePath != null) {
        widget.userDetails["imageURL"] = _editedImagePath!;
      }
    });
    Navigator.pop(context, widget.userDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Kişi Detayları"),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                backgroundImage:
                    AssetImage(widget.userDetails["imageURL"]) as ImageProvider,
                radius: 80,
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
              AbsorbPointer(
                child: TextField(
                  controller: _birthDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Doğum Tarihi (YYYY-AA-GG)",
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfileData,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 242, 131, 168)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                child: Text("Bilgileri Güncelle"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfileData,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 242, 131, 168)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                child: Text("Geri Dön"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}