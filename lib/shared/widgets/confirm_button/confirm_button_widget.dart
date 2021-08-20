import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String ButtonText;
  final VoidCallback onPressed;

  const ConfirmButtonWidget(
      {Key? key, required this.ButtonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          ButtonText,
          style: TextStyle(color: AppColors.textInfo, fontSize: 17),
        ),
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.fromLTRB(32, 18, 32, 18)),
          backgroundColor: MaterialStateProperty.all(
            AppColors.loginButton,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}
