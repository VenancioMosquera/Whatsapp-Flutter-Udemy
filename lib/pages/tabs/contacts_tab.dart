import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/models/chat_model.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

class ContactsTab extends StatefulWidget {
  ContactsTab({Key? key}) : super(key: key);

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  List<Chat> chatsList = [
    Chat("Isabela", "oi", ""),
    Chat("Leonardo", "XERO DE PENEU KEMADO", ""),
    Chat("Bruna", "tochete", ""),
    Chat("Victor", "fon", ""),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatsList.length,
      itemBuilder: (context, index) {
        Chat chat = chatsList[index];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: AppColors.tertiary,
            backgroundImage: NetworkImage(chat.pictureURL),
          ),
          title: Text(
            chat.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );
      },
    );
  }
}
