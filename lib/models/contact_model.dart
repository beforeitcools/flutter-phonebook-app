import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class ContactModel {
  //조회
  Future<List<dynamic>> selectContact() async {
    final dio = Dio();

    try {
      final response =
          await dio.get("http://112.221.66.174:1102/phonebook/select");

      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception("전화번호부 로드 실패");
      }
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }

  // 수정
  Future<String> updateContact(
      Map<String, dynamic> contactData, File? image) async {
    final dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'contactData': jsonEncode(contactData),
        'image': image == null
            ? null
            : await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              ),
      });

      final response = await dio.post(
          "http://112.221.66.174:1102/phonebook/update",
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));

      if (response.statusCode == 200) {
        return "연락처 수정 성공";
      } else {
        return "연락처 수정 실패";
      }
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }

  // 삭제
  Future<String> deleteContact(Map<String, dynamic> contact) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        "http://112.221.66.174:1102/phonebook/delete",
        data: contact,
      );
      if (response.statusCode == 200) {
        return "연락처 삭제 성공";
      } else {
        return "연락처 삭제 실패";
      }
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }

  // 연락처 등록
  Future<String> insertContact(
      Map<String, dynamic> contactData, File? image) async {
    final dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        'contactData': jsonEncode(contactData),
        'image': image == null
            ? null
            : await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              ),
      });

      final response = await dio.post(
          "http://112.221.66.174:1102/phonebook/insert",
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));

      if (response.statusCode == 200) {
        return "연락처 등록 성공.";
      } else {
        return "연락처 등록 실패.";
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}
