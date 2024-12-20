import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phonebook_app/models/contact_model.dart';

class PhoneBookInsertWidget extends StatefulWidget {
  const PhoneBookInsertWidget({super.key});

  @override
  State<PhoneBookInsertWidget> createState() => _PhoneBookInsertWidgetState();
}

class _PhoneBookInsertWidgetState extends State<PhoneBookInsertWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _profileImgController = TextEditingController();

  final ContactModel _contactModel = ContactModel();
  String? _profileImagePath;

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
        _profileImgController.text = image.path;
      });
    }
  }

  void _registContact() async {
    Map<String, dynamic> phoneBookData = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'image': _profileImgController.text, // 이미지 경로 전송
    };

    try {
      String result = await _contactModel.insertMenu(phoneBookData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "이름"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: "번호"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _profileImgController,
            decoration: InputDecoration(labelText: "이미지"),
          ),
          SizedBox(height: 10),
          // 이미지 미리보기
          _profileImagePath != null
              ? Image.file(File(_profileImagePath!)) // 선택된 이미지 표시
              : Container(),
          ElevatedButton(
            onPressed: _pickImage, // 이미지 선택 버튼
            child: Text("프로필 이미지 선택하기"),
          ),
          ElevatedButton(onPressed: _registContact, child: Text("연락처 등록하기"))
        ],
      ),
    );
  }
}
