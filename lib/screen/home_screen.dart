import 'package:flutter/material.dart';
import 'package:phonebook_app/widgets/insert_widget.dart';
import 'package:phonebook_app/widgets/list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searchTrigger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Phone Book"),
        // backgroundColor: Colors.grey,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  searchTrigger = true;
                });
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhoneBookInsertWidget()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ContactListWidget(searchTrigger: searchTrigger),
    );
  }
}
