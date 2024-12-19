import 'dart:io';

import 'package:dio/dio.dart';

class ContactModel {
  //조회
  Future<List<dynamic>> selectContact() async {
    final dio = Dio();
    try {
      final response = await dio.get("http://localhost:8080/phonebook/select");

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
      Map<String, String> contactData, File? image) async {
    final dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'contactData': contactData,
        'image': image == null
            ? null
            : await MultipartFile.fromFile(
                image.path,
              ),
      });

      final response = await dio.post("http://localhost:8080/phonebook/update",
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));

      if (response.statusCode == 200) {
        return "연락처 수정 성공";
      } else {
        return "연락처 수정 실패";
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}
