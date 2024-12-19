import 'package:flutter/material.dart';
import 'package:phonebook_app/models/contact_model.dart';
import 'package:phonebook_app/widgets/update_widget.dart';

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
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
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
          Expanded(
              child: _contacts.isEmpty
                  ? Center(child: Text("내 연락처 불러오는 중!"))
                  : ListView.builder(
                      itemCount: _contacts.length,
                      itemBuilder: (context, i) {
                        final contact = _contacts[i];
                        return ListTile(
                          title: Text(contact["name"]),
                          onTap: () {},
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                  onPressed: () {}, icon: Icon(Icons.delete)),
                            ],
                          ),
                        );
                      }))
        ],
      ),
    );
  }
}
