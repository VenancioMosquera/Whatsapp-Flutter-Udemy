import 'package:flutter/material.dart';

class ContactsTab extends StatefulWidget {
  ContactsTab({Key? key}) : super(key: key);

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Contatos"),
    );
  }
}
