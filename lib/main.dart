import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/Pages/home_page.dart';
import 'package:whatsapp_flutter/Pages/login_page.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: LoginPage(),
    theme: ThemeData(
      primaryColor: AppColors.primary,
      accentColor: AppColors.accent,
    ),
    debugShowCheckedModeBanner: false,
  ));
}
