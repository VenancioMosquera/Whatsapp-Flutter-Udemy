import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;

  const ConfirmButtonWidget(
      {Key? key, required this.buttonText, required this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
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
