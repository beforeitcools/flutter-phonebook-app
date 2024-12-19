import 'package:dio/dio.dart';

class ContactModel{

  //조회
  Future<List<dynamic>> selectContact() async{
    final dio = Dio();
    try{
      final response = await dio.get("*");

      if(response.statusCode == 200){
        return response.data as List<dynamic>;
      }else{
        throw Exception("전화번호부 로드 실패");
      }
    }catch(e){
      print(e);
      throw Exception("Error: $e");
    }
  }

  // 연락처 등록
  Future<String> insertMenu(Map<String, dynamic> phoneBookData) async{
    final dio = Dio();

    try{
      final response = await dio.post("http://localhost:8080/phonbook/insert",
          data: phoneBookData
      );
      if (response.statusCode == 200){
        return "등록이 성공적으로 수행되었습니다.";
      } else {
        return "실패하였습니다.";
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

}

