import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((_)=>AuthRepository());

abstract class IAuthRepository {
  Future<void> signIn(String email, String password);

  Future<void> signUp(
      String name, String surname, String email, String password);
}
