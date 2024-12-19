import 'package:flutter/material.dart';
import 'package:phonebook_app/models/contact_model.dart';

class ContactListWidget extends StatefulWidget {
  const ContactListWidget({super.key});

  @override
  State<ContactListWidget> createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {

  final ContactModel _contactModel = ContactModel();
  List<dynamic> _contacts = [];
  dynamic _selectedContact;

  @override
  void initState(){
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async{
    List<dynamic> contactData = await _contactModel.selectContact();
    setState(() {
      _contacts = contactData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(child: _contacts.isEmpty ? Center(child: Text("내 연락처 불러오는 중!"))
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, i){
                final contact = _contacts[i];
                return ListTile(
                  title: Text(contact["name"]),
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactDetailPage(name: contact["name"], phone: contact["phone"], profileImg: contact["profileImg"]??"")));},
                  trailing: Wrap(
                      children: <Widget>[
                        IconButton(onPressed: (){/* 수정 로직 */}, icon: Icon(Icons.edit)),
                        IconButton(onPressed: (){/* 삭제 로직 */}, icon: Icon(Icons.delete)),
                      ]
                    )
                  );
              }))
        ],
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final String name;
  final String phone;
  final String profileImg;

  const ContactDetailPage({super.key, required this.name, required this.phone, required this.profileImg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("이름: $name"),
            Text("번호: $phone")
          ],
        ),),
    );
  }
}

