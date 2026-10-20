import 'package:creddinv_task/data/models/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> login({required String email, required String password});
}
