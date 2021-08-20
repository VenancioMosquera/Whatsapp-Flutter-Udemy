import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';
import 'package:whatsapp_flutter/shared/themes/app_images.dart';
import 'package:whatsapp_flutter/shared/widgets/confirm_button/confirm_button_widget.dart';
import 'package:whatsapp_flutter/shared/widgets/input_text/input_text_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                      AppImages.logoFull,
                      scale: 2,
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
                    ButtonText: "Entrar",
                    onPressed: () {},
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem conta?",
                        style: TextStyle(color: AppColors.textInfo),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signUpPage');
                        },
                        child: Text(
                          "Cadastre-se!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(AppColors.textInfo),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
