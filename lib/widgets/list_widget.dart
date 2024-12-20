import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phonebook_app/models/contact_model.dart';
import 'package:phonebook_app/widgets/update_widget.dart';

class ContactListWidget extends StatefulWidget {
  bool searchTrigger;

  ContactListWidget({
    super.key,
    required this.searchTrigger,
  });

  @override
  State<ContactListWidget> createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {
  final ContactModel _contactModel = ContactModel();
  List<dynamic> _contacts = [];
  dynamic _selectedContact;
  late bool searchTrigger;

  @override
  void initState() {
    super.initState();
    _loadContacts();
    searchTrigger = widget.searchTrigger;
  }

  void _loadContacts() async {
    List<dynamic> contactData = await _contactModel.selectContact();
    setState(() {
      _contacts = contactData;
    });
  }

  void _deleteContact(Map<String, dynamic> contact) async {
    try {
      String result = await _contactModel.deleteContact(contact);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error : $e')));
    }
  }

  void _deleteDialog(Map<String, dynamic> contact) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("연락처 삭제"),
            content: Text("${contact['name']} 님의 연락처를 정말 삭제 하시겠습니까?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("취소")),
              TextButton(
                  onPressed: () {
                    _deleteContact(contact);
                    Navigator.pop(context);
                  },
                  child: Text("삭제")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
              child: _contacts.isEmpty
                  ? Center(child: Text("내 연락처 불러오는 중!"))
                  :
                  /*searchTrigger == true
                  ? TextField(

                  )*/
                  ListView.builder(
                      itemCount: _contacts.length,
                      itemBuilder: (context, i) {
                        final contact = _contacts[i];
                        return ListTile(
                            title: Text(contact["name"]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactDetailPage(
                                          name: contact["name"],
                                          phone: contact["phone"],
                                          profileImg:
                                              contact["profileImg"] ?? "")));
                            },
                            trailing: Wrap(children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateWidget(
                                                  contact: contact,
                                                )));
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    _deleteDialog(contact);
                                  },
                                  icon: Icon(Icons.delete)),
                            ]));
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

  const ContactDetailPage(
      {super.key,
      required this.name,
      required this.phone,
      required this.profileImg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: profileImg.isNotEmpty || profileImg != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                      imageUrl: profileImg,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 80,
                      ),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ))
                  : Icon(
                      Icons.person,
                      size: 80,
                    ),
            ),
            SizedBox(
              height: 16,
            ),
            Text("이름: $name"),
            SizedBox(
              height: 16,
            ),
            Text("번호: $phone")
          ],
        ),
      ),
    );
  }
}
