import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';
import 'package:whatsapp_flutter/shared/themes/app_images.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _checkUserSignedIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = await auth.currentUser;
    await Future.delayed(Duration(seconds: 2));

    if (currentUser != null) {
      return Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      return Navigator.pushNamedAndRemoveUntil(
          context, '/loginPage', (route) => false);
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkUserSignedIn();
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logoFull,
              scale: 1.3,
            ),
            CircularProgressIndicator(
              color: AppColors.appBarButton,
            ),
          ],
        ),
      ),
    );
  }
}
