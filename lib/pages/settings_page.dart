import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validatorless/validatorless.dart';
import 'package:whatsapp_flutter/shared/firebase/firebase_controller.dart';
import 'package:whatsapp_flutter/shared/models/user_model.dart';
import 'package:whatsapp_flutter/shared/service_locator.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';
import 'package:whatsapp_flutter/shared/widgets/confirm_button/confirm_button_widget.dart';
import 'package:whatsapp_flutter/shared/widgets/input_text/input_text_widget.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  ImagePicker _picker = ImagePicker();
  XFile? _image;
  TextEditingController _nameEC = TextEditingController();
  ImageProvider? _backgroundImage;
  UserModel _user = userGetIt<UserModel>();
  FirebaseController firebaseController =
      firebaseControllerGetIt<FirebaseController>();
  String? _updateType;

  Future _setNewImage(bool fromCamera) async {
    XFile? selectedImage;
    if (fromCamera) {
      selectedImage = await _picker.pickImage(source: ImageSource.camera);
    } else {
      selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    }

    _image = selectedImage;
    _imageProvider();
  }

  _getUserData() async {
    _nameEC.text = _user.name!;
    _imageProvider();
  }

  _imageProvider() async {
    if (_image != null) {
      setState(() {
        _backgroundImage = FileImage(File(_image!.path));
      });
      return null;
    } else if (_user.pictureUrl != null) {
      setState(() {
        _backgroundImage = NetworkImage(_user.pictureUrl!);
      });
      return null;
    } else {
      return null;
    }
  }

  _updateUserDataResult([bool? updateResult]) {
    switch (updateResult) {
      case true:
        Fluttertoast.showToast(
          msg: "Dados atualizados com sucesso",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );
        break;
      case false:
        Fluttertoast.showToast(
          msg: "Erro ao atualizar dados",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );
        break;
      default:
        Fluttertoast.showToast(
          msg: "Carregando alterações",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.tertiary,
                    backgroundImage: _backgroundImage,
                    maxRadius: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            _setNewImage(true);
                          },
                          child: Text("Câmera"),
                        ),
                        TextButton(
                          onPressed: () {
                            _setNewImage(false);
                          },
                          child: Text("Galeria"),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InputTextWidget(
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
                  ConfirmButtonWidget(
                    buttonText: "Salvar",
                    onPressed: () async {
                      var formValid = _formKey.currentState?.validate();
                      if (formValid == true) {
                        _updateUserDataResult();
                        if (_image != null) {
                          await firebaseController
                              .updateUserData(_nameEC.text, _image!.path)
                              .then((updateResult) {
                            _updateUserDataResult(updateResult!);
                          });
                        } else {
                          await firebaseController
                              .updateUserData(_nameEC.text)
                              .then((updateResult) {
                            _updateUserDataResult(updateResult!);
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
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
