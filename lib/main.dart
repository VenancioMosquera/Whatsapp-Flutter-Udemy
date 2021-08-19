import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/Pages/login_page.dart';
import 'package:whatsapp_flutter/pages/home_page.dart';
import 'package:whatsapp_flutter/pages/signup_page.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: AppColors.primary,
      accentColor: AppColors.accent,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/loginPage',
    routes: {
      '/': (context) => HomePage(),
      '/loginPage': (context) => LoginPage(),
      '/signUpPage': (context) => SignUpPage(),
    },
  ));
}
