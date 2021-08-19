import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

class InputTextWidget extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;

  const InputTextWidget(
      {Key? key,
      required this.hintText,
      required this.obscureText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: AppColors.inputField,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: AppColors.accent),
        ),
      ),
      obscureText: obscureText,
      obscuringCharacter: "*",
      keyboardType: textInputType,
      style: TextStyle(fontSize: 17),
    );
  }
}
