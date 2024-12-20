import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonebook_app/models/contact_model.dart';

class PhoneBookInsertWidget extends StatefulWidget {
  const PhoneBookInsertWidget({super.key});

  @override
  State<PhoneBookInsertWidget> createState() => _PhoneBookInsertWidgetState();
}

class _PhoneBookInsertWidgetState extends State<PhoneBookInsertWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final ContactModel _contactModel = ContactModel();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImagePickDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("사진 선택"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await _pickImageFromGallery();
                    Navigator.pop(context);
                  },
                  child: Text("갤러리에서 선택")),
              TextButton(
                  onPressed: () {
                    _pickImageFromCamera();
                    Navigator.pop(context);
                  },
                  child: Text("사진 촬영")),
            ],
          );
        });
  }

  void _registerContact() async {
    Map<String, dynamic> contactData = {
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
    };

    try {
      String result = await _contactModel.insertContact(contactData, _image);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("연락처 등록"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: _image != null
                  ? ClipOval(
                      child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ))
                  : Icon(
                      Icons.person,
                      size: 80,
                    ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  _showImagePickDialog();
                },
                child: Text("프로필 사진 수정")),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "이름"),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "전화번호"),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: _registerContact, child: Text("연락처 등록"))
          ],
        ),
      ),
    );
  }
}
