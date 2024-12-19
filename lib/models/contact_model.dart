import 'package:dio/dio.dart';











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