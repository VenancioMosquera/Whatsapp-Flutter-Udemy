import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/firebase/firebase_controller.dart';
import 'package:whatsapp_flutter/shared/service_locator.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';
import 'package:whatsapp_flutter/shared/themes/app_images.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseController firebaseController =
      firebaseControllerGetIt<FirebaseController>();

  @override
  Widget build(BuildContext context) {
    firebaseController.checkUserSignedIn(context).then((nextPage) =>
        Navigator.pushNamedAndRemoveUntil(context, nextPage, (route) => false));
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
          ],
        ),
      ),
    );
  }
}
