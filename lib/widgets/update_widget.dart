import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonebook_app/models/contact_model.dart';

class UpdateWidget extends StatefulWidget {
  final dynamic contact;

  const UpdateWidget({
    super.key,
    required this.contact,
  });

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {
  late dynamic contact;
  final ContactModel _contactModel = ContactModel();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("갤러리에서 선택")),
              TextButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("사진 촬영")),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    contact = widget.contact;

    if (contact['profile_img'] == null) {
      contact['profile_img'] = "null";
    }

    _nameController.text = contact['name'];
    _phoneController.text = contact['phone'];
  }

  void _updateContact() async {
    Map<String, String> contactData = {
      'id': contact['id'],
      'name': _nameController.text,
      'phone': _phoneController.text
    };

    try {
      String result = await _contactModel.updateContact(contactData, _image);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _image == null
                  ? CachedNetworkImageProvider(contact['profile_img'])
                  : CachedNetworkImageProvider(_image!.path),
              child: CachedNetworkImage(
                imageUrl:
                    _image == null ? contact['profile_img'] : _image!.path,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: 80,
                ),
                // Image.asset("assets/anonymous_person.png"),
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
                decoration: InputDecoration(labelText: "전화번호"),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: _updateContact, child: Text("연락처 수정"))
          ],
        ),
      ),
    );
  }
}
