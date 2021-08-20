import 'package:get_it/get_it.dart';
import 'package:whatsapp_flutter/shared/models/user_model.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => UserModel());
}
