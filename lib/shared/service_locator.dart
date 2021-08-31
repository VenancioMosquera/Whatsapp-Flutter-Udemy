import 'package:get_it/get_it.dart';
import 'package:whatsapp_flutter/shared/firebase/firebase_controller.dart';
import 'package:whatsapp_flutter/shared/models/user_model.dart';

final GetIt userGetIt = GetIt.instance;
final GetIt firebaseControllerGetIt = GetIt.instance;

void setup() {
  userGetIt.registerLazySingleton(() => UserModel());
  firebaseControllerGetIt.registerLazySingleton(() => FirebaseController());
}
