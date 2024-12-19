import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Phone Book"),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "번호검색"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "번호등록"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "번호수정"),
            BottomNavigationBarItem(icon: Icon(Icons.delete), label: "번호삭제"),
          ]),
    );
  }
}
