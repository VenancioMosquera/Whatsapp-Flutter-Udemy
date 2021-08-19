import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';
import 'package:whatsapp_flutter/shared/themes/app_images.dart';
import 'package:whatsapp_flutter/shared/widgets/confirm_button/confirm_button_widget.dart';
import 'package:whatsapp_flutter/shared/widgets/input_text/input_text_widget.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  AppImages.userIcon,
                  scale: 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InputTextWidget(
                  hintText: "Nome",
                  obscureText: false,
                  textInputType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InputTextWidget(
                  hintText: "E-mail",
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InputTextWidget(
                  hintText: "Senha",
                  obscureText: true,
                  textInputType: TextInputType.text,
                ),
              ),
              ConfirmButtonWidget(
                ButtonText: "Cadastrar",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
