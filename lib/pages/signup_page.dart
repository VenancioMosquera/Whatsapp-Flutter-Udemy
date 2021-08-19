import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _passwordConfirmationEC = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _passwordConfirmationEC.dispose();
    super.dispose();
  }

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
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
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
                      controller: _nameEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Esse campo é obrigatório"),
                        Validatorless.min(
                            3, "O nome precisa ter mais do que 2 caracteres")
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InputTextWidget(
                      hintText: "E-mail",
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Esse campo é obrigatório"),
                        Validatorless.email("E-mail inválido"),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InputTextWidget(
                      hintText: "Senha",
                      obscureText: true,
                      textInputType: TextInputType.text,
                      controller: _passwordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required(
                            "Sua senha deve ter ao menos 6 caracteres"),
                        Validatorless.min(
                            6, "Sua senha deve ter ao menos 6 caracteres"),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InputTextWidget(
                      hintText: "Confirme sua senha",
                      obscureText: true,
                      textInputType: TextInputType.text,
                      controller: _passwordConfirmationEC,
                      validator: Validatorless.compare(
                          _passwordEC, "As senhas devem ser iguais"),
                    ),
                  ),
                  ConfirmButtonWidget(
                    ButtonText: "Cadastrar",
                    onPressed: () {
                      var formValid = _formKey.currentState?.validate();
                      if (formValid == true) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
