import 'package:flutter/material.dart';

class ChatsTab extends StatefulWidget {
  ChatsTab({Key? key}) : super(key: key);

  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Conversas"),
    );
  }
}
