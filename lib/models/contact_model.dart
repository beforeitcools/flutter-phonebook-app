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
}