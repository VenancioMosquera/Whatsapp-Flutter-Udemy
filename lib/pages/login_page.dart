import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:validatorless/validatorless.dart';
import 'package:whatsapp_flutter/shared/models/user_model.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  UserModel user = GetIt.instance.get<UserModel>();
  String? _firebaseSignInResult;

  Future _userSignIn(UserModel user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String firebaseSignInResult = "";

    try {
      await auth
          .signInWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((value) => firebaseSignInResult = "Success");
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        firebaseSignInResult = "E-mail inválido";
      } else if (e.code == "user-not-found") {
        firebaseSignInResult = "E-mail não encontrado";
      } else if (e.code == "wrong-password") {
        firebaseSignInResult = "Senha inválida";
      }
    } catch (e) {
      firebaseSignInResult =
          "Erro desconhecido. Favor contacte o administrador.";
      print(e);
    }
    return firebaseSignInResult;
  }

  _validatorEmail(String? firebaseSignInResult) {
    if (firebaseSignInResult == "E-mail inválido" ||
        firebaseSignInResult == "E-mail não encontrado") {
      return true;
    } else {
      return false;
    }
  }

  _validatorPassword(String? firebaseSignInResult) {
    if (firebaseSignInResult == "Senha inválida") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                        controller: _emailEC,
                        validator: (value) =>
                            _validatorEmail(_firebaseSignInResult)
                                ? "E-mail inválido"
                                : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InputTextWidget(
                        hintText: "Senha",
                        obscureText: true,
                        textInputType: TextInputType.text,
                        controller: _passwordEC,
                        validator: (value) =>
                            _validatorPassword(_firebaseSignInResult)
                                ? "Senha inválida"
                                : null,
                      ),
                    ),
                    ConfirmButtonWidget(
                      ButtonText: "Entrar",
                      onPressed: () {
                        user.email = _emailEC.text;
                        user.password = _passwordEC.text;
                        _userSignIn(user).then((value) {
                          _firebaseSignInResult = value;
                          if (_firebaseSignInResult == "Success") {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false);
                          } else {
                            print(_firebaseSignInResult);
                            _formKey.currentState?.validate();
                          }
                        });
                      },
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
      ),
    );
  }
}
