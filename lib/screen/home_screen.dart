import 'package:flutter/material.dart';
import 'package:phonebook_app/widgets/list_widget.dart';

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
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: (){/* 검색? */}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){/* 연락처 추가 로직 */}, icon: Icon(Icons.add))
        ],
      ),
      body: ContactListWidget(),
    );
  }
}
