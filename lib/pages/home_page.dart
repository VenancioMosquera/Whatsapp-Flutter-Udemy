import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/pages/tabs/chats_tab.dart';
import 'package:whatsapp_flutter/pages/tabs/contacts_tab.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _tabController;

  List<String> popUpMenuItems = ["Configurações", "Deslogar"];

  _popUpMenuItemSelected(String itemSelected) {
    switch (itemSelected) {
      case "Configurações":
        print("Configurações");
        break;
      case "Deslogar":
        _signOut();
        break;
    }
  }

  _signOut() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.textInfo,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          indicatorWeight: 4,
          indicatorColor: AppColors.secondary,
          tabs: [
            Tab(
              text: "Conversas",
            ),
            Tab(
              text: "Contatos",
            )
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _popUpMenuItemSelected,
            itemBuilder: (context) {
              return popUpMenuItems.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatsTab(),
          ContactsTab(),
        ],
      ),
    );
  }
}
