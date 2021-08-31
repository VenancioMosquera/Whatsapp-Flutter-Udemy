import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/shared/models/user_model.dart';
import 'package:whatsapp_flutter/shared/service_locator.dart';

class FirebaseController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _database = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  UserModel _user = userGetIt<UserModel>();
  User? _currentUser;

  Future userSignUp() async {
    String? firebaseSignUpResult;

    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _user.email!, password: _user.password!)
          .then((firebaseUser) {
        firebaseSignUpResult = "Success";
        _database
            .collection("Users")
            .doc(firebaseUser.user!.uid)
            .set(_user.toMap());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        firebaseSignUpResult = "Senha fraca";
      } else if (e.code == "email-already-in-use") {
        firebaseSignUpResult = "Esse e-mail já está registrado";
      } else if (e.code == "invalid-email") {
        firebaseSignUpResult = "E-mail inválido";
      }
    } catch (e) {
      firebaseSignUpResult =
          "Erro desconhecido. Favor contacte o administrador.";
      print(e);
    }
    return firebaseSignUpResult;
  }

  Future<String> checkUserSignedIn(BuildContext context) async {
    _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      await _database
          .collection("Users")
          .doc(_currentUser!.uid)
          .get()
          .then((snapshot) {
        Map<String, dynamic> data = snapshot.data()!;
        _user.name = data['name'];
        _user.email = data['e-mail'];
        _user.id = _currentUser!.uid;
        if (data.containsKey('pictureUrl')) {
          _user.pictureUrl = data['pictureUrl'];
        }
      });
      return '/homePage';
    } else {
      return '/loginPage';
    }
  }

  Future userSignIn() async {
    String firebaseSignInResult = "";

    try {
      await _auth
          .signInWithEmailAndPassword(
              email: _user.email!, password: _user.password!)
          .then((value) async {
        firebaseSignInResult = "Success";

        _currentUser = _auth.currentUser!;
        await _database
            .collection("Users")
            .doc(_currentUser!.uid)
            .get()
            .then((snapshot) {
          Map<String, dynamic> data = snapshot.data()!;
          _user.name = data['name'];
          _user.email = data['e-mail'];
          _user.id = _currentUser!.uid;
          if (data.containsKey('pictureUrl')) {
            _user.pictureUrl = data['pictureUrl'];
          }
        });
      });
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

  Future<bool?> updateUserData(String nameEC, [String? imagePath]) async {
    bool? statusCompleted;
    try {
      switch (imagePath != null) {
        case true:
          Reference rootFolder = _storage.ref();
          Reference userPicture =
              rootFolder.child("profile").child("${_user.id}.jpg");

          TaskSnapshot snapshot = await userPicture.putFile(File(imagePath!));

          _user.pictureUrl = await snapshot.ref.getDownloadURL();
          final updateDatabasePictureUrl = _database
              .collection("Users")
              .doc(_user.id)
              .update({'pictureUrl': _user.pictureUrl});

          final updateDatabaseName = _database
              .collection("Users")
              .doc(_user.id)
              .update({'name': nameEC});

          final results =
              await Future.wait([updateDatabasePictureUrl, updateDatabaseName])
                  .then((value) {
            _user.name = nameEC;
            statusCompleted = true;
          });
          return statusCompleted;
        case false:
          final updateDatabaseName = _database
              .collection("Users")
              .doc(_user.id)
              .update({'name': nameEC});

          final results = await Future.wait([updateDatabaseName]).then((value) {
            _user.name = nameEC;
            statusCompleted = true;
          });
          return statusCompleted;
      }
    } catch (e) {
      print(e);
      return statusCompleted = false;
    }
  }

  signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
  }
}
