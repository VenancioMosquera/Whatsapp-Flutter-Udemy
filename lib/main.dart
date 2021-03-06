import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/Pages/login_page.dart';
import 'package:whatsapp_flutter/pages/home_page.dart';
import 'package:whatsapp_flutter/pages/settings_page.dart';
import 'package:whatsapp_flutter/pages/signup_page.dart';
import 'package:whatsapp_flutter/pages/splash_page.dart';
import 'package:whatsapp_flutter/shared/service_locator.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: AppColors.primary,
      accentColor: AppColors.accent,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/splashPage',
    routes: {
      '/splashPage': (context) => SplashPage(),
      '/homePage': (context) => HomePage(),
      '/loginPage': (context) => LoginPage(),
      '/signUpPage': (context) => SignUpPage(),
      '/settingsPage': (context) => SettingsPage(),
    },
  ));
}
